import 'package:flutter_starter_kit/data/data.dart';
import 'package:flutter_starter_kit/data/datasources/mock_fund_datasource.dart';
import 'package:flutter_starter_kit/data/repositories/fund_repository_impl.dart';
import 'package:flutter_starter_kit/domain/repositories/repositories.dart';
import 'package:flutter_starter_kit/domain/usecases/usecases.dart';
import 'package:flutter_starter_kit/ui/blocs/blocs.dart';
import 'package:flutter_starter_kit/ui/cubits/cubits.dart';
import 'package:flutter_starter_kit/ui/shared/service/service.dart';
import 'package:get_it/get_it.dart';

final GetIt getIt = GetIt.instance;

class AppDependencyInjection {
  static void init() {
    /// Repositories
    getIt.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(
        ApiAuthDataSource(),
      ),
    );

    getIt.registerLazySingleton<FundRepository>(
      () => FundRepositoryImpl(
        MockFundDataSource(),
      ),
    );

    /// Use Cases
    getIt.registerLazySingleton<AuthUseCase>(
      () => AuthUseCase(getIt<AuthRepository>()),
    );

    getIt.registerLazySingleton<FundUsecase>(
      () => FundUsecase(getIt.get<FundRepository>()),
    );

    /// Services
    getIt.registerLazySingleton<KeyValueStorageService>(
      () => KeyValueStorageServiceImpl(),
    );

    ///  Cubits and BLoCs

    // Singleton
    getIt.registerLazySingleton<ThemeModeCubit>(() => ThemeModeCubit());

    getIt.registerLazySingleton<AuthBloc>(
      () => AuthBloc(
        getIt<AuthUseCase>(),
        getIt<KeyValueStorageService>(),
      ),
    );

    getIt.registerLazySingleton<FundBloc>(
      () => FundBloc(
        getIt.get<FundUsecase>(),
      ),
    );

    // Factory

    getIt.registerFactory<SignInFormCubit>(
      () => SignInFormCubit(
        authBloc: getIt<AuthBloc>(),
      ),
    );

    getIt.registerFactory<RegisterFormCubit>(
      () => RegisterFormCubit(
        authBloc: getIt<AuthBloc>(),
      ),
    );
  }
}
