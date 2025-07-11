import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formz/formz.dart';
import 'package:flutter_starter_kit/api/api.dart';
import 'package:flutter_starter_kit/data/data.dart';
import 'package:go_router/go_router.dart';
import 'package:integration_test/integration_test.dart';

import 'package:flutter_starter_kit/config/config.dart';
import 'package:flutter_starter_kit/ui/cubits/cubits.dart';
import 'package:flutter_starter_kit/ui/screens/screens.dart';
import 'package:flutter_starter_kit/ui/shared/inputs/inputs.dart';
import 'package:flutter_starter_kit/ui/blocs/blocs.dart';
import 'package:mocktail/mocktail.dart';

import 'mocks/auth_flow_dependencies.dart';

void main() {
  // Ensure Flutter is initialized for integration testing.
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  // Declare mock objects for dependencies.
  late MockAuthBloc mockAuthBloc;
  late MockRegisterFormCubit mockRegisterFormCubit;
  late MockSignInFormCubit mockSignInFormCubit;
  late MockKeyValueStorageService mockStorage;
  late MockAuthUse mockAuthUse;
  late GoRouter appRouter;

  // Declare stream controllers for state management.
  late StreamController<AuthState> authStateController;
  late StreamController<RegisterFormState> registerFormStateController;
  late StreamController<SignInFormState> signInFormStateController;

  // Set up all is executed once before all tests.
  setUpAll(() {
    registerFallbackValue(FakeAuthState());
    registerFallbackValue(FakeAuthEvent());
  });

  // Set up is executed before each test.
  setUp(() {
    // Initialize mock objects.
    mockAuthBloc = MockAuthBloc();
    mockRegisterFormCubit = MockRegisterFormCubit();
    mockSignInFormCubit = MockSignInFormCubit();
    mockAuthUse = MockAuthUse();
    mockStorage = MockKeyValueStorageService();

    // Initialize stream controllers.
    authStateController = StreamController<AuthState>.broadcast();
    signInFormStateController = StreamController<SignInFormState>.broadcast();
    registerFormStateController =
        StreamController<RegisterFormState>.broadcast();

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
    when(() => mockRegisterFormCubit.state)
        .thenReturn(const RegisterFormState());
    // Mock stream of SignInFormCubit states.
    when(() => mockRegisterFormCubit.stream).thenAnswer(
      (_) => registerFormStateController.stream,
    );
    // Mock closing of SignInFormCubit.
    when(() => mockRegisterFormCubit.close()).thenAnswer((_) async {});

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
    authStateController.close();
    mockAuthBloc.close();
    mockRegisterFormCubit.close();
  });

  Future<void> navigateToRegister(WidgetTester tester) async {
    when(() => mockStorage.getValue('token')).thenAnswer(
      (_) async => null,
    );

    await tester.pumpWidget(createTestApp(
      appRouter: appRouter,
      providers: [
        BlocProvider<AuthBloc>.value(value: mockAuthBloc),
        BlocProvider<SignInFormCubit>.value(value: mockSignInFormCubit),
        BlocProvider<RegisterFormCubit>.value(value: mockRegisterFormCubit),
      ],
    ));

    // Add a state to the AuthBloc indicating not authenticated.
    authStateController.add(
      const AuthState(authStatus: AuthStatus.notAuthenticated),
    );

    // Wait for the widget to be rendered.
    await tester.pumpAndSettle();

    final goToRegisterButton = find.byKey(const Key("go_to_register_screen"));
    expect(goToRegisterButton, findsOneWidget, reason: "Button not found");

    await tester.tap(goToRegisterButton);
    await tester.pumpAndSettle();
  }

  // Testcase init app verify stay in login screen and go to register screen
  testWidgets(
    "Initial app verify stay in login screen and go to register screen",
    (WidgetTester tester) async {
      when(() => mockStorage.getValue('token')).thenAnswer(
        (_) async => null,
      );

      // Build the test app.
      await tester.pumpWidget(createTestApp(
        appRouter: appRouter,
        providers: [
          BlocProvider<AuthBloc>.value(value: mockAuthBloc),
          BlocProvider<SignInFormCubit>.value(value: mockSignInFormCubit),
          BlocProvider<RegisterFormCubit>.value(value: mockRegisterFormCubit),
        ],
      ));

      // Add a state to the AuthBloc indicating not authenticated.
      authStateController.add(
        const AuthState(authStatus: AuthStatus.notAuthenticated),
      );

      // Wait for the widget to be rendered.
      await tester.pumpAndSettle();

      // Verify that the login screen is displayed.
      expect(
        find.byType(LoginScreen),
        findsOneWidget,
        reason: "Login screen not found",
      );

      final goToRegisterButton = find.byKey(const Key("go_to_register_screen"));
      expect(goToRegisterButton, findsOneWidget, reason: "Button not found");

      await tester.tap(goToRegisterButton);
      await tester.pumpAndSettle();

      expect(
        find.byType(RegisterScreen),
        findsOneWidget,
        reason: "Register screen not found",
      );
    },
  );

  group("Validation form register", () {
    // TestCase validate if passwords is different
    testWidgets("Passwords different", (WidgetTester tester) async {
      await navigateToRegister(tester);

      expect(
        find.byType(RegisterScreen),
        findsOneWidget,
        reason: "Register screen not found",
      );

      await enterRegisterFormData(
        tester: tester,
        fullName: "Tester User",
        email: "test@user.com",
        password: "Password123*",
        confirmPassword: "Password1234*",
      );

      final fullName = TextInput.dirty(value: 'Wilson Padilla');
      final email = Email.dirty(value: 'wilson@padilla.com');
      final password = Password.dirty(value: 'Wilson123*');
      final confirmPassword = ConfirmPassword.dirty(
        value: "Wilson1234*",
        password: password.value,
      );

      final RegisterFormState state = RegisterFormState(
        isValid: Formz.validate([confirmPassword, email, fullName, password]),
        isPosting: false,
        fullName: fullName,
        email: email,
        password: password,
        confirmPassword: confirmPassword,
      );

      when(() => mockRegisterFormCubit
          .confirmPasswordChanged(confirmPassword.value)).thenAnswer(
        (_) async => RegisterFormState(
          confirmPassword: confirmPassword,
          isValid: Formz.validate([confirmPassword, email, fullName, password]),
        ),
      );

      when(() => mockRegisterFormCubit.state).thenReturn(state);

      registerFormStateController.add(state);

      await tester.pumpAndSettle();

      expect(confirmPassword.isValid, isFalse, reason: "Passwords different");
      expect(
        find.text("is_not_equal_password"),
        findsOneWidget,
        reason: "Text validation password not found",
      );
    });

    // Testcase validate form email invalid format
    testWidgets('Email invalid Format', (WidgetTester tester) async {
      await navigateToRegister(tester);

      expect(find.byType(RegisterScreen), findsOneWidget,
          reason: "Register screen not found");

      await enterRegisterFormData(
        tester: tester,
        fullName: "Tester User",
        email: "wrongEmail",
        password: "Password123*",
        confirmPassword: "Password123*",
      );

      final fullName = TextInput.dirty(value: 'Wilson Padilla');
      final email = Email.dirty(value: 'wrongEmail');
      final password = Password.dirty(value: 'Wilson123*');
      final confirmPassword = ConfirmPassword.dirty(
        value: "Wilson123*",
        password: password.value,
      );

      final RegisterFormState state = RegisterFormState(
        isValid: Formz.validate([confirmPassword, email, fullName, password]),
        isPosting: false,
        fullName: fullName,
        email: email,
        password: password,
        confirmPassword: confirmPassword,
      );

      when(() => mockRegisterFormCubit.emailChanged(email.value)).thenAnswer(
        (_) async => RegisterFormState(
          email: email,
          isValid: Formz.validate([confirmPassword, email, fullName, password]),
        ),
      );

      when(() => mockRegisterFormCubit.state).thenReturn(state);

      registerFormStateController.add(state);

      await tester.pumpAndSettle();

      expect(email.isValid, isFalse, reason: "Email invalid format");
      expect(
        find.text("is_email"),
        findsOneWidget,
        reason: "Text validation email not found",
      );
    });

    // Testcase validate form empty
    testWidgets('Email is empty', (WidgetTester tester) async {
      await navigateToRegister(tester);

      expect(find.byType(RegisterScreen), findsOneWidget,
          reason: "Register screen not found");

      await enterRegisterFormData(
        tester: tester,
        fullName: "Tester User",
        email: "",
        password: "Password123*",
        confirmPassword: "Password123*",
      );

      final fullName = TextInput.dirty(value: 'Wilson Padilla');
      final email = Email.dirty(value: '');
      final password = Password.dirty(value: 'Wilson123*');
      final confirmPassword = ConfirmPassword.dirty(
        value: "Wilson123*",
        password: password.value,
      );

      final RegisterFormState state = RegisterFormState(
        isValid: Formz.validate([confirmPassword, email, fullName, password]),
        isPosting: false,
        fullName: fullName,
        email: email,
        password: password,
        confirmPassword: confirmPassword,
      );

      when(() => mockRegisterFormCubit.emailChanged(email.value)).thenAnswer(
        (_) async => RegisterFormState(
          email: email,
          isValid: Formz.validate([confirmPassword, email, fullName, password]),
        ),
      );

      when(() => mockRegisterFormCubit.state).thenReturn(state);

      registerFormStateController.add(state);

      await tester.pumpAndSettle();

      expect(email.isValid, isFalse, reason: "Email is empty");
      expect(
        find.text("is_required"),
        findsOneWidget,
        reason: "Text validation email not found",
      );
    });
  });

  group("Register user flow", () {
    void setUpRegisterMock() {
      when(() => mockRegisterFormCubit.onSubmit()).thenAnswer((_) async {
        final email = mockRegisterFormCubit.state.email.value;
        final password = mockRegisterFormCubit.state.password.value;
        final fullName = mockRegisterFormCubit.state.fullName.value;
        mockAuthBloc.register(
          email: email,
          password: password,
          fullName: fullName,
        );
      });

      when(() => mockAuthBloc.useCase).thenReturn(mockAuthUse);

      when(() => mockAuthBloc.register(
          email: any(named: "email"),
          password: any(named: "password"),
          fullName: any(named: "fullName"))).thenAnswer(
        (invocation) async {
          mockAuthUse.register(
            invocation.namedArguments[#email] as String,
            invocation.namedArguments[#password] as String,
            invocation.namedArguments[#fullName] as String,
          );
        },
      );
    }

    void setUpVerificationMocks(
      Email email,
      Password password,
      TextInput fullName,
    ) {
      verify(() => mockRegisterFormCubit.onSubmit()).called(1);
      verify(() => mockAuthBloc.register(
            email: email.value,
            password: password.value,
            fullName: fullName.value,
          )).called(1);
      verify(() => mockAuthUse.register(
            email.value,
            password.value,
            fullName.value,
          )).called(1);
    }

    void setUpRegisterFormState(
      Email email,
      Password password,
      ConfirmPassword confirmPassword,
      TextInput fullName,
    ) {
      final RegisterFormState state = RegisterFormState(
        isValid: true,
        isPosting: false,
        fullName: fullName,
        email: email,
        password: password,
        confirmPassword: confirmPassword,
      );

      when(() => mockRegisterFormCubit.state).thenReturn(state);

      registerFormStateController.add(state);
    }

    testWidgets(
      "Register user and get error from api",
      (WidgetTester tester) async {
        final String fullNameValue = "Test user";
        final String emailValue = "test@user.com";
        final String passwordValue = "Password123*";

        setUpRegisterMock();

        await navigateToRegister(tester);

        expect(find.byType(RegisterScreen), findsOneWidget,
            reason: "Register screen not found");

        await enterRegisterFormData(
          tester: tester,
          fullName: fullNameValue,
          email: emailValue,
          password: passwordValue,
          confirmPassword: passwordValue,
        );
        final registerButton = find.byKey(const Key("register_button"));

        final fullName = TextInput.dirty(value: fullNameValue);
        final email = Email.dirty(value: emailValue);
        final password = Password.dirty(value: passwordValue);
        final confirmPassword = ConfirmPassword.dirty(
          value: passwordValue,
          password: password.value,
        );

        setUpRegisterFormState(email, password, confirmPassword, fullName);

        when(() => mockAuthUse.register(
            email.value, password.value, fullName.value)).thenAnswer(
          (_) async => ResponseFailed(
            BadResponse(
              RequestOptions(),
              message: "Mock bad request",
            ),
          ),
        );

        await tester.pumpAndSettle();

        await tester.tap(registerButton);

        setUpVerificationMocks(email, password, fullName);

        await tester.pumpAndSettle();

        when(() => mockAuthBloc.state).thenReturn(AuthState(
          authStatus: AuthStatus.notAuthenticated,
          errorMessage: "Mock Bad Request",
        ));

        authStateController.add(const AuthState(
          authStatus: AuthStatus.notAuthenticated,
          errorMessage: "Mock Bad Request",
        ));

        await tester.pumpAndSettle();

        expect(find.text("Mock Bad Request"), findsOneWidget);
      },
    );

    testWidgets(
      "Register user and get success from api and go to home screen",
      (WidgetTester tester) async {
        final String fullNameValue = "Test user";
        final String emailValue = "test@user.com";
        final String passwordValue = "Password123*";
        final registerSuccess = AuthResponseModel(
          user: UserModel(id: "1", email: emailValue, fullName: fullNameValue),
          token: "valid_token",
        );

        setUpRegisterMock();

        // Mock the storage services.
        when(() => mockStorage.setKeyValue("token", registerSuccess.token))
            .thenAnswer((_) async {});

        await navigateToRegister(tester);

        expect(find.byType(RegisterScreen), findsOneWidget,
            reason: "Register screen not found");

        await enterRegisterFormData(
          tester: tester,
          fullName: fullNameValue,
          email: emailValue,
          password: passwordValue,
          confirmPassword: passwordValue,
        );
        final registerButton = find.byKey(const Key("register_button"));

        final fullName = TextInput.dirty(value: fullNameValue);
        final email = Email.dirty(value: emailValue);
        final password = Password.dirty(value: passwordValue);
        final confirmPassword = ConfirmPassword.dirty(
          value: passwordValue,
          password: password.value,
        );

        setUpRegisterFormState(email, password, confirmPassword, fullName);

        when(() => mockAuthUse.register(
            email.value, password.value, fullName.value)).thenAnswer(
          (_) async => ResponseSuccess(registerSuccess, 201),
        );

        await tester.pumpAndSettle();

        await tester.tap(registerButton);

        setUpVerificationMocks(email, password, fullName);

        await tester.pumpAndSettle();

        when(() => mockAuthBloc.state).thenReturn(AuthState(
          authStatus: AuthStatus.authenticated,
          user: registerSuccess.user,
          errorMessage: "",
        ));

        authStateController.add(AuthState(
          authStatus: AuthStatus.authenticated,
          user: registerSuccess.user,
          errorMessage: "",
        ));

        await tester.pumpAndSettle();

        expect(
          find.byType(HomeScreen),
          findsOneWidget,
          reason: "Home screen not found",
        );
      },
    );
  });
}
