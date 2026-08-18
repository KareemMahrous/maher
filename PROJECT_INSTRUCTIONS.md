# Project Instructions

## Project Snapshot

- Project name: `maher`
- Flutter app version: `0.1.0+1`
- Dart SDK constraint: `^3.11.1`
- Resolved SDKs from `pubspec.lock`:
  - Dart: `>=3.11.1 <4.0.0`
  - Flutter: `>=3.41.0`
- Main app entry: `lib/main.dart`
- First screen after app launch: `RecordMeetingView`

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
    record_meeting/
      data/
      domain/
      presentation/
```

Feature layers:

- `data`: API/data source/models/repository implementation.
- `domain`: entities, repository contracts, use cases.
- `presentation`: screens, widgets, cubits/states.

Current `record_meeting` intentionally has only presentation logic. Data/domain folders exist with `.gitkeep` files so we can add real API/domain logic later.

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
presentation/widget/start_record.dart
presentation/widget/widget.dart
presentation/cubit/cubit.dart
presentation/cubit/record_meeting_cubit.dart
presentation/cubit/record_meeting_state.dart
```

Current UI:

- `RecordMeetingView` provides `RecordMeetingCubit`.
- `StartRecord` is centered in the screen.
- Initial state shows a large red circular button with a mic icon.
- Recording/resumed state shows a voice-wave icon.
- Pause state shows a pause icon.
- Active recording states show two icon buttons under the circle:
  - stop icon: finish recording
  - pause/play icon: pause or resume
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
- `StartRecordMeeting`: recording started; contains `recordPath`.
- `PauseRecordMeeting`: recording paused.
- `ResumeRecordMeeting`: recording resumed.
- `FinishingRecordState`: user pressed Finish; contains nullable `recordPath`
  and tells the UI to show a blocking loading overlay while the final MP3 is
  being prepared.
- `FinishRecordMeeting`: recording finished successfully; contains nullable
  `recordPath` and a success message.
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

`pauseRecord()`:

- calls `_recorder.pause()`
- emits `PauseRecordMeeting`

`resumeRecord()`:

- calls `_recorder.resume()`
- emits `ResumeRecordMeeting`

`finishRecord()`:

- prevents duplicate finish calls while already finishing
- emits `FinishingRecordState` immediately so the user sees loading feedback
- safely stops recorder
- converts the temporary `.m4a` file to `.mp3`
- deletes the temporary `.m4a` file after successful MP3 conversion
- logs the final `.mp3` file path with `dart:developer` using the
  `RecordMeetingCubit` logger name for simulator/device testing
- stops Android foreground service
- disables wake lock
- emits `FinishRecordMeeting(recordPath: mp3Path)` on success
- emits `ErrorRecordMeetingState` when stop/conversion does not produce an MP3
- emits initial `RecordMeetingState` after both success and error paths

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
- iOS platform target `14.0`
- Flutter Swift Package Manager integration is disabled for this project:

```yaml
flutter:
  config:
    enable-swift-package-manager: false
```

- iOS dependencies are currently resolved through CocoaPods.
- iOS must stay aligned in both:
  - `ios/Podfile`: `platform :ios, '14.0'`
  - `ios/Podfile` post-install hook: forces every Pods build configuration
    `IPHONEOS_DEPLOYMENT_TARGET` to `14.0`
  - `ios/Runner.xcodeproj/project.pbxproj`: all
    project-level, Runner target-level, and RunnerTests target-level
    `IPHONEOS_DEPLOYMENT_TARGET` values set to `14.0`

This iOS target alignment is required because `FlutterFramework` requires at
least iOS 13 and `ffmpeg-kit-flutter-new-audio` requires iOS 14.

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
AutoRoute(page: RecordMeetingViewRoute.page, initial: true)
```

`RecordMeetingView` is annotated with:

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
- `RecordMeetingViewRoute` is currently the only generated active route.
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
flutter build ios --simulator
✓ Built build/ios/iphonesimulator/Runner.app
```

An attempted `flutter build apk --debug` was started to validate native integration, but Gradle stayed silent for several minutes and was manually interrupted. Static analysis passed, but a full Android native build/device test is still required before calling background recording production-proven.
