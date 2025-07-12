import 'package:fondos_app/data/data.dart';
import 'package:fondos_app/data/datasources/mock_fund_datasource.dart';
import 'package:fondos_app/data/repositories/fund_repository_impl.dart';
import 'package:fondos_app/domain/repositories/repositories.dart';
import 'package:fondos_app/domain/usecases/usecases.dart';
import 'package:fondos_app/ui/blocs/blocs.dart';
import 'package:fondos_app/ui/cubits/cubits.dart';
import 'package:fondos_app/ui/shared/service/service.dart';
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

    getIt.registerLazySingleton<UserCubit>(
      () => UserCubit(),
    );

    getIt.registerLazySingleton<FundBloc>(
      () => FundBloc(
        getIt.get<FundUsecase>(),
        getIt.get<UserCubit>(),
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

    getIt.registerFactory<SubscribeFundFormCubit>(
      () => SubscribeFundFormCubit(
        getIt.get<FundBloc>(),
      ),
    );
  }
}
