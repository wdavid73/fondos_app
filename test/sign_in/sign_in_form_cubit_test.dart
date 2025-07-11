import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_starter_kit/ui/blocs/auth/auth_bloc.dart';
import 'package:flutter_starter_kit/ui/cubits/cubits.dart';
import 'package:flutter_starter_kit/ui/shared/inputs/inputs.dart';
import 'package:mocktail/mocktail.dart';

import 'mocks/mock_sign_in_dependencies.dart';

void main() {
  late MockAuthBloc mockAuthBloc;
  late SignInFormCubit signInFormCubit;

  /// Registers a fallback value for [FakeAuthState]
  setUpAll(() {
    registerFallbackValue(FakeAuthState());
  });

  /// Creates a new cubit before each test
  setUp(() {
    mockAuthBloc = MockAuthBloc();
    when(() => mockAuthBloc.stream).thenAnswer((_) => const Stream.empty());
    when(() => mockAuthBloc.login(any(), any())).thenReturn(null);
    signInFormCubit = SignInFormCubit(authBloc: mockAuthBloc);
  });

  /// Closes the cubit after each test
  tearDown(() {
    signInFormCubit.close();
  });

  /// Tests the [SignInFormCubit]
  group("SignInFormCubit", () {
    /// Tests the initial state of the cubit
    test("Initial state is correct", () {
      expect(signInFormCubit.state, equals(const SignInFormState()));
    });

    /// Tests the [emailChanged] method
    test("emailChanged emits valid state when email is correct", () {
      const validEmail = "test@example.com";

      signInFormCubit.emailChanged(validEmail);

      final state = signInFormCubit.state;
      expect(state.email.value, equals(validEmail));
      expect(state.email.isValid, isTrue);
      expect(state.isValid, isFalse);
    });

    /// Tests the [passwordChanged] method
    test("passwordChanged emits valid state when password is correct", () {
      const validPassword = "Pass123*";

      signInFormCubit.passwordChanged(validPassword);

      final state = signInFormCubit.state;
      expect(state.password.value, equals(validPassword));
      expect(state.password.isValid, isTrue);
      expect(state.isValid, isFalse);
    });

    /// Tests the [onSubmit] method
    blocTest<SignInFormCubit, SignInFormState>(
      "onSubmit sets isPosting true then false after auth completes",
      build: () {
        when(() => mockAuthBloc.stream).thenAnswer((_) => Stream.fromIterable([
              const AuthState(authStatus: AuthStatus.checking),
              const AuthState(authStatus: AuthStatus.authenticated),
            ]));

        when(() => mockAuthBloc.login(any(), any())).thenReturn(null);

        return signInFormCubit;
      },
      seed: () => SignInFormState(
        email: Email.dirty(value: "test@example.come"),
        password: Password.dirty(value: "Pass123*"),
        isValid: true,
      ),
      act: (cubit) => cubit.onSubmit(),
      expect: () => [
        isA<SignInFormState>().having(
          (s) => s.isPosting,
          "isPosting",
          isFalse,
        ), // touch fields
        isA<SignInFormState>().having(
          (s) => s.isPosting,
          "isPosting",
          isTrue,
        ), // start posting
        isA<SignInFormState>().having(
          (s) => s.isPosting,
          "isPosting",
          isFalse,
        ), // after login
      ],
    );

    blocTest<SignInFormCubit, SignInFormState>(
      "emits through a state where isPosting is false when AuthStatus is notAuthenticated",
      build: () {
        when(() => mockAuthBloc.stream).thenAnswer(
          (_) => Stream.value(
            const AuthState(authStatus: AuthStatus.notAuthenticated),
          ),
        );

        when(() => mockAuthBloc.login(any(), any())).thenReturn(null);

        return SignInFormCubit(authBloc: mockAuthBloc);
      },
      seed: () => SignInFormState(
        email: Email.dirty(value: "test@example.com"),
        password: Password.dirty(value: "Pass123*"),
        isValid: true,
      ),
      act: (cubit) => cubit.onSubmit(),
      verify: (_) {
        verify(() => mockAuthBloc.login(any(), any())).called(1);
      },
      expect: () => [
        isA<SignInFormState>().having(
          (s) => s.isPosting,
          "isPosting",
          isFalse,
        ), // touch fields
        isA<SignInFormState>().having(
          (s) => s.isPosting,
          "isPosting",
          isTrue,
        ), // start posting
        isA<SignInFormState>().having(
          (s) => s.isPosting,
          "isPosting",
          isFalse,
        ), // after login
      ],
    );
  });
}
