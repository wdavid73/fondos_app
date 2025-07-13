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

/// Clase encargada de la inyección de dependencias de la aplicación.
///
/// Utiliza el paquete [get_it] para registrar repositorios, casos de uso,
/// servicios, cubits y BLoCs como singletons o factories, permitiendo
/// su acceso global y facilitando la gestión de dependencias.
class AppDependencyInjection {
  /// Inicializa y registra todas las dependencias necesarias para la aplicación.
  ///
  /// Este método debe ser llamado al inicio de la aplicación para asegurar
  /// que todas las dependencias estén disponibles mediante [getIt].
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
