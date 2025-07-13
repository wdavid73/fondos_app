/// {@template user_cubit_test}
/// Unit tests for the [UserCubit], which manages user state such as balance and name.
///
/// These tests cover:
/// - Changing the user's balance
/// - Ensuring other user state properties remain unchanged
/// - Handling negative and decimal values for balance
/// {@endtemplate}
import 'package:flutter_test/flutter_test.dart';
import 'package:fondos_app/ui/cubits/cubits.dart';
import 'package:mocktail/mocktail.dart';

import '../mocks/mock_user_cubit_dependencies.dart';

void main() {
  late UserCubit userCubit;

  setUpAll(() {
    registerFallbackValue(FakeUserState());
  });

  setUp(() {
    userCubit = UserCubit();
  });

  tearDown(() {
    userCubit.close();
  });

  group("Test UserCubit", () {
    /// {@template user_cubit_test_group}
    /// Tests for the [UserCubit] class, focusing on balance changes and state integrity.
    /// {@endtemplate}
    test("Must change balance sheet correctly", () {
      double newBalance = 300000;
      userCubit.changeBalance(newBalance);
      final state = userCubit.state;
      expect(state.balance, equals(newBalance));
    });

    test("Must maintain other statement values", () {
      double newBalance = 300000;
      userCubit.changeBalance(newBalance);
      final state = userCubit.state;

      expect(state.name, equals("Joe doe"));
    });

    test("Must handle negative values", () {
      double newBalance = -100000;
      userCubit.changeBalance(newBalance);
      final state = userCubit.state;
      expect(state.balance, equals(newBalance));
    });
    test("Must handle decimal values", () {
      double newBalance = 100000.50;
      userCubit.changeBalance(newBalance);
      final state = userCubit.state;
      expect(state.balance, equals(newBalance));
    });
  });
}
