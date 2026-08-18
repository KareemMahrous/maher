import '../../injection_container.dart';
import 'example.dart';

class ExampleDi {
  static final getIt = InjectionContainer.locator;

  static void injectionContainer() {
    registerSingletons();
    registerFactories();
  }

  static void registerSingletons() {
    // register Remote Data Source
    if (!getIt.isRegistered<ExampleRemoteDataSource>()) {
      getIt.registerLazySingleton<ExampleRemoteDataSource>(
        () => ExampleRemoteDataSourceImpl(baseDio: getIt()),
      );
    }

    // register Repository
    if (!getIt.isRegistered<ExampleRepository>()) {
      getIt.registerLazySingleton<ExampleRepository>(
        () => ExampleRepositoryImpl(remoteDataSource: getIt()),
      );
    }

    // register Use Cases
    if (!getIt.isRegistered<FetchExamplesUseCase>()) {
      getIt.registerLazySingleton<FetchExamplesUseCase>(
        () => FetchExamplesUseCase(repository: getIt()),
      );
    }
    if (!getIt.isRegistered<FetchExampleDetailsUseCase>()) {
      getIt.registerLazySingleton<FetchExampleDetailsUseCase>(
        () => FetchExampleDetailsUseCase(repository: getIt()),
      );
    }
    if (!getIt.isRegistered<UpdateExampleUseCase>()) {
      getIt.registerLazySingleton<UpdateExampleUseCase>(
        () => UpdateExampleUseCase(repository: getIt()),
      );
    }
    if (!getIt.isRegistered<CreateExampleUseCase>()) {
      getIt.registerLazySingleton<CreateExampleUseCase>(
        () => CreateExampleUseCase(repository: getIt()),
      );
    }
    if (!getIt.isRegistered<DeleteExampleUseCase>()) {
      getIt.registerLazySingleton<DeleteExampleUseCase>(
        () => DeleteExampleUseCase(repository: getIt()),
      );
    }
  }

  static void registerFactories() {
    // register Cubit
    if (getIt.isRegistered<ExamplesCubit>()) {
      return;
    }
    getIt.registerFactory<ExamplesCubit>(
      () => ExamplesCubit(fetchExamplesUseCase: getIt()),
    );
    getIt.registerFactory<ExampleDetailsCubit>(
      () => ExampleDetailsCubit(fetchExampleDetailsUseCase: getIt()),
    );
    getIt.registerFactory<ManageExampleCubit>(
      () => ManageExampleCubit(
        createExampleUseCase: getIt(),
        updateExampleUseCase: getIt(),
        deleteExampleUseCase: getIt(),
      ),
    );
  }
}
