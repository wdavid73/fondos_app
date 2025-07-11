import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:flutter_starter_kit/config/config.dart';
import 'package:flutter_starter_kit/ui/blocs/blocs.dart';
import 'package:flutter_starter_kit/ui/cubits/cubits.dart';
import 'package:flutter_starter_kit/ui/screens/screens.dart';
import 'package:flutter_starter_kit/api/api.dart';
import 'package:flutter_starter_kit/data/data.dart';
import 'package:flutter_starter_kit/ui/shared/inputs/inputs.dart';

import './mocks/auth_flow_dependencies.dart';

void main() {
  // Ensure Flutter is initialized for integration testing.
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  // Declare mock objects for dependencies.
  late MockAuthBloc mockAuthBloc;
  late MockSignInFormCubit mockSignInFormCubit;
  late MockKeyValueStorageService mockStorage;
  late MockAuthUse mockAuthUse;
  late GoRouter appRouter;

  // Declare stream controllers for state management.
  late StreamController<AuthState> authStateController;
  late StreamController<SignInFormState> signInFormStateController;

  // Set up all is executed once before all tests.
  setUpAll(() {
    // Register fallback values for mock objects.
    registerFallbackValue(FakeAuthState());
    registerFallbackValue(FakeAuthEvent());
  });

  // Set up is executed before each test.
  setUp(() {
    // Initialize mock objects.
    mockAuthBloc = MockAuthBloc();
    mockSignInFormCubit = MockSignInFormCubit();
    mockAuthUse = MockAuthUse();
    mockStorage = MockKeyValueStorageService();
    // Initialize stream controllers.
    authStateController = StreamController<AuthState>.broadcast();
    signInFormStateController = StreamController<SignInFormState>.broadcast();

    /// Auth flow set up mock auth bloc
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

    /// Auth flow set up mock sign in form cubit
    // Mock initial state of SignInFormCubit.
    when(() => mockSignInFormCubit.state).thenReturn(const SignInFormState());
    // Mock stream of SignInFormCubit states.
    when(() => mockSignInFormCubit.stream).thenAnswer(
      (_) => signInFormStateController.stream,
    );
    // Mock closing of SignInFormCubit.
    when(() => mockSignInFormCubit.close()).thenAnswer((_) async {});

    /// Auth flow set up router
    // Create the app router with the mock AuthBloc.
    appRouter = createAppRouter(mockAuthBloc);
  });

  // Tear down is executed after each test.
  tearDown(() {
    // Close stream controllers.
    authStateController.close();
    mockAuthBloc.close();
    mockSignInFormCubit.close();
  });

  // Test case: Initial navigation to login when no token.
  testWidgets(
    'Initial navigation to login when no token',
    (WidgetTester tester) async {
      // Mock the storage to return null for the token.
      when(() => mockStorage.getValue('token')).thenAnswer(
        (_) async => null,
      );

      // Build the test app.
      await tester.pumpWidget(createTestApp(
        appRouter: appRouter,
        providers: [
          BlocProvider<AuthBloc>.value(value: mockAuthBloc),
          BlocProvider<SignInFormCubit>.value(value: mockSignInFormCubit),
        ],
      ));

      // Add a state to the AuthBloc indicating not authenticated.
      authStateController.add(
        const AuthState(authStatus: AuthStatus.notAuthenticated),
      );

      // Wait for the app to settle and rebuild.
      await tester.pumpAndSettle();

      // Assert that the LoginScreen is displayed.
      expect(find.byType(LoginScreen), findsOneWidget);
      // Assert that the CheckAuthStatusScreen is not displayed.
      expect(find.byType(CheckAuthStatusScreen), findsNothing);
    },
  );

  // Test case: Login with valid credentials but not authenticated.
  testWidgets(
    'Login with valid credentials but not authenticated',
    (WidgetTester tester) async {
      // Mock the use case for authentication.
      when(() => mockAuthBloc.useCase).thenReturn(mockAuthUse);

      // Mock the onSubmit method of the SignInFormCubit.
      when(() => mockSignInFormCubit.onSubmit()).thenAnswer((_) async {
        final email = mockSignInFormCubit.state.email.value;
        final password = mockSignInFormCubit.state.password.value;
        // Call the login method of the AuthBloc.
        mockAuthBloc.login(email, password);
      });

      // Mock the login method of the AuthBloc.
      when(() => mockAuthBloc.login(any(), any()))
          .thenAnswer((invocation) async {
        mockAuthUse.login(
          invocation.positionalArguments[0] as String,
          invocation.positionalArguments[1] as String,
        );
      });

      // Build the test app.
      await tester.pumpWidget(createTestApp(
        appRouter: appRouter,
        providers: [
          BlocProvider<AuthBloc>.value(value: mockAuthBloc),
          BlocProvider<SignInFormCubit>.value(value: mockSignInFormCubit),
        ],
      ));

      // Add a state to the AuthBloc indicating not authenticated.
      authStateController.add(
        const AuthState(authStatus: AuthStatus.notAuthenticated),
      );

      // Wait for the app to settle and rebuild.
      await tester.pumpAndSettle();

      // Assert that the LoginScreen is displayed.
      expect(
        find.byType(LoginScreen),
        findsOneWidget,
        reason: 'Login screen not found',
      );

      // Find the email and password fields and the login button.
      final emailField = find.byKey(const Key("email_field"));
      final passwordField = find.byKey(const Key("password_field"));
      final loginButton = find.byKey(const Key("login_button"));

      // Assert that the email and password fields and the login button are found.
      expect(emailField, findsOneWidget, reason: 'Email field not found');
      expect(passwordField, findsOneWidget, reason: 'Password field not found');
      expect(loginButton, findsOneWidget, reason: 'Login button not found');

      // Enter text into the email and password fields.
      await tester.enterText(emailField, 'wilson@padilla.com');
      await tester.enterText(passwordField, 'Wilson123*');

      // Assert that the text is entered correctly.
      expect(
        find.text('wilson@padilla.com'),
        findsOneWidget,
        reason: 'Email field text not found',
      );
      expect(
        find.text('Wilson123*'),
        findsOneWidget,
        reason: 'Password field text not found',
      );

      // Create email and password objects.
      final email = Email.dirty(value: 'wilson@padilla.com');
      final password = Password.dirty(value: 'Wilson123*');

      // Mock the state of the SignInFormCubit.
      when(() => mockSignInFormCubit.state).thenReturn(SignInFormState(
        isValid: true,
        isPosting: false,
        email: email,
        password: password,
      ));

      // Mock the login method of the AuthUse.
      when(() => mockAuthUse.login(email.value, password.value)).thenAnswer(
        (_) async => ResponseFailed(
          InternalServerErrorException(
            requestOptions: RequestOptions(),
            message: "Mock internal Server Error",
          ),
        ),
      );

      // Tap the login button.
      await tester.tap(loginButton);

      // Verify that the onSubmit and login methods are called.
      verify(() => mockSignInFormCubit.onSubmit()).called(1);
      verify(() => mockAuthBloc.login(email.value, password.value)).called(1);
      verify(() => mockAuthUse.login(email.value, password.value)).called(1);

      // Wait for the app to settle and rebuild.
      await tester.pumpAndSettle();

      // Mock the state of the AuthBloc.
      when(() => mockAuthBloc.state).thenReturn(AuthState(
        authStatus: AuthStatus.notAuthenticated,
        errorMessage: "Mock internal Server Error",
      ));

      // Add a state to the AuthBloc indicating not authenticated and with an error message.
      authStateController.add(const AuthState(
        authStatus: AuthStatus.notAuthenticated,
        errorMessage: "Mock internal Server Error",
      ));

      // Wait for the app to settle and rebuild.
      await tester.pumpAndSettle();

      // Assert that the error message is displayed.
      expect(find.text("Mock internal Server Error"), findsOneWidget);
    },
  );

  // Test case: Login with valid credentials and navigate to home screen.
  testWidgets(
    'Login with valid credentials and navigate to home screen',
    (WidgetTester tester) async {
      final String emailValue = "wilson@padilla.com";
      final String passwordValue = "Wilson123*";
      final loginSuccess = AuthResponseModel(
        user: UserModel(id: "1", email: emailValue, fullName: "Test User"),
        token: "valid_token",
      );

      // Mock the use case for authentication.
      when(() => mockAuthBloc.useCase).thenReturn(mockAuthUse);

      // Mock the onSubmit method of the SignInFormCubit.
      when(() => mockSignInFormCubit.onSubmit()).thenAnswer((_) async {
        final email = mockSignInFormCubit.state.email.value;
        final password = mockSignInFormCubit.state.password.value;
        mockAuthBloc.login(email, password);
      });

      // Mock the login method of the AuthBloc.
      when(() => mockAuthBloc.login(any(), any())).thenAnswer(
        (invocation) async {
          mockAuthUse.login(
            invocation.positionalArguments[0] as String,
            invocation.positionalArguments[1] as String,
          );
        },
      );

      // Mock the login method of the AuthUse.
      when(() => mockStorage.setKeyValue("token", loginSuccess.token))
          .thenAnswer((_) async {});

      // Build the test app.
      await tester.pumpWidget(createTestApp(
        appRouter: appRouter,
        providers: [
          BlocProvider<AuthBloc>.value(value: mockAuthBloc),
          BlocProvider<SignInFormCubit>.value(value: mockSignInFormCubit),
        ],
      ));

      // Add a state to the AuthBloc indicating not authenticated.
      authStateController.add(
        const AuthState(authStatus: AuthStatus.notAuthenticated),
      );

      // Wait for the app to settle and rebuild.
      await tester.pumpAndSettle();

      // Assert that the LoginScreen is displayed.
      expect(
        find.byType(LoginScreen),
        findsOneWidget,
        reason: 'Login screen not found',
      );

      // Find the email and password fields and the login button.
      final emailField = find.byKey(const Key("email_field"));
      final passwordField = find.byKey(const Key("password_field"));
      final loginButton = find.byKey(const Key("login_button"));

      // Assert that the email and password fields and the login button are found.
      expect(emailField, findsOneWidget, reason: "Email field not found");
      expect(passwordField, findsOneWidget, reason: "Password field not found");
      expect(loginButton, findsOneWidget, reason: "Login button not found");

      // Enter text into the email and password fields.
      await tester.enterText(emailField, emailValue);
      await tester.enterText(passwordField, passwordValue);

      // Assert that the text is entered correctly.
      expect(
        find.text(emailValue),
        findsOneWidget,
        reason: 'Email field text not found',
      );
      expect(
        find.text(passwordValue),
        findsOneWidget,
        reason: 'Password field text not found',
      );

      // Create email and password objects.
      final email = Email.dirty(value: emailValue);
      final password = Password.dirty(value: passwordValue);

      // Mock the state of the SignInFormCubit.
      when(() => mockSignInFormCubit.state).thenReturn(SignInFormState(
        isValid: true,
        isPosting: false,
        email: email,
        password: password,
      ));

      // Mock the login method of the AuthUse.
      when(() => mockAuthUse.login(email.value, password.value))
          .thenAnswer((_) async {
        return ResponseSuccess(loginSuccess, 200);
      });

      // Tap the login button
      await tester.tap(loginButton);

      verify(() => mockSignInFormCubit.onSubmit()).called(1);
      verify(() => mockAuthBloc.login(email.value, password.value)).called(1);
      verify(() => mockAuthUse.login(email.value, password.value)).called(1);

      // Wait for the app to settle and rebuild.
      await tester.pumpAndSettle();

      // Mock the state of the AuthBloc.
      when(() => mockAuthBloc.state).thenReturn(AuthState(
        authStatus: AuthStatus.authenticated,
        user: loginSuccess.user,
        errorMessage: "",
      ));

      // Add a state to the AuthBloc indicating authenticated.
      authStateController.add(AuthState(
        authStatus: AuthStatus.authenticated,
        user: loginSuccess.user,
        errorMessage: "",
      ));

      // Wait for the app to settle and rebuild.
      await tester.pumpAndSettle();

      expect(
        find.byType(HomeScreen),
        findsOneWidget,
        reason: "Home screen not found",
      );
    },
  );
}
