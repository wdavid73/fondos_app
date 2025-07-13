/// {@template subscribe_fund_form_cubit_test}
/// Unit tests for the [SubscribeFundFormCubit], which manages the state and logic
/// for subscribing to a fund, including validation of input fields and interaction
/// with the [FundBloc].
///
/// These tests cover:
/// - Form submission and validation logic
/// - Notification method changes
/// - Amount input changes and validation
/// - Integration with [FundBloc] and expected state transitions
/// {@endtemplate}
import 'package:flutter_test/flutter_test.dart';
import 'package:fondos_app/data/models/fund_model.dart';
import 'package:fondos_app/ui/blocs/fund/fund_bloc.dart';
import 'package:fondos_app/ui/cubits/cubits.dart';
import 'package:fondos_app/ui/shared/inputs/amount_input.dart';
import 'package:fondos_app/ui/shared/inputs/generic_option_input.dart';
import 'package:fondos_app/ui/shared/notification_way.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';

import '../mocks/mock_subscribe_fund_form_dependencies.dart';

void main() {
  late MockFundBloc mockFundBloc;
  late SubscribeFundFormCubit cubit;
  late FundModel testFund;

  setUpAll(() {
    registerFallbackValue(FakeSubscribeFundFormState());
    registerFallbackValue(FundModel(
      amountMin: '0',
      id: 'test_fund_id',
      name: "Mock",
      category: 'Category Mock',
    ));
    registerFallbackValue(NotificationWay.email); // Register fallback for enum
  });

  setUp(() {
    mockFundBloc = MockFundBloc();
    when(() => mockFundBloc.stream).thenAnswer((_) => const Stream.empty());
    cubit = SubscribeFundFormCubit(mockFundBloc);
    testFund = FundModel(
      amountMin: '100',
      id: 'fund_id_123',
      name: "Mock",
      category: 'Category Mock',
    );
  });

  tearDown(() {
    cubit.close();
  });

  /// {@template subscribe_fund_form_cubit_test_on_submit}
  /// Tests for the [SubscribeFundFormCubit.onSubmit] method, ensuring correct
  /// validation, state updates, and interaction with [FundBloc] when submitting the form.
  /// {@endtemplate}
  group("onSubmit()", () {
    blocTest<SubscribeFundFormCubit, SubscribeFundFormState>(
      'should validate fields before submitting when initial state is invalid',
      build: () => cubit,
      seed: () => const SubscribeFundFormState(
        amount: AmountInput.pure(), // Invalid initial amount
        notification: GenericOptionInput.pure(), // Invalid initial notification
        isValid: false,
      ),
      act: (cubit) => cubit.onSubmit(testFund),
      expect: () => [
        // _touchEveryField will be called, updating amount and notification to dirty
        // and recalculating isValid. Since they are empty, they will remain invalid.
        isA<SubscribeFundFormState>()
            .having((s) => s.amount.isNotValid, 'amount is not valid', true)
            .having((s) => s.notification.isNotValid,
                'notification is not valid', true)
            .having((s) => s.isValid, 'isValid', false),
      ],
      verify: (_) {
        // Verify that subscribeToFund is NOT called because the form is invalid
        verifyNever(() => mockFundBloc.subscribeToFund(any(), any(), any()));
      },
    );

    blocTest<SubscribeFundFormCubit, SubscribeFundFormState>(
      'should call subscribeToFund of FundBloc when form is valid',
      build: () => cubit,
      seed: () => SubscribeFundFormState(
        amount: const AmountInput.dirty('200', minimumAllowed: 100),
        notification:
            GenericOptionInput<NotificationWay>.dirty(NotificationWay.email),
        isValid: true,
      ),
      act: (cubit) {
        // Mock the behavior of fundBloc.stream
        when(() => mockFundBloc.stream).thenAnswer((_) => Stream.fromIterable([
              const FundState(status: SubscribeFundStatus.success),
            ]));
        // Mock subscribeToFund call
        when(() => mockFundBloc.subscribeToFund(any(), any(), any()))
            .thenAnswer((_) async {});

        cubit.onSubmit(testFund);
      },
      expect: () => [
        // After onSubmit, isPosting becomes true
        isA<SubscribeFundFormState>()
            .having((s) => s.isPosting, 'isPosting', true),
        // After awaiting FundBloc response, isPosting becomes false
        isA<SubscribeFundFormState>()
            .having((s) => s.isPosting, 'isPosting', false),
      ],
      verify: (_) {
        // Verify that subscribeToFund IS called with correct arguments
        verify(() => mockFundBloc.subscribeToFund(
              testFund,
              '200', // Cleaned amount from state.amount.value
              NotificationWay.email,
            )).called(1);
      },
    );

    blocTest<SubscribeFundFormCubit, SubscribeFundFormState>(
      'should handle posting state correctly',
      build: () => cubit,
      seed: () => SubscribeFundFormState(
        amount: const AmountInput.dirty('200', minimumAllowed: 100),
        notification:
            GenericOptionInput<NotificationWay>.dirty(NotificationWay.email),
        isValid: true,
      ),
      act: (cubit) {
        // Mock the behavior of fundBloc.stream
        when(() => mockFundBloc.stream).thenAnswer((_) => Stream.fromIterable([
              const FundState(status: SubscribeFundStatus.success),
            ]));
        // Mock subscribeToFund call
        when(() => mockFundBloc.subscribeToFund(any(), any(), any()))
            .thenAnswer((_) async {});

        cubit.onSubmit(testFund);
      },
      expect: () => [
        // State when isPosting becomes true
        isA<SubscribeFundFormState>()
            .having((s) => s.isPosting, 'isPosting', true),
        // State when isPosting becomes false after async operation
        isA<SubscribeFundFormState>()
            .having((s) => s.isPosting, 'isPosting', false),
      ],
      verify: (_) {
        // Ensure subscribeToFund was called
        verify(() => mockFundBloc.subscribeToFund(any(), any(), any()))
            .called(1);
      },
    );

    blocTest<SubscribeFundFormCubit, SubscribeFundFormState>(
      'should await response from FundBloc',
      build: () => cubit,
      seed: () => SubscribeFundFormState(
        amount: const AmountInput.dirty('200', minimumAllowed: 100),
        notification:
            GenericOptionInput<NotificationWay>.dirty(NotificationWay.email),
        isValid: true,
      ),
      act: (cubit) {
        // Simulate FundBloc emitting a success state after a delay or some operation
        when(() => mockFundBloc.stream).thenAnswer((_) => Stream.fromIterable([
              // Initial state is usually handled by BlocProvider
              // We only care about the state after subscribeToFund is called
              const FundState(status: SubscribeFundStatus.none),
              const FundState(status: SubscribeFundStatus.success),
            ]));
        when(() => mockFundBloc.subscribeToFund(any(), any(), any()))
            .thenAnswer((_) async {});

        cubit.onSubmit(testFund);
      },
      expect: () => [
        // isPosting becomes true
        isA<SubscribeFundFormState>()
            .having((s) => s.isPosting, 'isPosting', true),
        // isPosting becomes false after success state from FundBloc
        isA<SubscribeFundFormState>()
            .having((s) => s.isPosting, 'isPosting', false),
      ],
      verify: (_) {
        verify(() => mockFundBloc.subscribeToFund(any(), any(), any()))
            .called(1);
      },
    );

    blocTest<SubscribeFundFormCubit, SubscribeFundFormState>(
      'should await response even on FundBloc error',
      build: () => cubit,
      seed: () => SubscribeFundFormState(
        amount: const AmountInput.dirty('200', minimumAllowed: 100),
        notification:
            GenericOptionInput<NotificationWay>.dirty(NotificationWay.email),
        isValid: true,
      ),
      act: (cubit) {
        // Simulate FundBloc emitting an error state
        when(() => mockFundBloc.stream).thenAnswer((_) => Stream.fromIterable([
              const FundState(status: SubscribeFundStatus.none),
              const FundState(status: SubscribeFundStatus.error),
            ]));
        when(() => mockFundBloc.subscribeToFund(any(), any(), any()))
            .thenAnswer((_) async {});

        cubit.onSubmit(testFund);
      },
      expect: () => [
        // isPosting becomes true
        isA<SubscribeFundFormState>()
            .having((s) => s.isPosting, 'isPosting', true),
        // isPosting becomes false after error state from FundBloc
        isA<SubscribeFundFormState>()
            .having((s) => s.isPosting, 'isPosting', false),
      ],
      verify: (_) {
        verify(() => mockFundBloc.subscribeToFund(any(), any(), any()))
            .called(1);
      },
    );
  });

  /// {@template subscribe_fund_form_cubit_test_method_changed}
  /// Tests for the [SubscribeFundFormCubit.methodChanged] method, verifying that
  /// notification method changes update the state and validation correctly.
  /// {@endtemplate}
  group("methodChanged()", () {
    blocTest<SubscribeFundFormCubit, SubscribeFundFormState>(
      'should update notification method',
      build: () => cubit,
      act: (cubit) => cubit.methodChanged(NotificationWay.sms),
      expect: () => [
        isA<SubscribeFundFormState>()
            .having((s) => s.notification.value, 'notification value',
                NotificationWay.sms)
            .having(
                (s) => s.notification.isValid, 'notification isValid', isTrue),
      ],
    );

    blocTest<SubscribeFundFormCubit, SubscribeFundFormState>(
      'should update validation state',
      build: () => cubit,
      seed: () => SubscribeFundFormState(
        // Amount is valid, so changing notification should make the form valid
        amount: const AmountInput.dirty('500', minimumAllowed: 100),
        notification: const GenericOptionInput.pure(), // Initially invalid
      ),
      act: (cubit) => cubit.methodChanged(NotificationWay.email),
      expect: () => [
        isA<SubscribeFundFormState>()
            .having((s) => s.notification.value, 'notification value',
                NotificationWay.email)
            .having(
                (s) => s.notification.isValid, 'notification isValid', isTrue)
            .having((s) => s.isValid, 'isValid',
                isTrue), // Form should now be valid
      ],
    );

    blocTest<SubscribeFundFormCubit, SubscribeFundFormState>(
      'should keep validation state false if amount is invalid',
      build: () => cubit,
      seed: () => SubscribeFundFormState(
        // Amount is invalid, so changing notification won't make the form valid
        amount: const AmountInput.dirty('50', minimumAllowed: 100),
        notification: const GenericOptionInput.pure(), // Initially invalid
      ),
      act: (cubit) => cubit.methodChanged(NotificationWay.email),
      expect: () => [
        isA<SubscribeFundFormState>()
            .having((s) => s.notification.value, 'notification value',
                NotificationWay.email)
            .having(
                (s) => s.notification.isValid, 'notification isValid', isTrue)
            .having((s) => s.isValid, 'isValid',
                isFalse), // Form should remain invalid
      ],
    );
  });

  /// {@template subscribe_fund_form_cubit_test_amount_changed}
  /// Tests for the [SubscribeFundFormCubit.amountChanged] method, ensuring correct
  /// validation and state updates for various amount input scenarios.
  /// {@endtemplate}
  group("amountChange()", () {
    blocTest<SubscribeFundFormCubit, SubscribeFundFormState>(
      "Must validate minimum amount",
      build: () => cubit,
      act: (cubit) => cubit.amountChanged('50', minimumAllowed: '100'),
      expect: () => [
        isA<SubscribeFundFormState>()
            .having((s) => s.amount.value, 'amount value', '50')
            .having((s) => s.amount.isValid, 'amount isValid', isFalse)
            .having((s) => s.isValid, 'isValid', isFalse)
      ],
    );

    blocTest<SubscribeFundFormCubit, SubscribeFundFormState>(
      'issues status with valid AmountInput when amount is greater than or equal to minimum amount',
      build: () => cubit,
      act: (cubit) => cubit.amountChanged('150', minimumAllowed: '100'),
      expect: () => [
        isA<SubscribeFundFormState>()
            .having((s) => s.amount.value, 'amount value', '150')
            .having((s) => s.amount.isValid, 'amount isValid', isTrue)
            .having((s) => s.isValid, 'isValid',
                isFalse), // Sigue siendo false si notification es pure
      ],
    );

    // --- Prueba: Debe actualizar estado de validación ---
    blocTest<SubscribeFundFormCubit, SubscribeFundFormState>(
      'updates isValid to true when both fields are valid',
      build: () => cubit,
      seed: () => cubit.state.copyWith(
        notification: GenericOptionInput.dirty(NotificationWay.email),
      ),
      act: (cubit) => cubit.amountChanged('200', minimumAllowed: '100'),
      expect: () => [
        isA<SubscribeFundFormState>()
            .having((s) => s.amount.isValid, 'amount isValid', isTrue)
            .having(
                (s) => s.notification.isValid, 'notification isValid', isTrue)
            .having((s) => s.isValid, 'isValid', isTrue),
      ],
    );

    blocTest<SubscribeFundFormCubit, SubscribeFundFormState>(
      'updates isValid to false when the amount is invalid, even if the notification is valid.',
      build: () => cubit,
      seed: () => cubit.state.copyWith(
        notification: GenericOptionInput.dirty(NotificationWay.email),
      ),
      act: (cubit) => cubit.amountChanged('50', minimumAllowed: '100'),
      expect: () => [
        isA<SubscribeFundFormState>()
            .having((s) => s.amount.isValid, 'amount isValid', isFalse)
            .having(
                (s) => s.notification.isValid, 'notification isValid', isTrue)
            .having((s) => s.isValid, 'isValid', isFalse),
      ],
    );

    // --- Prueba: Debe manejar formato de números ---
    blocTest<SubscribeFundFormCubit, SubscribeFundFormState>(
      'correctly handles numbers in thousands format (dots)',
      build: () => cubit,
      act: (cubit) =>
          cubit.amountChanged('1.000.000', minimumAllowed: '900000'),
      expect: () => [
        isA<SubscribeFundFormState>()
            .having((s) => s.amount.value, 'amount value', '1.000.000')
            .having((s) => s.amount.isValid, 'amount isValid', isTrue),
      ],
    );

    blocTest<SubscribeFundFormCubit, SubscribeFundFormState>(
      'correctly handles numbers with decimal format (commas)',
      build: () => cubit,
      act: (cubit) => cubit.amountChanged('1.234,56', minimumAllowed: '1000'),
      expect: () => [
        isA<SubscribeFundFormState>()
            .having((s) => s.amount.value, 'amount value', '1.234,56')
            .having((s) => s.amount.isValid, 'amount isValid', isTrue),
      ],
    );

    blocTest<SubscribeFundFormCubit, SubscribeFundFormState>(
      'handles invalid numbers and sets the status to invalid',
      build: () => cubit,
      act: (cubit) => cubit.amountChanged('abc', minimumAllowed: '100'),
      expect: () => [
        isA<SubscribeFundFormState>()
            .having((s) => s.amount.value, 'amount value', 'abc')
            .having((s) => s.amount.isValid, 'amount isValid', isFalse),
      ],
    );
  });
}
