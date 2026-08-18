import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';

import 'core/core.dart';
import 'features/example/example_di.dart';

class InjectionContainer {
  static GetIt locator = GetIt.instance;

  InjectionContainer._();

  static Future<void> init() async {
    if (!locator.isRegistered<Dio>()) {
      locator.registerLazySingleton<Dio>(Dio.new);
    }

    if (!locator.isRegistered<BaseDio>()) {
      locator.registerLazySingleton<BaseDio>(
        () => BaseDio(dio: locator<Dio>()),
      );
    }

    ExampleDi.injectionContainer();
  }
}
