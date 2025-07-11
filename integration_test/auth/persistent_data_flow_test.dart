import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_starter_kit/config/config.dart';
import 'package:flutter_starter_kit/data/data.dart';
import 'package:flutter_starter_kit/ui/blocs/auth/auth_bloc.dart';
import 'package:flutter_starter_kit/ui/cubits/cubits.dart';
import 'package:flutter_starter_kit/ui/screens/screens.dart';
import 'package:go_router/go_router.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mocktail/mocktail.dart';

import 'mocks/auth_flow_dependencies.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  late MockAuthBloc mockAuthBloc;
  late MockSignInFormCubit mockSignInFormCubit;
  late MockKeyValueStorageService mockStorage;
  late GoRouter appRouter;

  late StreamController<AuthState> authStateController;
  late StreamController<SignInFormState> signInFormStateController;

  setUpAll(() {
    registerFallbackValue(FakeAuthState());
    registerFallbackValue(FakeAuthEvent());
  });

  setUp(() {
    mockAuthBloc = MockAuthBloc();
    mockSignInFormCubit = MockSignInFormCubit();
    mockStorage = MockKeyValueStorageService();

    authStateController = StreamController<AuthState>.broadcast();
    signInFormStateController = StreamController<SignInFormState>.broadcast();

    // Mock initial state of AuthBloc.
    when(() => mockAuthBloc.state).thenReturn(const AuthState(
      authStatus: AuthStatus.checking,
    ));
    // Mock stream of AuthBloc states.
    when(() => mockAuthBloc.stream).thenAnswer(
      (_) => authStateController.stream,
    );
    // Mock closing of AuthBloc.
    when(() => mockAuthBloc.close()).thenAnswer((_) async {});

    // Mock initial state of SignInFormCubit.
    when(() => mockSignInFormCubit.state).thenReturn(const SignInFormState());
    // Mock stream of SignInFormCubit states.
    when(() => mockSignInFormCubit.stream).thenAnswer(
      (_) => signInFormStateController.stream,
    );
    // Mock closing of SignInFormCubit.
    when(() => mockSignInFormCubit.close()).thenAnswer((_) async {});

    // Create the app router with the mock AuthBloc.
    appRouter = createAppRouter(mockAuthBloc);
  });

  tearDown(() {
    authStateController.close();
    mockAuthBloc.close();
  });

  testWidgets(
    "Initial app verify have token if don't have go to login screen",
    (WidgetTester tester) async {
      when(() => mockStorage.getValue("token")).thenAnswer((_) async => null);

      when(() => mockStorage.removeKey("token")).thenAnswer((_) async => true);

      await tester.pumpWidget(createTestApp(
        appRouter: appRouter,
        providers: [
          BlocProvider<AuthBloc>.value(value: mockAuthBloc),
          BlocProvider<SignInFormCubit>.value(value: mockSignInFormCubit),
        ],
      ));

      final AuthState state = AuthState(
        authStatus: AuthStatus.notAuthenticated,
        errorMessage: '',
        user: null,
      );

      when(() => mockAuthBloc.state).thenReturn(state);

      authStateController.add(state);

      // Wait for the widget to be rendered.
      await tester.pumpAndSettle();

      expect(
        find.byType(LoginScreen),
        findsOneWidget,
        reason: "Login screen not found",
      );
    },
  );

  testWidgets(
    "Initial app verify have token if have go to home screen",
    (WidgetTester tester) async {
      final user = UserModel(
        id: "1",
        email: "test@user.com",
        fullName: "Tester User",
      );

      when(() => mockStorage.getValue("token"))
          .thenAnswer((_) async => "valid_token");

      await tester.pumpWidget(createTestApp(
        appRouter: appRouter,
        providers: [
          BlocProvider<AuthBloc>.value(value: mockAuthBloc),
          BlocProvider<SignInFormCubit>.value(value: mockSignInFormCubit),
        ],
      ));

      final AuthState state = AuthState(
        authStatus: AuthStatus.authenticated,
        errorMessage: '',
        user: user,
      );

      when(() => mockAuthBloc.state).thenReturn(state);

      authStateController.add(state);

      // Wait for the widget to be rendered.
      await tester.pumpAndSettle();

      expect(
        find.byType(HomeScreen),
        findsOneWidget,
        reason: "Home screen not found",
      );
    },
  );
}
