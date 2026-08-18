import 'package:shared_preferences/shared_preferences.dart';

enum Flavor { development, production, preProduction, staging }

class BuildConfig {
  static SharedPreferences? _prefs;

  static Future<void> init() async {
    _prefs ??= await SharedPreferences.getInstance();
    _instance = null; // force re-creation on next of()
  }

  factory BuildConfig() {
    _instance ??= BuildConfig.of();
    return _instance!;
  }

  BuildConfig._({
    required this.baseURL,
    required this.baseImageUrl,

    required this.showLogger,
    required this.showVersionCode,
    required this.testingDeviceId,
  });

  factory BuildConfig.of() {
    if (_instance != null) return _instance!;
    switch (flavor) {
      case Flavor.development:
        _instance = BuildConfig._development();
      case Flavor.production:
        _instance = BuildConfig._production();
      case Flavor.staging:
        _instance = BuildConfig._staging();
      case Flavor.preProduction:
        _instance = BuildConfig._preProduction();
    }
    return _instance!;
  }

  factory BuildConfig._production() {
    final savedUrl = _prefs?.getString('url');
    return BuildConfig._(
      baseURL: (savedUrl != null && savedUrl.isNotEmpty) ? savedUrl : 'https://ucts-be.psmail.gov/api/',
      baseImageUrl: 'https://',
      showLogger: false,
      testingDeviceId: 'dss',
      showVersionCode: false,
    );
  }

  factory BuildConfig._development() {
    final savedUrl = _prefs?.getString('url');
    return BuildConfig._(
      baseURL: (savedUrl != null && savedUrl.isNotEmpty) ? savedUrl : 'https://morasalatdev-be.ti-sa.com/api/',
      baseImageUrl: 'https://',
      showLogger: true,
      testingDeviceId: 'CA660F9D-9416-4007-A097-669D240388D3',
      showVersionCode: true,
    );
  }

  factory BuildConfig._staging() {
    final savedUrl = _prefs?.getString('url');
    return BuildConfig._(
      baseURL: (savedUrl != null && savedUrl.isNotEmpty) ? savedUrl : 'https://morasalat-be.ti-sa.com/api/',
      baseImageUrl: 'https://',
      showLogger: false,
      testingDeviceId: 'CA660F9D-9416-4007-A097-669D240388D3',
      showVersionCode: false,
    );
  }

  factory BuildConfig._preProduction() {
    final savedUrl = _prefs?.getString('url');
    return BuildConfig._(
      baseURL: (savedUrl != null && savedUrl.isNotEmpty) ? savedUrl : 'https://cts-be.preps.local/api/',
      baseImageUrl: 'https://',
      showLogger: false,
      testingDeviceId: 'dss',
      showVersionCode: true,
    );
  }

  void copyWith({String? baseURL}) {
    final instance = BuildConfig.of();
    final updatedInstance = BuildConfig._(
      baseURL: baseURL ?? instance.baseURL,
      baseImageUrl: instance.baseImageUrl,
      showLogger: instance.showLogger,
      testingDeviceId: instance.testingDeviceId,
      showVersionCode: instance.showVersionCode,
    );
    _instance = updatedInstance;
  }

  static BuildConfig? _instance;

  static Flavor flavor = Flavor.production;
  final String baseURL;
  final String baseImageUrl;
  final String testingDeviceId;
  final bool showLogger;
  final bool showVersionCode;
}

//Android
//flutter build apk --release --target lib/main_development.dart
//flutter build apk --release --target lib/main.dart
//flutter build apk --release --target lib/main_staging.dart
//flutter build apk --release --target lib/main_pre_production.dart

//IOS
//flutter build ipa --release --target lib/main_development.dart
//flutter build ipa --release --target lib/main.dart
//flutter build ipa --release --target lib/main_staging.dart
//flutter build ipa --release --target lib/main_pre_production.dart
