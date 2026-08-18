import '../../di_container.dart';
import 'example.dart';

class ExampleDi {
  static void injectionContainer() {
    registerSingletons();
    registerFactories();
  }

  static void registerSingletons() {
    // register Remote Data Source
    getIt.registerSingleton<ExampleRemoteDataSource>(
      ExampleRemoteDataSourceImpl(baseDio: getIt()),
    );

    // register Repository
    getIt.registerSingleton<ExampleRepository>(
      ExampleRepositoryImpl(remoteDataSource: getIt()),
    );

    // register Use Cases
    getIt.registerSingleton<FetchExamplesUseCase>(
      FetchExamplesUseCase(repository: getIt()),
    );
    getIt.registerSingleton<FetchExampleDetailsUseCase>(
      FetchExampleDetailsUseCase(repository: getIt()),
    );
    getIt.registerSingleton<UpdateExampleUseCase>(
      UpdateExampleUseCase(repository: getIt()),
    );
    getIt.registerSingleton<CreateExampleUseCase>(
      CreateExampleUseCase(repository: getIt()),
    );
    getIt.registerSingleton<DeleteExampleUseCase>(
      DeleteExampleUseCase(repository: getIt()),
    );
  }

  static void registerFactories() {
       // register Cubit
    getIt.registerFactory<ExamplesCubit>(
      () => ExamplesCubit(fetchExamplesUseCase: getIt()));
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
