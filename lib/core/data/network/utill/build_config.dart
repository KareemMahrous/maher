enum Flavor { development, production, preProduction, staging }

class BuildConfig {
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

  static void setFlavor(Flavor value) {
    flavor = value;
    _instance = null;
  }

  factory BuildConfig._production() {
    return BuildConfig._(
      baseURL: _baseUrl,
      baseImageUrl: _baseUrl,
      showLogger: false,
      testingDeviceId: '',
      showVersionCode: false,
    );
  }

  factory BuildConfig._development() {
    return BuildConfig._(
      baseURL: _baseUrl,
      baseImageUrl: _baseUrl,
      showLogger: true,
      testingDeviceId: '',
      showVersionCode: true,
    );
  }

  factory BuildConfig._staging() {
    return BuildConfig._(
      baseURL: _baseUrl,
      baseImageUrl: _baseUrl,
      showLogger: true,
      testingDeviceId: '',
      showVersionCode: true,
    );
  }

  factory BuildConfig._preProduction() {
    return BuildConfig._(
      baseURL: _baseUrl,
      baseImageUrl: _baseUrl,
      showLogger: true,
      testingDeviceId: '',
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
  static const String _baseUrl = 'https://zk.com/';

  static Flavor flavor = Flavor.production;
  final String baseURL;
  final String baseImageUrl;
  final String testingDeviceId;
  final bool showLogger;
  final bool showVersionCode;
}

//Android
//flutter build apk --release --target lib/main_development.dart
//flutter build apk --release --target lib/main_staging.dart
//flutter build apk --release --target lib/main_production.dart
//flutter build apk --release --target lib/main.dart

//IOS
//flutter build ipa --release --target lib/main_development.dart
//flutter build ipa --release --target lib/main_staging.dart
//flutter build ipa --release --target lib/main_production.dart
//flutter build ipa --release --target lib/main.dart
