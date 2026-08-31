# Project Instructions

## Project Snapshot

- Project name: `maher`
- Flutter app version: `0.1.0+1`
- Dart SDK constraint: `^3.11.1`
- Resolved SDKs from `pubspec.lock`:
  - Dart: `>=3.11.1 <4.0.0`
  - Flutter: `>=3.41.0`
- Default production app entry: `lib/main.dart`
- Flavor app entries:
  - `lib/main_development.dart`
  - `lib/main_staging.dart`
  - `lib/main_production.dart`
- First Flutter screen after app launch: `AuthGateView`
- Startup navigation:
  - if `PrefKeys.isUserLoggedIn == true`, go to `RecordMeetingView`
  - otherwise, go to `LoginView`

## Environment And Networking

The project uses a small `BuildConfig` flavor layer, following the referenced
CTS-style environment pattern without copying its endpoint list.

Flavor entrypoints:

```text
lib/main.dart              -> production default
lib/main_development.dart  -> Flavor.development
lib/main_staging.dart      -> Flavor.staging
lib/main_production.dart   -> Flavor.production
```

`lib/main.dart` exposes `bootstrap(Flavor flavor)` so every environment uses
the same Flutter, localization, shared preferences, and foreground-task
startup path.

Current base URL:

```dart
BuildConfig.of().baseURL = 'https://zk.com/'
```

Current endpoint constants are intentionally minimal:

```dart
RemoteURLs.loginByGoogle = 'login/loginByGoogle'
RemoteURLs.loginByMicrosoft = 'login/loginByMicrosoft'
```

`RemoteURLs.loginPath`, `logoutPath`, and `refreshTokenPath` are also kept
because the token interceptor needs auth-exempt path checks.

`EndPoints.*` currently contains only placeholder `example` values so the
generated/example data source still analyzes cleanly without restoring the old
copied endpoint list.

`BaseDio` now reads its base URL from `BuildConfig.of().baseURL` and sets
default JSON headers:

```text
Accept: application/json
Content-Type: application/json
```

The token-refresh retry Dio in `ValidateTokenInterceptor` uses the same base
URL and JSON headers so retried authenticated requests behave like normal
network-service requests.

Development-like flavors enable Dio's built-in `LogInterceptor`, but request
and response bodies are disabled so Google tokens and sensitive payloads are
not printed during normal debugging.

## Architecture

The project uses a feature-first Flutter structure inspired by clean architecture:

```text
lib/
  core/
    base_response/
    data/network/
    network/
    services/
    use_cases/
  features/
    example/
      data/
      domain/
      presentation/
    auth/
      data/
      domain/
      presentation/
    record_meeting/
      data/
      domain/
      presentation/
```

Feature layers:

- `data`: API/data source/models/repository implementation.
- `domain`: entities, repository contracts, use cases.
- `presentation`: screens, widgets, cubits/states.

Current `record_meeting` intentionally has only presentation logic. `auth` now
has data/domain/presentation layers because Google login includes a backend API
post.

## Current Auth Feature

Feature root:

```text
lib/features/auth/
```

Current important files:

```text
auth.dart
config/auth_google_config.dart
config/auth_microsoft_config.dart
data/data.dart
data/datasource/datasource.dart
data/datasource/remote/auth_remote_datasource.dart
data/datasource/remote_impl/auth_remote_datasource_impl.dart
data/models/google_login_request_model.dart
data/models/microsoft_login_request_model.dart
data/models/models.dart
data/repositories/auth_repo_impl.dart
data/repositories/repositories.dart
domain/domain.dart
domain/entities/entities.dart
domain/entities/google_login_request_entity.dart
domain/entities/microsoft_login_request_entity.dart
domain/repositories/auth_repo.dart
domain/repositories/repositories.dart
domain/usecases/login_by_google_use_case.dart
domain/usecases/login_by_microsoft_use_case.dart
domain/usecases/usecases.dart
presentation/presentation.dart
presentation/screens/auth_gate_view.dart
presentation/screens/login_view.dart
presentation/screens/screens.dart
presentation/services/google_auth_service.dart
presentation/services/microsoft_auth_service.dart
presentation/widget/login_with_google.dart
presentation/widget/login_with_microsoft.dart
presentation/widget/widget.dart
presentation/cubit/cubit.dart
presentation/cubit/login_by_google_cubit.dart
presentation/cubit/login_by_google_state.dart
```

Current behavior:

- `main.dart` initializes `SharedPref.instantiatePreferences()` before
  `runApp`.
- `PrefKeys.isUserLoggedIn` stores whether the user is logged in.
- `AuthGateView` is the initial AutoRoute page.
- `AuthGateView` reads:

```dart
SharedPref.getBoolean(PrefKeys.isUserLoggedIn) ?? false
```

- If logged in, it replaces itself with `RecordMeetingViewRoute`.
- If not logged in, it replaces itself with `LoginViewRoute`.
- `LoginView` provides `LoginByGoogleCubit`.
- `LoginWithGoogle` is centered in the login screen.
- `LoginWithGoogle` calls `LoginByGoogleCubit.loginByGoogle()`.
- `LoginByGoogleCubit.loginByGoogle()` now:
  - emits loading
  - starts interactive Google Sign-In using `google_sign_in`
  - reads the Google ID token from `account.authentication.idToken`
  - tries to read an optional access token from the configured scopes
  - sends the token payload to the backend via `LoginByGoogleUseCase`
  - sets `PrefKeys.isUserLoggedIn` to `true` only after backend success
  - emits success or localized error state
- `LoginWithMicrosoft` calls `LoginByGoogleCubit.loginByMicrosoft()`.
- `LoginByGoogleCubit.loginByMicrosoft()` now:
  - emits loading for `LoginProvider.microsoft`
  - starts interactive Microsoft authentication using `msal_auth`
  - requests Microsoft Graph `user.read` scope
  - sends the Microsoft token payload to the backend via
    `LoginByMicrosoftUseCase`
  - sets `PrefKeys.isUserLoggedIn` to `true` only after backend success
  - emits success, canceled, or localized error state
- On login success, `LoginView` navigates to `RecordMeetingViewRoute`.

Current login UI:

- `LoginView` uses a custom full-screen white login layout matching the Figma
  direction/screenshot.
- The app bar is hidden on the login screen.
- The screen is RTL-first because Arabic is the default language.
- A soft blue radial glow is placed in the top-left background.
- The centered brand logo uses:

```text
assets/auth/login_logo.png
```

- The decorative bottom pattern uses:

```text
assets/auth/login_pattern.png
```

- `LoginWithGoogle` is a custom 56px rounded button with light background,
  Arabic text, loading state, and the provided Google SVG logo:

```text
assets/auth/google.svg
```

- Microsoft login is now visible under Google using the same button dimensions
  and styling direction, with the provided Microsoft SVG logo:

```text
assets/auth/microsoft.svg
```

- The signup line is localized:
  - `auth.login.noAccount`
  - `auth.login.createAccount`

Google Sign-In package:

```text
google_sign_in: 7.2.0
```

Microsoft Sign-In package:

```text
msal_auth: 3.5.3
```

Auth config placeholders:

```text
lib/features/auth/config/auth_google_config.dart
lib/features/auth/config/auth_microsoft_config.dart
assets/auth/msal_config.json
```

Values to fill before real environment testing:

```dart
AuthGoogleConfig.serverClientId
AuthGoogleConfig.backendApiKey
AuthGoogleConfig.backendApiKeyHeaderName
AuthMicrosoftConfig.clientId
AuthMicrosoftConfig.androidRedirectUri
AuthMicrosoftConfig.appleRedirectUri
```

Configured Google OAuth mobile client IDs:

```text
AuthGoogleConfig.androidClientId =
22642361348-3pgjqd9sk57b6puuvampepq26goneee0.apps.googleusercontent.com

AuthGoogleConfig.iosClientId =
22642361348-7i9fds4vr58utkrev2622grni0dcjh13.apps.googleusercontent.com
```

Configured iOS Google URL scheme:

```text
GoogleService-Info.plist REVERSED_CLIENT_ID =
com.googleusercontent.apps.22642361348-7i9fds4vr58utkrev2622grni0dcjh13
```

This value is registered in `ios/Runner/Info.plist` under
`CFBundleURLTypes/CFBundleURLSchemes` so iOS can return control to the app after
Google Sign-In.

Configured Google Web/server OAuth client ID:

```text
AuthGoogleConfig.serverClientId
22642361348-p129577ft4ia90ndglmgvfp02gbgjhud.apps.googleusercontent.com
```

This should be the Web OAuth client ID used by the backend/server side to
validate Google ID tokens. Do not fill it with another Android client ID unless
the backend explicitly requires that exact audience.

Backend endpoint:

```dart
RemoteURLs.loginByGoogle = "login/loginByGoogle"
RemoteURLs.loginByMicrosoft = "login/loginByMicrosoft"
```

Backend request payload:

```json
{
  "idToken": "<google-id-token>",
  "email": "<google-email>",
  "googleUserId": "<google-user-id>",
  "displayName": "<google-display-name>",
  "photoUrl": "<google-photo-url>",
  "accessToken": "<optional-google-access-token>"
}
```

Microsoft backend request payload:

```json
{
  "accessToken": "<microsoft-access-token>",
  "idToken": "<optional-microsoft-id-token>",
  "microsoftUserId": "<microsoft-account-id>",
  "email": "<preferred-username-email>",
  "displayName": "<account-name>",
  "tenantId": "<optional-tenant-id>",
  "authority": "<authority-url>",
  "expiresOn": "<iso-8601-expiration>",
  "scopes": ["https://graph.microsoft.com/user.read"]
}
```

Important auth notes and risks:

- Google Sign-In is implemented in app code, but real testing requires valid
  Google OAuth configuration.
- Android requires Google Cloud OAuth setup for package name
  `com.maher.app` and the correct SHA fingerprints.
- iOS has `ios/Runner/GoogleService-Info.plist` and the reversed client ID URL
  scheme from that file registered in `ios/Runner/Info.plist`.
- The backend endpoint example is now `login/loginByGoogle` under base URL
  `https://zk.com/`; update only `RemoteURLs.loginByGoogle` when the real path
  changes.
- The Microsoft backend endpoint example is now `login/loginByMicrosoft` under
  base URL `https://zk.com/`; update only `RemoteURLs.loginByMicrosoft` when
  the real path changes.
- If the backend requires a custom API key/header, fill
  `AuthGoogleConfig.backendApiKey` and `backendApiKeyHeaderName`.
- The shared-pref login flag is written only after the backend accepts the
  Google token payload.
- The same shared-pref login flag is written only after the backend accepts the
  Microsoft token payload.

Important Microsoft auth notes and risks:

- Microsoft login uses `msal_auth` with `SingleAccountPca`.
- `AuthMicrosoftConfig.broker` is currently `Broker.webView` so the app does
  not require Microsoft Authenticator/keychain sharing in this phase.
- Android MSAL config lives at `assets/auth/msal_config.json` and uses
  `authorization_user_agent: WEBVIEW`.
- Android now includes `INTERNET` and `ACCESS_NETWORK_STATE` permissions.
- Before real testing, fill:
  - Azure application client ID
  - Android redirect URI from Azure
  - iOS redirect URI if the final iOS setup requires an explicit redirect
- `MicrosoftAuthService` validates the required placeholder values before
  creating the native MSAL client, so missing config returns through the normal
  localized Microsoft login error path instead of a lower-level native error.
- The Microsoft package version added in this phase requires iOS 16+ through
  CocoaPods. The project iOS deployment target was raised from `14.0` to
  `16.0` in:
  - `ios/Podfile`
  - `ios/Runner.xcodeproj/project.pbxproj`

## Current Record Meeting Feature

Feature root:

```text
lib/features/record_meeting/
```

Current important files:

```text
record_meeting.dart
presentation/presentation.dart
presentation/screens/record_meeting_view.dart
presentation/screens/screens.dart
presentation/config/record_meeting_audio_quality.dart
presentation/widget/sound_indicator.dart
presentation/widget/start_record.dart
presentation/widget/widget.dart
presentation/cubit/cubit.dart
presentation/cubit/record_meeting_cubit.dart
presentation/cubit/record_meeting_state.dart
```

Current UI:

- `RecordMeetingView` provides `RecordMeetingCubit`.
- `StartRecord` is centered in the screen.
- Initial state shows a large indigo circular button with a mic icon.
- Recording/resumed state shows an animated sound indicator instead of the old
  static voice-wave icon.
- `SoundIndicator` is constrained to fit inside the 76px indicator box; bar
  widths/padding must stay below the available width to avoid `RenderFlex`
  overflow in the indigo circle.
- Pause state shows a pause icon.
- Active recording states show elapsed recording time under the center
  icon/indicator in `hh:mm:ss` format inside the indigo circle.
- The elapsed timer is cubit/state driven and uses real clock time for active
  recording segments, not just periodic tick counting.
- Active recording states show three icon buttons under the circle:
  - dark close/X icon button: close meeting and discard/delete the active
    record after confirmation
  - red stop icon button: finish recording
  - orange pause icon button: pause recording
  - green play icon button: resume recording
- Disabled action buttons use grey colors while finishing.
- Pressing the close/X button opens an adaptive confirmation dialog:
  - title: `Close meeting?`
  - message: `This will stop recording and delete this meeting record.`
  - `No` keeps the current recording state
  - `Yes, close` calls `RecordMeetingCubit.discardRecord()`
- Pressing finish shows a full-screen loading overlay while stop and MP3
  conversion are running.
- After finish completes, `RecordMeetingView` uses `BlocConsumer` to show:
  - green success snackbar: `Meeting record saved successfully.`
  - red error snackbar: `Could not save the meeting record. Please try again.`
- After either success or error snackbar state, the cubit returns to
  `RecordMeetingState` so the UI shows the mic button again and the user can
  start a new meeting.

## Record Meeting States

Defined in `record_meeting_state.dart`:

```dart
RecordMeetingState
StartRecordMeeting extends RecordMeetingState
PauseRecordMeeting extends RecordMeetingState
ResumeRecordMeeting extends RecordMeetingState
FinishingRecordState extends RecordMeetingState
FinishRecordMeeting extends RecordMeetingState
ErrorRecordMeetingState extends RecordMeetingState
```

State behavior:

- `RecordMeetingState`: initial/default state.
- `StartRecordMeeting`: recording started; contains `recordPath` and
  `elapsedDuration`.
- `PauseRecordMeeting`: recording paused; contains `elapsedDuration`.
- `ResumeRecordMeeting`: recording resumed; contains `elapsedDuration`.
- `FinishingRecordState`: user pressed Finish; contains nullable `recordPath`
  and tells the UI to show a blocking loading overlay while the final MP3 is
  being prepared.
- `FinishRecordMeeting`: recording finished successfully; contains nullable
  `recordPath`, final `elapsedDuration`, and a success message.
- `ErrorRecordMeetingState`: recording finish/save failed; contains the error
  message that should be shown to the user.

After finishing, cubit emits `FinishingRecordState`, then
`FinishRecordMeeting` or `ErrorRecordMeetingState`, then immediately emits
`RecordMeetingState` to return UI to initial mic mode.

Important finish error behavior:

- Finish/save errors must not leave the UI stuck in finishing/loading mode.
- After `ErrorRecordMeetingState`, always emit `RecordMeetingState`.
- This lets the user retry by starting a new meeting from the initial mic
  screen.

## Recording Implementation

Recording is handled in `RecordMeetingCubit`.

Packages used:

- `record`: microphone recording.
- `path_provider`: app documents directory for saved files.
- `ffmpeg_kit_flutter_new_audio`: converts the stopped temporary recording to
  MP3.
- `flutter_foreground_task`: Android foreground service.
- `wakelock_plus`: keeps device awake while recording.

Resolved package versions:

```text
record: 6.2.1
path_provider: 2.1.6
ffmpeg_kit_flutter_new_audio: 2.5.2
flutter_foreground_task: 10.0.0
wakelock_plus: 1.7.0
flutter_bloc: 9.1.1
equatable: 2.1.0
dio: 5.11.0
google_sign_in: 7.2.0
msal_auth: 3.5.3
get_it: 9.2.1
dartz: 0.10.1
```

`startRecord()` currently:

1. Prevents duplicate start if recorder is already recording.
2. Checks microphone permission via `AudioRecorder.hasPermission()`.
3. Creates a temporary recording file path under app documents using readable
   meeting date/time naming:

```text
<documents>/record_meetings/meeting_yyyy-MM-dd_HH-mm-ss.m4a
```

Example:

```text
meeting_2026-08-18_17-35-09.m4a
meeting_2026-08-18_17-35-09.mp3
```

Filename note:

- The final MP3 keeps the same readable base filename as the temporary `.m4a`.
- The time separator uses `-` instead of `:` so the filename stays safe across
  iOS, Android, and desktop tooling.

4. Starts recording protection:
   - enables wake lock
   - starts Android foreground service with microphone type
   - requests Android notification permission where needed
   - requests Android ignore battery optimization where needed
5. Starts recorder using AAC:

```dart
RecordConfig(
  encoder: AudioEncoder.aacLc,
  bitRate: 128000,
  sampleRate: 44100,
)
```

6. Emits `StartRecordMeeting(recordPath: recordPath)`.
7. Starts an elapsed timer in the cubit and emits active recording states with
   updated `elapsedDuration` every second.

Elapsed timer behavior:

- The cubit stores accumulated recorded time before the current active segment.
- While actively recording, displayed elapsed time is calculated as:

```text
elapsedBeforeActiveSegment + (DateTime.now() - activeSegmentStartedAt)
```

- This avoids drift when the app goes to background and Dart timer ticks are
  delayed or suspended.
- When the app returns to foreground, the cubit emits the recalculated elapsed
  duration so the UI catches up to the real recording time.
- Paused time is intentionally not counted.

`pauseRecord()`:

- calls `_recorder.pause()`
- freezes the elapsed duration at the pause moment
- stops the elapsed ticker so paused time is not counted
- emits `PauseRecordMeeting(elapsedDuration: elapsedDuration)`

`resumeRecord()`:

- calls `_recorder.resume()`
- starts a new active elapsed segment from the resume moment
- emits `ResumeRecordMeeting(elapsedDuration: elapsedDuration)`
- restarts the elapsed timer from the previously counted time

`discardRecord()`:

- prevents discard while `FinishingRecordState` is active
- freezes/resets elapsed duration
- safely stops the recorder
- deletes the active temporary record file
- stops Android foreground service
- disables wake lock
- clears `_activeRecordPath`
- emits initial `RecordMeetingState`
- does not convert to MP3 and does not emit `FinishRecordMeeting`

`finishRecord()`:

- prevents duplicate finish calls while already finishing
- freezes the final elapsed duration
- stops the elapsed ticker
- emits `FinishingRecordState` immediately so the user sees loading feedback
- safely stops recorder
- converts the temporary `.m4a` file to `.mp3`
- deletes the temporary `.m4a` file after successful MP3 conversion
- logs the final `.mp3` file path with `dart:developer` using the
  `RecordMeetingCubit` logger name for simulator/device testing
- stops Android foreground service
- disables wake lock
- emits `FinishRecordMeeting(recordPath: mp3Path, elapsedDuration:
  finalElapsedDuration)` on success
- emits `ErrorRecordMeetingState` when stop/conversion does not produce an MP3
- emits initial `RecordMeetingState` after both success and error paths

Final duration rule:

- The final elapsed duration emitted in `FinishRecordMeeting` is the same
  duration source shown under the wave icon.
- Because the timer is based on real active recording clock time and excludes
  pause time, it should match the MP3 duration across normal background and
  foreground transitions.
- Tiny differences can still happen from native recorder stop latency or MP3
  encoder padding, but the app no longer depends on foreground-only Dart timer
  ticks for duration accuracy.

Final recording file rule:

- The final finished recording must be MP3.
- `record` does not output MP3 directly, so `.m4a` is used only as an internal
  temporary capture format.
- The path emitted by `FinishRecordMeeting` should be the converted `.mp3`
  path.
- If conversion fails, `FinishRecordMeeting.recordPath` can be `null`; this is
  safer than pretending a non-MP3 file is the final result.
- If conversion fails during development/testing, the cubit logs the temporary
  source path so the failed file can still be inspected.
- Conversion failure logs also include FFmpeg return code, FFmpeg output, and
  fail stack trace so simulator/device issues can be diagnosed from the console.
- The FFmpeg audio package includes MP3 support through audio-focused external
  libraries such as `lame`.

MP3 compression configuration:

- MP3 quality choices live in:

```text
lib/features/record_meeting/presentation/config/record_meeting_audio_quality.dart
```

- Current default:

```dart
RecordMeetingAudioConfig.defaultQuality = RecordMeetingAudioQuality.balanced
```

- `RecordMeetingCubit` uses
  `RecordMeetingAudioConfig.defaultQuality.ffmpegAudioArguments` when building
  the FFmpeg command.
- To change compression later, update only `defaultQuality` unless we add a
  user-facing setting.

Available MP3 choices:

```text
verySmall   -> -b:a 48k   -> ~22 MB/hour
smaller     -> -b:a 64k   -> ~29 MB/hour
balanced    -> -b:a 96k   -> ~43 MB/hour
highQuality -> -b:a 128k  -> ~58 MB/hour
highVbr     -> -q:a 2     -> ~60-120 MB/hour
```

For meeting voice recordings, `balanced` is the current preferred production
default because it keeps voices clear while making file size predictable.

Native minimums required by the MP3 conversion package:

- Android `minSdk = 24`
- Android Gradle Plugin is set to `8.10.0` and Kotlin Android Gradle plugin is
  set to `2.2.0` in `android/settings.gradle.kts`.
- AGP was downgraded from `8.12.1` to `8.10.0` because the current Flutter
  tooling reported `8.12.1` as incompatible and `8.10.0` as the latest
  supported AGP version.
- Do not bump Android Gradle Plugin to `9.x` without retesting plugins.
  `package_info_plus 10.2.1` failed under AGP `9.0.1` because its Gradle script
  skipped applying Kotlin for AGP 9 while still configuring
  `KotlinAndroidProjectExtension`.
- Android app Gradle config uses Java 17 `compileOptions`.
- Do not add a standalone `kotlin { compilerOptions { ... } }` block in
  `android/app/build.gradle.kts` unless the Android Kotlin plugin is also
  applied. A previous standalone Kotlin block caused Gradle script compilation
  errors during `flutter build apk --debug`.
- iOS platform target `16.0`
- Flutter Swift Package Manager integration is disabled for this project:

```yaml
flutter:
  config:
    enable-swift-package-manager: false
```

- iOS dependencies are currently resolved through CocoaPods.
- iOS must stay aligned in both:
  - `ios/Podfile`: `platform :ios, '16.0'`
  - `ios/Podfile` post-install hook: forces every Pods build configuration
    `IPHONEOS_DEPLOYMENT_TARGET` to `16.0`
  - `ios/Runner.xcodeproj/project.pbxproj`: all
    project-level, Runner target-level, and RunnerTests target-level
    `IPHONEOS_DEPLOYMENT_TARGET` values set to `16.0`

This iOS target alignment is required because `FlutterFramework` requires at
least iOS 13, `ffmpeg-kit-flutter-new-audio` requires iOS 14, and
`msal_auth 3.5.3` requires iOS 16 through CocoaPods.

Why SPM is disabled:

- Flutter 3.41 generated Swift Package Manager integration for iOS.
- Some current plugin Swift package manifests declare lower iOS platform
  versions, for example `record_ios` at iOS 12 and `wakelock_plus` at iOS 11.
- Xcode raised target-integrity errors such as:

```text
The package product 'FlutterFramework' requires minimum platform version 13.0
for the iOS platform, but this target supports 12.0
```

- Disabling SPM and removing the stale
  `FlutterGeneratedPluginSwiftPackage` reference from
  `ios/Runner.xcodeproj/project.pbxproj` lets CocoaPods manage the same iOS
  plugins with the enforced iOS 14 deployment target.
- After this change, `flutter build ios --simulator` succeeded and produced:

```text
build/ios/iphonesimulator/Runner.app
```

`close()`:

- removes lifecycle observer
- if recording is active, stops recorder and protection
- disposes recorder

## Background And Lock-Screen Strategy

Goal: recording should continue until user presses Finish.

Important note: this is the correct production direction for lock/background
recording. Android now runs a microphone foreground service; iOS has background
audio mode. Nothing can fully protect against the user force-killing the app
from the app switcher or extreme OEM battery killing, but lock screen,
auto-lock, and normal background/foreground transitions are now handled much
more safely.

Effort already completed in this area:

- Added Android microphone foreground service support.
- Added Android foreground service permissions, including microphone service
  type support for newer Android versions.
- Added Android notification permission handling for the foreground service.
- Added Android battery optimization ignore request to reduce long-recording
  interruption risk.
- Added wake-lock support while recording is active.
- Added iOS microphone permission description.
- Added iOS background audio mode.
- Wrapped the app in `WithForegroundTask`.
- Initialized `FlutterForegroundTask` communication in `main.dart`.
- Added app lifecycle observation in `RecordMeetingCubit`.
- Re-enables wake lock and refreshes Android foreground notification when the
  app moves through inactive, paused, and resumed states.
- Keeps pause/resume/background transitions from stopping the recording.
- Stops recorder/protection only on explicit Finish or cleanup/dispose.

Android setup:

- `RECORD_AUDIO`
- `FOREGROUND_SERVICE`
- `FOREGROUND_SERVICE_MICROPHONE`
- `POST_NOTIFICATIONS`
- `REQUEST_IGNORE_BATTERY_OPTIMIZATIONS`
- `WAKE_LOCK`
- foreground service declaration:

```xml
<service
    android:name="com.pravera.flutter_foreground_task.service.ForegroundService"
    android:foregroundServiceType="microphone"
    android:exported="false" />
```

iOS setup:

- `NSMicrophoneUsageDescription`
- `UIBackgroundModes` with `audio`

App setup:

- `main.dart` calls:
  - `WidgetsFlutterBinding.ensureInitialized()`
  - `FlutterForegroundTask.initCommunicationPort()`
- `MaterialApp` is wrapped in `WithForegroundTask`.

Lifecycle handling:

- `RecordMeetingCubit` observes app lifecycle.
- While active, paused, inactive, or resumed lifecycle events re-enable wake lock.
- Android foreground notification is refreshed while recording is active.

Important limitation:

- Normal lock, auto-lock, and background/foreground transitions are handled.
- No mobile app can guarantee recording after the user force-kills the app from the app switcher.
- Some Android vendors may still apply aggressive battery restrictions. The app requests ignore battery optimization to reduce this risk.

## Routing

Current route setup uses `auto_route`.

Router owner:

```dart
lib/core/routes/app_router.dart
```

Generated file:

```dart
lib/core/routes/app_router.gr.dart
```

Current first route:

```dart
AutoRoute(page: AuthGateViewRoute.page, initial: true)
```

Current active routes:

```dart
AutoRoute(page: AuthGateViewRoute.page, initial: true)
AutoRoute(page: LoginViewRoute.page)
AutoRoute(page: RecordMeetingViewRoute.page)
```

`AuthGateView`, `LoginView`, and `RecordMeetingView` are annotated with:

```dart
@RoutePage()
```

`main.dart` uses:

```dart
MaterialApp.router(
  routerConfig: _appRouter.config(),
)
```

Important routing note:

- Old `@RoutePage()` annotations were removed from legacy `SplashView` and
  `LayoutView` because those screens currently reference incomplete copied
  modules.
- `AuthGateViewRoute` is currently the initial route and performs the shared
  preference login check.
- `LoginViewRoute` is used for users who are not logged in.
- `RecordMeetingViewRoute` is used for users who are logged in.
- When adding new screens, annotate them with `@RoutePage()`, add them to
  `AppRouter.routes`, then run:

```bash
dart run build_runner build
```

## Core Notes

Current active shared core includes:

- `BaseDio`
- `DioService`
- `ResponseModel`
- `ResponseHandler`
- `Failure` classes
- `ErrorHandler`
- `UseCase`
- `NoParams`
- shared preferences helpers

Some old copied core UI/route/extension folders are excluded from analyzer because they reference missing legacy/generated modules. Do not build new feature logic against those excluded files until they are restored or cleaned.

## Localization

Localization is handled with `easy_localization`.

Package:

```text
easy_localization: 3.0.8
```

Setup:

- `main.dart` calls `EasyLocalization.ensureInitialized()` before `runApp`.
- Root app is wrapped in `EasyLocalization`.
- Supported locales:
  - English: `Locale('en')`
  - Arabic: `Locale('ar')`
- Default/start locale: Arabic.
- Fallback locale: Arabic.
- `MaterialApp.router` uses:
  - `context.localizationDelegates`
  - `context.supportedLocales`
  - `context.locale`
- iOS `Info.plist` includes `CFBundleLocalizations` for `en` and `ar`.

Translation files:

```text
assets/translations/en.json
assets/translations/ar.json
```

`pubspec.yaml` declares:

```yaml
flutter:
  assets:
    - assets/translations/
```

Current localized active UI/UX text:

- App title.
- Login screen app bar title.
- Login with Google button.
- Login with Google error message.
- Login with Google canceled message.
- Record meeting app bar title.
- Close, finish, pause, and resume tooltips.
- Adaptive close/discard confirmation dialog.
- Finish success snackbar.
- Finish error snackbar.
- Android foreground recording notification title/text/channel name/channel
  description.

Development rules:

- Do not add new user-facing strings directly in widgets/cubits.
- Add a key in both `en.json` and `ar.json`, then use `.tr()` in the UI.
- Cubit result states should carry translation keys, not hardcoded localized
  sentences, when the message is rendered by a widget.
- Logs, file paths, FFmpeg commands, route paths, and internal developer config
  strings do not need translation unless they become user-facing.
- Risk: `easy_localization` covers Flutter-rendered UI. Native OS text such as
  iOS permission dialog strings from `Info.plist` requires platform-specific
  localization files if product requires translated permission prompts.
- Risk: Arabic is enabled as a supported locale, but full RTL visual QA on all
  screens is still required before calling localization production-complete.

## Native Splash Screen

Native splash is generated with `flutter_native_splash`.

Package decision:

- Pub.dev latest checked on 2026-08-26: `flutter_native_splash 2.4.8`.
- This project uses `flutter_native_splash ^2.4.7` because `2.4.8` requires
  `meta ^1.18.0`, while the current Flutter SDK pins `meta 1.17.0` through
  `flutter_test`.
- The package is in `dependencies` because `main.dart` uses its runtime
  `preserve()`/`remove()` API to prevent a black gap before Flutter's first
  frame.

Source image:

```text
/Users/zieademad/Downloads/Splash.webp
```

Repo asset generated from the WebP:

```text
assets/splash/splash.png
```

Android 12+ centered logo source:

```text
/Users/zieademad/Downloads/Frame 2147240959.png
```

Repo asset copied from the Android 12+ logo source:

```text
assets/splash/android12_logo.png
```

Reason for conversion:

- `flutter_native_splash` documents splash image support around PNG assets.
- The provided source image is WebP, so it was converted to PNG before
  generation.
- The Android 12+ logo source is already PNG with alpha transparency, so it can
  be used as a centered white logo without an icon background color.

Current `pubspec.yaml` native splash config:

```yaml
flutter_native_splash:
  background_image: assets/splash/splash.png
  android_gravity: fill
  ios_content_mode: scaleAspectFill
  web: false
  android_12:
    color: "#1A417F"
    image: assets/splash/android12_logo.png
```

Generated native files include:

- Android:
  - `android/app/src/main/res/drawable/background.png`
  - `android/app/src/main/res/drawable-v21/background.png`
  - `android/app/src/main/res/drawable/launch_background.xml`
  - `android/app/src/main/res/drawable-v21/launch_background.xml`
  - `android/app/src/main/res/values-v31/styles.xml`
  - `android/app/src/main/res/values-night-v31/styles.xml`
  - `android/app/src/main/res/drawable-*/android12splash.png`
  - `android/app/src/main/res/drawable-night-*/android12splash.png`
  - updates to `android/app/src/main/res/values/styles.xml`
  - updates to `android/app/src/main/res/values-night/styles.xml`
- iOS:
  - `ios/Runner/Assets.xcassets/LaunchImage.imageset/*`
  - `ios/Runner/Base.lproj/LaunchScreen.storyboard`
  - `ios/Runner/Info.plist`

iOS simulator black splash fix:

- `flutter_native_splash` first generated `LaunchImage.png`,
  `LaunchImage@2x.png`, and `LaunchImage@3x.png` as 1x1 black placeholder
  images; those were replacing/covering the real splash artwork and caused a
  black launch screen.
- Per product direction, the temporary lightweight iOS launch screen using
  solid `#1A417F` background plus centered logo was rolled back.
- iOS native splash now renders the provided full splash PNG again through
  `LaunchBackground` with `scaleAspectFill`.
- Native iOS launch background image:

```text
ios/Runner/Assets.xcassets/LaunchBackground.imageset/background.png
```

- `LaunchLogo.imageset` was removed because it is no longer used by the
  storyboard.
- If `dart run flutter_native_splash:create` is run again, re-check
  `LaunchScreen.storyboard`; the generator may recreate the placeholder overlay.

Black gap before Flutter first frame fix:

- `main.dart` now calls `FlutterNativeSplash.preserve()` immediately after
  `WidgetsFlutterBinding.ensureInitialized()`.
- The splash is removed with `FlutterNativeSplash.remove()` only after
  localization, shared preferences, foreground-task setup, and `runApp`.
- This prevents iOS from briefly showing a black Flutter surface between the
  OS launch storyboard and the first rendered Flutter frame.

Generation command:

```bash
dart run flutter_native_splash:create
```

Important risks and limitations:

- Android 12+ native splash screens do not support full-screen background
  images the same way older Android and iOS do. Android 12+ uses a window
  background color and a centered icon model, so the full portrait artwork
  cannot be guaranteed there.
- Current Android 12+ config uses background color `#1A417F`, centered logo
  `assets/splash/android12_logo.png`, and no `icon_background_color`.
- There is intentionally no white icon background because the logo artwork is
  white with transparency.
- Android 12+ may mask or scale the centered icon depending on launcher/OS
  behavior. The logo should be visually checked on Android 12+ devices because
  wide logo/text artwork can be clipped if it exceeds the splash icon safe
  area.
- The tall splash image uses `fill`/`scaleAspectFill`, so edge cropping can
  happen on devices with very different aspect ratios, notches, or tablets.
- Native splash changes should be validated by launching the app on real iOS
  and Android devices, not only by static analysis.

## Development Rules For Next Phases

- Keep `record_meeting` presentation logic in `presentation/`.
- Add domain/data layers only when we have real business/API requirements.
- Do not put recording logic directly in widgets.
- Widgets should call cubit functions and render based on cubit state.
- Do not stop recording from lifecycle changes; only stop on explicit Finish or cleanup/dispose.
- Keep saved local files in app documents unless product requirements say otherwise.
- When adding upload/sync later, keep it separate from recording lifecycle.
- Always run:

```bash
flutter pub get
dart analyze
```

For native recording/background changes, also validate Android/iOS builds on real devices.

## Verification Status

Latest successful static check:

```text
dart analyze
No issues found!
```

Latest successful iOS simulator build:

```text
flutter build ios --simulator --target lib/main_development.dart
✓ Built build/ios/iphonesimulator/Runner.app
```

This iOS simulator build was re-run successfully after native splash generation
with `flutter_native_splash`, after adding `google_sign_in`, and after adding
`msal_auth` plus the iOS 16 deployment target alignment.

Latest Android debug build attempt:

```text
flutter build apk --debug
```

Result:

- First attempt exposed Gradle compatibility issues:
  - removed invalid standalone app-level `kotlin { compilerOptions { ... } }`
    block
  - aligned Android Gradle Plugin to `8.10.0`
  - aligned Kotlin Android Gradle plugin to `2.2.0`
- Follow-up attempt stayed silent for several minutes and was manually
  interrupted with exit code `130`.

Static analysis passed, but a full Android native build/device test is still
required before calling Android splash/background recording production-proven.
