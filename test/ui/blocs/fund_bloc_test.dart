/// {@template fund_bloc_test}
/// Unit tests for the [FundBloc], which manages the state and logic for investment funds,
/// including loading funds, subscribing, and cancelling subscriptions.
///
/// These tests cover:
/// - Loading funds and handling errors
/// - Subscribing to funds, including validation and state updates
/// - Cancelling fund subscriptions and related state transitions
/// - Integration with [UserCubit] and [FundUseCase]
/// {@endtemplate}
import 'package:flutter_test/flutter_test.dart';
import 'package:fondos_app/data/models/fund_model.dart';
import 'package:fondos_app/data/models/my_fund_model.dart';
import 'package:fondos_app/ui/blocs/blocs.dart';
import 'package:fondos_app/ui/cubits/cubits.dart';
import 'package:fondos_app/ui/shared/notification_way.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';

import '../mocks/mock_fund_bloc_dependencies.dart';

void main() {
  late FundBloc fundBloc;
  late MockFundUseCase mockFundUsecase;
  late MockUserCubit mockUserCubit;

  // Register fallback values for mocktail
  setUpAll(() {
    registerFallbackValue(FundModel(
      id: '',
      name: '',
      amountMin: '',
      category: '',
    ));
    registerFallbackValue(MyFundModel(
      id: '',
      name: '',
      amountMin: '',
      category: '',
      investment: '',
      notificationWay: NotificationWay.email,
    ));
    registerFallbackValue(NotificationWay.email);
    registerFallbackValue(UserState(
      name: 'Test user',
      balance: 1000.0,
    )); // Register UserState
  });

  setUp(() {
    mockFundUsecase = MockFundUseCase();
    mockUserCubit = MockUserCubit();
    // Stub the initial state of UserCubit
    when(() => mockUserCubit.state)
        .thenReturn(const UserState(balance: 1000.0, name: "Test user"));
    when(() => mockUserCubit.changeBalance(any()))
        .thenReturn(null); // Mock changeBalance method
    fundBloc = FundBloc(mockFundUsecase, mockUserCubit);
  });

  tearDown(() {
    fundBloc.close();
  });

  group('LoadFundEvent', () {
    /// {@template fund_bloc_test_load_fund_event}
    /// Tests for the [LoadFundEvent], ensuring correct loading, error handling,
    /// and state transitions when fetching funds.
    /// {@endtemplate}
    final List<FundModel> tFunds = [
      FundModel(
          id: '1', name: 'Fund A', amountMin: '100', category: 'Category A'),
      FundModel(
          id: '2', name: 'Fund B', amountMin: '200', category: 'Category B'),
    ];

    blocTest<FundBloc, FundState>(
      'should emit loading state on start',
      build: () => fundBloc,
      act: (bloc) {
        // Mock the use case to return data after a delay to observe the loading state
        when(() => mockFundUsecase.loadFunds()).thenAnswer((_) async {
          // Simulate a short delay to ensure loading state is emitted
          await Future.delayed(const Duration(milliseconds: 10));
          return tFunds;
        });
        bloc.add(LoadFundEvent());
      },
      wait: const Duration(milliseconds: 20),
      expect: () => [
        const FundState(isLoading: true, status: SubscribeFundStatus.none),
        FundState(isLoading: false, funds: tFunds),
      ],
    );

    blocTest<FundBloc, FundState>(
      'should load funds successfully',
      build: () => fundBloc,
      act: (bloc) {
        when(() => mockFundUsecase.loadFunds()).thenAnswer((_) async => tFunds);
        bloc.add(LoadFundEvent());
      },
      expect: () => [
        const FundState(isLoading: true, status: SubscribeFundStatus.none),
        FundState(isLoading: false, funds: tFunds),
      ],
    );

    blocTest<FundBloc, FundState>(
      'should handle loading errors',
      build: () => fundBloc,
      act: (bloc) {
        when(() => mockFundUsecase.loadFunds())
            .thenThrow(Exception('Failed to load'));
        bloc.add(LoadFundEvent());
      },
      expect: () => [
        const FundState(isLoading: true, status: SubscribeFundStatus.none),
        const FundState(
            isLoading: false, errorMessage: 'Exception: Failed to load'),
      ],
    );

    blocTest<FundBloc, FundState>(
      'should emit final state with loaded funds',
      build: () => fundBloc,
      act: (bloc) {
        when(() => mockFundUsecase.loadFunds()).thenAnswer((_) async => tFunds);
        bloc.add(LoadFundEvent());
      },
      expect: () => [
        const FundState(isLoading: true, status: SubscribeFundStatus.none),
        FundState(isLoading: false, funds: tFunds),
      ],
    );
  });
  group('SubscribeFundEvent', () {
    /// {@template fund_bloc_test_subscribe_fund_event}
    /// Tests for the [SubscribeFundEvent], covering successful subscriptions,
    /// validation errors, user balance updates, and error handling.
    /// {@endtemplate}
    final FundModel testFund = FundModel(
      id: 'fund1',
      name: 'Test Fund',
      amountMin: '50',
      category: 'Test Category',
    );
    const String investmentAmount = '100';
    const NotificationWay notificationMethod = NotificationWay.email;

    blocTest<FundBloc, FundState>(
      'should subscribe successfully when user has sufficient balance',
      build: () => fundBloc,
      seed: () {
        when(() => mockUserCubit.state)
            .thenReturn(const UserState(balance: 500.0, name: 'Test user'));
        return const FundState(
            myFunds: [], transactions: [], status: SubscribeFundStatus.none);
      },
      act: (bloc) => bloc.add(SubscribeFundEvent(
        fund: testFund,
        investment: investmentAmount,
        notificationWay: notificationMethod,
      )),
      expect: () => [
        isA<FundState>()
            .having((s) => s.myFunds.length, 'myFunds length', 1)
            .having((s) => s.myFunds.first.investment,
                'myFunds first investment', investmentAmount)
            .having((s) => s.myFunds.first.id, 'myFunds first ID',
                '1') // ID basado en initial empty list
            .having((s) => s.transactions.length, 'transactions length', 1)
            .having((s) => s.transactions.first.type, 'transactions first type',
                'subscription')
            .having((s) => s.transactions.first.amount,
                'transactions first amount', investmentAmount)
            .having((s) => s.status, 'status', SubscribeFundStatus.success),
      ],
      verify: (_) {
        verify(() => mockUserCubit.changeBalance(400.0))
            .called(1); // 500 - 100 = 400
      },
    );

    blocTest<FundBloc, FundState>(
      'should fail when user has insufficient balance (validationUserBalance)',
      build: () => fundBloc,
      seed: () {
        when(() => mockUserCubit.state).thenReturn(const UserState(
            balance: 50.0, name: 'Test User')); // Insufficient balance
        return const FundState();
      },
      act: (bloc) => bloc.add(SubscribeFundEvent(
        fund: testFund,
        investment: investmentAmount, // 100
        notificationWay: notificationMethod,
      )),
      expect: () => [
        const FundState(
            status: SubscribeFundStatus.error,
            errorSubscribe: "validationUserBalance"),
      ],
      verify: (_) {
        verifyNever(() =>
            mockUserCubit.changeBalance(any())); // Balance should not change
      },
    );

    blocTest<FundBloc, FundState>(
      'should update user balance',
      build: () => fundBloc,
      seed: () {
        when(() => mockUserCubit.state)
            .thenReturn(const UserState(balance: 750.0, name: 'Test User'));
        return const FundState();
      },
      act: (bloc) => bloc.add(SubscribeFundEvent(
        fund: testFund,
        investment: '250',
        notificationWay: notificationMethod,
      )),
      expect: () => [
        isA<FundState>()
            .having((s) => s.status, 'status', SubscribeFundStatus.success)
            .having((s) => s.myFunds.length, 'myFunds length',
                1) // También verificamos esto si se añade el fondo
            .having((s) => s.transactions.length, 'transactions length', 1),
      ],
      verify: (_) {
        verify(() => mockUserCubit.changeBalance(500.0))
            .called(1); // 750 - 250 = 500
      },
    );

    blocTest<FundBloc, FundState>(
      'should add fund to myFunds',
      build: () => fundBloc,
      seed: () {
        when(() => mockUserCubit.state)
            .thenReturn(const UserState(balance: 1000.0, name: 'Test User'));
        return const FundState(myFunds: []); // Start with empty myFunds
      },
      act: (bloc) => bloc.add(SubscribeFundEvent(
        fund: testFund,
        investment: investmentAmount,
        notificationWay: notificationMethod,
      )),
      expect: () => [
        isA<FundState>()
            .having((s) => s.myFunds.length, 'myFunds length', 1)
            .having((s) => s.myFunds.first.name, 'myFunds first name',
                testFund.name)
            .having((s) => s.myFunds.first.investment,
                'myFunds first investment', investmentAmount)
            // No olvides el ID si lo estás generando dinámicamente y el `MyFundModel` lo compara.
            // Asumiendo que el ID será '1' ya que 'myFunds' comienza vacío.
            .having((s) => s.myFunds.first.id, 'myFunds first ID', '1')
            .having((s) => s.status, 'status', SubscribeFundStatus.success),
      ],
    );

    blocTest<FundBloc, FundState>(
      'should create subscription transaction',
      build: () => fundBloc,
      seed: () {
        when(() => mockUserCubit.state)
            .thenReturn(const UserState(balance: 1000.0, name: 'Test User'));
        return const FundState(
            transactions: []); // Start with empty transactions
      },
      act: (bloc) => bloc.add(SubscribeFundEvent(
        fund: testFund,
        investment: investmentAmount,
        notificationWay: notificationMethod,
      )),
      expect: () => [
        isA<FundState>()
            .having((s) => s.transactions.length, 'transactions length', 1)
            .having((s) => s.transactions.first.type, 'transactions first type',
                'subscription')
            .having((s) => s.transactions.first.amount,
                'transactions first amount', investmentAmount)
            // No es necesario comparar la fecha del TransactionModel directamente debido a DateTime.now()
            .having((s) => s.status, 'status', SubscribeFundStatus.success)
            // Es importante añadir también la verificación de myFunds, ya que el bloc lo añade en el mismo emit.
            .having((s) => s.myFunds.length, 'myFunds length', 1),
      ],
    );

    blocTest<FundBloc, FundState>(
      'should emit success status',
      build: () => fundBloc,
      seed: () {
        when(() => mockUserCubit.state)
            .thenReturn(const UserState(balance: 1000.0, name: 'Test User'));
        return const FundState();
      },
      act: (bloc) => bloc.add(SubscribeFundEvent(
        fund: testFund,
        investment: investmentAmount,
        notificationWay: notificationMethod,
      )),
      expect: () => [
        isA<FundState>()
            .having((s) => s.status, 'status', SubscribeFundStatus.success)
            // Es crucial añadir las aserciones para myFunds y transactions también,
            // ya que el estado de éxito implica que estos se han actualizado.
            .having((s) => s.myFunds.length, 'myFunds length', 1)
            .having((s) => s.transactions.length, 'transactions length', 1),
      ],
    );

    blocTest<FundBloc, FundState>(
      'should handle subscription errors',
      build: () => fundBloc,
      seed: () {
        // Simulate an error occurring within the try block, for example, if parsing fails unexpectedly
        // or if any other internal logic throws. For this specific logic, it's hard to make it throw
        // unless `_userCubit.changeBalance` were to throw, but we can simulate a generic error.
        // Note: In this specific implementation, a direct `throw` inside `on<SubscribeFundEvent>`
        // before `emit` or `_userCubit` calls would be tricky to test without modifying the bloc.
        // However, we test the error emission.
        when(() => mockUserCubit.state)
            .thenReturn(const UserState(balance: 1000.0, name: 'Test User'));
        // If we had an _useCase.subscribeFund() that could throw:
        // when(() => mockFundUsecase.subscribeFund(any(), any(), any())).thenThrow(Exception('Subscription failed'));
        return const FundState();
      },
      act: (bloc) {
        // To force an error in this simplified bloc without external use cases, we simulate a bad parse
        // that could lead to an internal exception if not handled by tryParse.
        // However, the current code handles parsing with `tryParse ?? 0`, so it won't throw there.
        // For testing the `catch (e)` block, we need to introduce a throw.
        // Let's assume an underlying dependency `_userCubit.changeBalance` could throw.
        when(() => mockUserCubit.changeBalance(any()))
            .thenThrow(Exception('Balance update failed'));
        bloc.add(SubscribeFundEvent(
          fund: testFund,
          investment: investmentAmount,
          notificationWay: notificationMethod,
        ));
      },
      expect: () => [
        const FundState(
            status: SubscribeFundStatus.error,
            errorSubscribe: 'errorSubscribing'),
      ],
    );
  });
  group('CancelSubscribeFundEvent', () {
    /// {@template fund_bloc_test_cancel_subscribe_fund_event}
    /// Tests for the [CancelSubscribeFundEvent], ensuring correct cancellation logic,
    /// user balance updates, transaction creation, and error handling.
    /// {@endtemplate}
    final MyFundModel subscribedFund = MyFundModel(
      id: '1',
      name: 'My Subscribed Fund',
      amountMin: '100',
      category: 'Category X',
      investment: '500',
      notificationWay: NotificationWay.email,
    );

    blocTest<FundBloc, FundState>(
      'should cancel subscription successfully',
      build: () => fundBloc,
      seed: () {
        when(() => mockUserCubit.state)
            .thenReturn(const UserState(balance: 500.0, name: 'Test User'));
        return FundState(myFunds: [subscribedFund], transactions: []);
      },
      act: (bloc) => bloc.add(CancelSubscribeFundEvent(fund: subscribedFund)),
      expect: () => [
        isA<FundState>()
            .having((s) => s.myFunds, 'myFunds',
                isEmpty) // Should be empty after removal
            .having((s) => s.transactions.length, 'transactions length', 1)
            .having((s) => s.transactions.first.type, 'transactions first type',
                'cancellation')
            .having((s) => s.status, 'status', SubscribeFundStatus.cancel),
      ],
      verify: (_) {
        verify(() => mockUserCubit.changeBalance(1000.0))
            .called(1); // 500 (initial) + 500 (investment) = 1000
      },
    );

    blocTest<FundBloc, FundState>(
      'should fail if the fund does not exist in myFunds',
      build: () => fundBloc,
      seed: () {
        when(() => mockUserCubit.state)
            .thenReturn(const UserState(balance: 1000.0, name: 'Test User'));
        return const FundState(myFunds: []); // Fund is not in myFunds
      },
      act: (bloc) => bloc.add(CancelSubscribeFundEvent(fund: subscribedFund)),
      expect: () => [
        const FundState(
            status: SubscribeFundStatus.error,
            errorSubscribe: 'errorCancellingSubscribing'),
      ],
      verify: (_) {
        verifyNever(() =>
            mockUserCubit.changeBalance(any())); // Balance should not change
      },
    );

    blocTest<FundBloc, FundState>(
      'should update user balance (return money)',
      build: () => fundBloc,
      seed: () {
        when(() => mockUserCubit.state)
            .thenReturn(const UserState(balance: 200.0, name: 'Test User'));
        return FundState(myFunds: [subscribedFund]); // Fund with 500 investment
      },
      act: (bloc) => bloc.add(CancelSubscribeFundEvent(fund: subscribedFund)),
      expect: () => [
        isA<FundState>()
            .having((s) => s.status, 'status', SubscribeFundStatus.cancel)
            .having((s) => s.myFunds, 'myFunds',
                isEmpty) // También verifica que el fondo se elimine
            .having((s) => s.transactions.length, 'transactions length', 1),
      ],
      verify: (_) {
        verify(() => mockUserCubit.changeBalance(700.0))
            .called(1); // 200 (initial) + 500 (investment) = 700
      },
    );

    blocTest<FundBloc, FundState>(
      'should remove fund from myFunds',
      build: () => fundBloc,
      seed: () {
        when(() => mockUserCubit.state)
            .thenReturn(const UserState(balance: 1000.0, name: 'Test User'));
        return FundState(myFunds: [subscribedFund]);
      },
      act: (bloc) => bloc.add(CancelSubscribeFundEvent(fund: subscribedFund)),
      expect: () => [
        isA<FundState>()
            .having((s) => s.myFunds, 'myFunds', isEmpty)
            .having((s) => s.status, 'status', SubscribeFundStatus.cancel)
            .having((s) => s.transactions.length, 'transactions length', 1),
      ],
    );

    blocTest<FundBloc, FundState>(
      'should create cancellation transaction',
      build: () => fundBloc,
      seed: () {
        when(() => mockUserCubit.state)
            .thenReturn(const UserState(balance: 1000.0, name: 'Test User'));
        return FundState(myFunds: [subscribedFund], transactions: []);
      },
      act: (bloc) => bloc.add(CancelSubscribeFundEvent(fund: subscribedFund)),
      expect: () => [
        isA<FundState>()
            .having((s) => s.transactions.length, 'transactions length', 1)
            .having((s) => s.transactions.first.type, 'transactions first type',
                'cancellation')
            .having((s) => s.transactions.first.amount,
                'transactions first amount', subscribedFund.investment)
            .having((s) => s.status, 'status', SubscribeFundStatus.cancel)
            .having((s) => s.myFunds, 'myFunds', isEmpty),
      ],
    );

    blocTest<FundBloc, FundState>(
      'should emit cancel status',
      build: () => fundBloc,
      seed: () {
        when(() => mockUserCubit.state)
            .thenReturn(const UserState(balance: 1000.0, name: 'Test User'));
        return FundState(myFunds: [subscribedFund]);
      },
      act: (bloc) => bloc.add(CancelSubscribeFundEvent(fund: subscribedFund)),
      expect: () => [
        isA<FundState>()
            .having((s) => s.status, 'status', SubscribeFundStatus.cancel)
            .having((s) => s.myFunds, 'myFunds',
                isEmpty) // Verifica también la eliminación del fondo
            .having((s) => s.transactions.length, 'transactions length', 1),
      ],
    );

    blocTest<FundBloc, FundState>(
      'should handle cancellation errors',
      build: () => fundBloc,
      seed: () {
        // Simulate an error occurring within the try block, e.g., if changeBalance throws
        when(() => mockUserCubit.state)
            .thenReturn(const UserState(balance: 1000.0, name: 'Test User'));
        when(() => mockUserCubit.changeBalance(any()))
            .thenThrow(Exception('Balance update failed during cancel'));
        return FundState(
            myFunds: [subscribedFund],
            transactions: [],
            status: SubscribeFundStatus.none);
      },
      act: (bloc) => bloc.add(CancelSubscribeFundEvent(fund: subscribedFund)),
      expect: () => [
        FundState(
          myFunds: [
            subscribedFund
          ], // <--- ¡Esto es lo que faltaba en tu expectativa!
          transactions: [], // Las transacciones también deberían estar vacías
          status: SubscribeFundStatus.error,
          errorSubscribe: 'errorSubscribing',
        ),
      ],
    );
  });
}
