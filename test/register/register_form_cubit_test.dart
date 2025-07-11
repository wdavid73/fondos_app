import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_starter_kit/ui/blocs/auth/auth_bloc.dart';
import 'package:flutter_starter_kit/ui/cubits/cubits.dart';
import 'package:flutter_starter_kit/ui/shared/inputs/inputs.dart';
import 'package:mocktail/mocktail.dart';

import 'mocks/mock_register_dependencies.dart';

void main() {
  late MockAuthBloc mockAuthBloc;
  late RegisterFormCubit registerCubit;

  /// Registers a fallback value for [FakeAuthState]
  setUpAll(() {
    registerFallbackValue(FakeAuthState());
  });

  /// Creates a new cubit before each test
  setUp(() {
    mockAuthBloc = MockAuthBloc();
    registerCubit = RegisterFormCubit(authBloc: mockAuthBloc);
  });

  /// Closes the cubit after each test
  tearDown(() {
    registerCubit.close();
  });

  group("RegisterFormCubit", () {
    /// Tests the initial state of the cubit
    test("Initial state is correct", () {
      expect(registerCubit.state, equals(const RegisterFormState()));
    });

    /// Tests the [emailChanged] method
    test("emailChanged emits valid state when email is correct", () {
      const validEmail = "test@example.com";

      registerCubit.emailChanged(validEmail);

      final state = registerCubit.state;
      expect(state.email.value, equals(validEmail));
      expect(state.email.isValid, isTrue);
      expect(state.isValid, isFalse);
    });

    /// Tests the [fullNameChanged] method
    test("fullNameChanged emits valid state when fullName is correct", () {
      const validFullName = "John Doe";

      registerCubit.fullNameChanged(validFullName);

      final state = registerCubit.state;
      expect(state.fullName.value, equals(validFullName));
      expect(state.fullName.isValid, isTrue);
      expect(state.isValid, isFalse);
    });

    /// Tests the [passwordChanged] method
    test("passwordChanged emits valid state when password is correct", () {
      const validPassword = "Pass123*";

      registerCubit.passwordChanged(validPassword);

      final state = registerCubit.state;
      expect(state.password.value, equals(validPassword));
      expect(state.password.isValid, isTrue);
      expect(state.isValid, isFalse);
    });

    /// Tests the [onSubmit] method
    blocTest<RegisterFormCubit, RegisterFormState>(
      "onSubmit sets isPosting true then false after auth completes",
      build: () {
        when(() => mockAuthBloc.stream).thenAnswer((_) => Stream.fromIterable([
              const AuthState(authStatus: AuthStatus.checking),
              const AuthState(authStatus: AuthStatus.authenticated),
            ]));

        when(() => mockAuthBloc.register(
              email: "test@example.com",
              fullName: "John Doe",
              password: "Pass123*",
            )).thenAnswer((_) async {});

        return registerCubit;
      },
      seed: () => RegisterFormState(
        email: Email.dirty(value: "test@example.come"),
        fullName: TextInput.dirty(value: "John Doe"),
        password: Password.dirty(value: "Pass123*"),
        confirmPassword:
            ConfirmPassword.dirty(password: "Pass123*", value: "Pass123*"),
        isValid: true,
      ),
      act: (cubit) => cubit.onSubmit(),
      expect: () => [
        isA<RegisterFormState>().having(
          (s) => s.isPosting,
          "isPosting",
          isFalse,
        ),
        isA<RegisterFormState>().having(
          (s) => s.isPosting,
          "isPosting",
          isTrue,
        ), // start posting
        isA<RegisterFormState>().having(
          (s) => s.isPosting,
          "isPosting",
          isFalse,
        ), // after login
      ],
    );

    /// Tests the [onSubmit] method
    blocTest(
      "emits through a state where isPosting is false when AuthStatus is notAuthenticated",
      build: () {
        when(() => mockAuthBloc.stream).thenAnswer(
          (_) => Stream.value(
            const AuthState(authStatus: AuthStatus.notAuthenticated),
          ),
        );

        when(() => mockAuthBloc.register(
              email: "test@example.com",
              fullName: "John Doe",
              password: "Pass123*",
            )).thenAnswer((_) async {});

        return registerCubit;
      },
      seed: () => RegisterFormState(
        email: Email.dirty(value: "test@example.come"),
        fullName: TextInput.dirty(value: "John Doe"),
        password: Password.dirty(value: "Pass123*"),
        confirmPassword:
            ConfirmPassword.dirty(password: "Pass123*", value: "Pass123*"),
        isValid: true,
      ),
      act: (cubit) => cubit.onSubmit(),
      expect: () => [
        isA<RegisterFormState>().having(
          (s) => s.isPosting,
          "isPosting",
          isFalse,
        ),
        isA<RegisterFormState>().having(
          (s) => s.isPosting,
          "isPosting",
          isTrue,
        ), // start posting
        isA<RegisterFormState>().having(
          (s) => s.isPosting,
          "isPosting",
          isFalse,
        ), // after login
      ],
    );
  });
}
