import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_starter_kit/domain/usecases/usecases.dart';
import 'package:flutter_starter_kit/ui/blocs/blocs.dart';
import 'package:flutter_starter_kit/ui/cubits/cubits.dart';
import 'package:flutter_starter_kit/ui/shared/service/service.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';

/// Mocks for testing

class MockSignInFormCubit extends Mock implements SignInFormCubit {}

class MockRegisterFormCubit extends Mock implements RegisterFormCubit {}

class MockAuthUse extends Mock implements AuthUseCase {}

class MockKeyValueStorageService extends Mock
    implements KeyValueStorageService {}

/// Mock Bloc for testing
class MockAuthBloc extends Mock implements AuthBloc {}

class FakeAuthState extends Fake implements AuthState {}

class FakeAuthEvent extends Fake implements AuthEvent {}

// Helper function to create the test app.
Widget createTestApp({
  required GoRouter appRouter,
  required List<BlocProvider> providers,
}) {
  return MultiBlocProvider(
    // Provide mock blocs to the app.
    providers: providers,
    child: MaterialApp.router(
      // Use the mock router.
      routerConfig: appRouter,
    ),
  );
}

Future<void> enterRegisterFormData({
  required WidgetTester tester,
  required String fullName,
  required String email,
  required String password,
  required String confirmPassword,
}) async {
  await tester.enterText(
    find.byKey(const Key("fullName_field")),
    fullName,
  );
  await tester.enterText(
    find.byKey(const Key("email_field")),
    email,
  );
  await tester.enterText(
    find.byKey(const Key("password_field")),
    password,
  );
  await tester.enterText(
    find.byKey(const Key("confirm_password_field")),
    confirmPassword,
  );

  await tester.pumpAndSettle();
}
