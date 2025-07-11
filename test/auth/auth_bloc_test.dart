import 'package:bloc_test/bloc_test.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_starter_kit/api/api.dart';
import 'package:flutter_starter_kit/data/data.dart';
import 'package:flutter_starter_kit/ui/blocs/auth/auth_bloc.dart';
import 'package:mocktail/mocktail.dart';

import 'mocks/mock_auth_bloc_dependencies.dart';

class TestAuthBloc extends AuthBloc {
  TestAuthBloc(super.useCase, super.keyValueStorageService);

  @override
  void checkAuthStatus() {
    // override empty
  }
}

void main() {
  late TestAuthBloc authBloc;
  late MockAuthUseCase mockAuthUseCase;
  late MockKeyValueStorageService mockStorageService;

  /// Creates a new instance of [AuthBloc] before each test.
  setUp(() {
    mockAuthUseCase = MockAuthUseCase();
    mockStorageService = MockKeyValueStorageService();
    authBloc = TestAuthBloc(mockAuthUseCase, mockStorageService);
  });

  /// Closes the [AuthBloc] after each test.
  tearDown(() {
    authBloc.close();
  });

  /// Tests the [AuthBloc]
  group("AuthBloc", () {
    /// Tests the [login] method when login is successful
    blocTest<AuthBloc, AuthState>(
      "emits [checking, authenticated] when login is successful",
      build: () {
        final authResponse = AuthResponseModel(
          token: 'fake_token',
          user: UserModel(
            id: '1',
            fullName: 'John Doe',
            email: 'johndoe@example.com',
          ),
        );

        when(() => mockAuthUseCase.login(any(), any())).thenAnswer(
          (_) async => ResponseSuccess(authResponse, 200),
        );

        when(() => mockStorageService.setKeyValue<String>(any(), any()))
            .thenAnswer((_) async {}); // Future<void>

        return authBloc;
      },
      act: (bloc) => bloc.login("test@example.com", "password123"),
      expect: () => [
        isA<AuthState>().having(
          (s) => s.authStatus,
          "authStatus",
          AuthStatus.checking,
        ),
        isA<AuthState>().having(
          (s) => s.authStatus,
          "authStatus",
          AuthStatus.authenticated,
        ),
      ],
    );

    /// Tests the [login] method when login fails
    blocTest<AuthBloc, AuthState>(
      "emits [checking, notAuthenticated] when login is fails",
      build: () {
        when(() => mockAuthUseCase.login(any(), any())).thenAnswer(
          (_) async => ResponseFailed(DioException(
              message: "Login failed", requestOptions: RequestOptions())),
        );
        return authBloc;
      },
      act: (bloc) => bloc.login("wrong@example", "wrongPassword"),
      expect: () => [
        isA<AuthState>().having(
          (s) => s.authStatus,
          "authStatus",
          AuthStatus.checking,
        ),
        isA<AuthState>().having(
          (s) => s.authStatus,
          "authStatus",
          AuthStatus.notAuthenticated,
        ),
      ],
    );

    /// Tests the [checkAuthStatus] method when token is found
    blocTest<AuthBloc, AuthState>(
      'emits [checking, notAuthenticated] when no token is found',
      build: () {
        when(() => mockStorageService.getValue<String>("token")).thenAnswer(
          (_) async => null,
        );

        when(() => mockStorageService.removeKey("token")).thenAnswer(
          (_) async => true,
        );

        return authBloc;
      },
      act: (bloc) => bloc.add(CheckAuthStatusEvent()),
      expect: () => [
        isA<AuthState>().having(
          (s) => s.authStatus,
          "authStatus",
          AuthStatus.notAuthenticated,
        ),
      ],
    );

    /// Tests the [checkAuthStatus] method when token is valid
    blocTest<AuthBloc, AuthState>(
      "emits [checking, authenticated] when token is valid and user data is loaded",
      build: () {
        final someMockUser = UserModel(
          id: '1',
          email: 'user@example.com',
          fullName: 'Joe Doe',
        );

        when(() => mockStorageService.getValue<String>('token'))
            .thenAnswer((_) async => "valid_token");

        when(() => mockAuthUseCase.checkAuthStatus("valid_token")).thenAnswer(
          (_) async => ResponseSuccess(
            AuthResponseModel(token: 'valid_token', user: someMockUser),
            200,
          ),
        );

        when(() => mockStorageService.setKeyValue('token', 'valid_token'))
            .thenAnswer((_) async {});

        when(() => mockStorageService.removeKey(any()))
            .thenAnswer((_) async => true);

        return authBloc;
      },
      act: (bloc) => bloc.add(CheckAuthStatusEvent()),
      expect: () => [
        isA<AuthState>().having(
          (s) => s.authStatus,
          "authStatus",
          AuthStatus.authenticated,
        )
      ],
    );

    /// Tests the [checkAuthStatus] method when token is invalid
    blocTest<AuthBloc, AuthState>(
      "emits [checking, authenticated] when token is not valid",
      build: () {
        when(() => mockStorageService.getValue<String>('token'))
            .thenAnswer((_) async => "mocked_token");

        when(() => mockAuthUseCase.checkAuthStatus("valid_token")).thenAnswer(
          (_) async => ResponseFailed(DioException(
            message: "checkAuthStatus failed",
            requestOptions: RequestOptions(),
          )),
        );

        when(() => mockStorageService.removeKey("token"))
            .thenAnswer((_) async => true);

        return authBloc;
      },
      act: (bloc) => bloc.add(CheckAuthStatusEvent()),
      expect: () => [
        isA<AuthState>().having(
          (s) => s.authStatus,
          "authStatus",
          AuthStatus.notAuthenticated,
        )
      ],
    );

    /// Tests the [logout] method
    blocTest<AuthBloc, AuthState>(
      'emits [notAuthenticated] when logout is called',
      build: () {
        when(() => mockStorageService.removeKey("token"))
            .thenAnswer((_) async => true);

        return authBloc;
      },
      act: (bloc) => bloc.add(LogoutEvent()),
      expect: () => [
        isA<AuthState>().having(
          (s) => s.authStatus,
          "authStatus",
          AuthStatus.notAuthenticated,
        ),
      ],
    );

    /// Tests the [register] method when registration is successful
    blocTest<AuthBloc, AuthState>(
      'emits [isCreating false, isCreating true, authenticated] when register is successful',
      build: () {
        final authResponse = AuthResponseModel(
          token: "fake_token",
          user: UserModel(
            email: "fake@email.com",
            fullName: "fake user",
            id: "1",
          ),
        );

        when(() => mockAuthUseCase.register(any(), any(), any())).thenAnswer(
          (_) async => ResponseSuccess(authResponse, 201),
        );

        when(() => mockStorageService.setKeyValue<String>(any(), any()))
            .thenAnswer((_) async {});

        return authBloc;
      },
      wait: const Duration(milliseconds: 200),
      act: (bloc) => bloc.add(
        RegisterEvent(
          email: "fake@email.com",
          fullName: "fake user",
          password: "Pass123",
        ),
      ),
      expect: () => [
        isA<AuthState>().having((s) => s.isCreating, 'isCreating', true),
        isA<AuthState>()
            .having((s) => s.isCreating, 'isCreating', false)
            .having((s) => s.errorMessage, 'errorMessage', '')
            .having(
              (s) => s.authStatus,
              "AuthStatus",
              AuthStatus.authenticated,
            ),
      ],
    );
  });
}
