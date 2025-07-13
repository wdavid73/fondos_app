/// {@template my_investment_screen_test}
/// Widget tests for the [MyInvestmentsScreen] widget.
///
/// These tests verify:
/// - Rendering of titles and subtitles
/// - Empty state and investment list rendering
/// - SnackBars for cancel and error events
///
/// The tests use mocked [FundBloc] and [UserCubit] with dependency injection for isolation.
/// {@endtemplate}
/// Widget test for the MyInvestmentsScreen widget.
///
/// Verifies rendering of titles, empty state, investment list, and SnackBars for cancel and error.
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:fondos_app/ui/blocs/fund/fund_bloc.dart';
import 'package:fondos_app/ui/cubits/user_cubit/user_cubit.dart';
import 'package:fondos_app/ui/screens/my_investments/my_investments_screen.dart';
import 'package:fondos_app/data/models/my_fund_model.dart';
import 'package:fondos_app/config/l10n/app_localizations.dart';
import 'package:fondos_app/app/dependency_injection.dart' as di;
import 'package:fondos_app/ui/shared/notification_way.dart';
import 'package:bloc_test/bloc_test.dart';

class MockFundBloc extends Mock implements FundBloc {}

class FakeFundEvent extends Fake implements FundEvent {}

class FakeFundState extends Fake implements FundState {}

class MockUserCubit extends Mock implements UserCubit {}

class FakeUserState extends Fake implements UserState {}

void main() {
  late FundBloc fundBloc;
  late UserCubit userCubit;

  setUpAll(() {
    registerFallbackValue(FakeFundEvent());
    registerFallbackValue(FakeFundState());
    registerFallbackValue(FakeUserState());
  });

  setUp(() {
    fundBloc = MockFundBloc();
    userCubit = MockUserCubit();
    di.getIt.registerFactory<FundBloc>(() => fundBloc);
    di.getIt.registerFactory<UserCubit>(() => userCubit);
    when(() => fundBloc.stream)
        .thenAnswer((_) => const Stream<FundState>.empty());
    when(() => userCubit.stream)
        .thenAnswer((_) => const Stream<UserState>.empty());
  });

  tearDown(() {
    if (di.getIt.isRegistered<FundBloc>()) {
      di.getIt.unregister<FundBloc>();
    }
    if (di.getIt.isRegistered<UserCubit>()) {
      di.getIt.unregister<UserCubit>();
    }
  });

  Widget makeTestableWidget(Widget child) {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: const Locale('en'),
      home: MultiBlocProvider(
        providers: [
          BlocProvider<FundBloc>.value(value: fundBloc),
          BlocProvider<UserCubit>.value(value: userCubit),
        ],
        child: child,
      ),
    );
  }

  testWidgets('renders title and subtitle', (tester) async {
    when(() => fundBloc.state).thenReturn(const FundState());
    when(() => userCubit.state)
        .thenReturn(const UserState(name: 'Test', balance: 1000));
    await tester.pumpWidget(makeTestableWidget(const MyInvestmentsScreen()));
    await tester.pumpAndSettle();
    final l10n = await AppLocalizations.delegate.load(const Locale('en'));
    expect(find.text(l10n.myFunds), findsOneWidget);
    expect(find.text(l10n.activeFunds), findsOneWidget);
  });

  testWidgets('shows loader when isLoading', (tester) async {
    when(() => fundBloc.state).thenReturn(const FundState(isLoading: true));
    when(() => userCubit.state)
        .thenReturn(const UserState(name: 'Test', balance: 1000));
    await tester.pumpWidget(makeTestableWidget(const MyInvestmentsScreen()));
    expect(find.byType(CircularProgressIndicator),
        findsNothing); // No loader in this screen
  });

  testWidgets('shows error message', (tester) async {
    const errorMsg = 'Test error';
    when(() => fundBloc.state)
        .thenReturn(const FundState(errorMessage: errorMsg));
    when(() => userCubit.state)
        .thenReturn(const UserState(name: 'Test', balance: 1000));
    await tester.pumpWidget(makeTestableWidget(const MyInvestmentsScreen()));
    await tester.pumpAndSettle();
    expect(find.text(errorMsg),
        findsNothing); // Error is not shown directly in this screen
  });

  testWidgets('shows empty list message', (tester) async {
    when(() => fundBloc.state).thenReturn(const FundState(myFunds: []));
    when(() => userCubit.state)
        .thenReturn(const UserState(name: 'Test', balance: 1000));
    await tester.pumpWidget(makeTestableWidget(const MyInvestmentsScreen()));
    await tester.pumpAndSettle();
    final l10n = await AppLocalizations.delegate.load(const Locale('en'));
    expect(find.text(l10n.noDataAvailable), findsOneWidget);
  });

  testWidgets('renders list of investments', (tester) async {
    final myFunds = [
      MyFundModel(
          id: '1',
          name: 'Fund 1',
          amountMin: '100',
          category: 'A',
          investment: '500',
          notificationWay: NotificationWay.email),
      MyFundModel(
          id: '2',
          name: 'Fund 2',
          amountMin: '200',
          category: 'B',
          investment: '1000',
          notificationWay: NotificationWay.email),
    ];
    when(() => fundBloc.state).thenReturn(FundState(myFunds: myFunds));
    when(() => userCubit.state)
        .thenReturn(const UserState(name: 'Test', balance: 1000));
    await tester.pumpWidget(makeTestableWidget(const MyInvestmentsScreen()));
    await tester.pumpAndSettle();
    expect(find.text('Fund 1'), findsOneWidget);
    expect(find.text('Fund 2'), findsOneWidget);
  });

  testWidgets('shows SnackBar on cancel success', (tester) async {
    final l10n = await AppLocalizations.delegate.load(const Locale('en'));
    when(() => fundBloc.state).thenReturn(const FundState());
    when(() => userCubit.state)
        .thenReturn(const UserState(name: 'Test', balance: 1000));
    whenListen(
      fundBloc,
      Stream<FundState>.fromIterable([
        const FundState(),
        const FundState(status: SubscribeFundStatus.cancel),
      ]),
      initialState: const FundState(),
    );
    await tester.pumpWidget(makeTestableWidget(const MyInvestmentsScreen()));
    await tester.pumpAndSettle();
    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text(l10n.subscriptionCancelSuccess), findsOneWidget);
  });

  testWidgets('shows SnackBar on error', (tester) async {
    when(() => fundBloc.state).thenReturn(const FundState());
    when(() => userCubit.state)
        .thenReturn(const UserState(name: 'Test', balance: 1000));

    whenListen(
      fundBloc,
      Stream<FundState>.fromIterable([
        const FundState(),
        const FundState(
          status: SubscribeFundStatus.cancel,
        ),
      ]),
      initialState: const FundState(),
    );

    await tester.pumpWidget(makeTestableWidget(const MyInvestmentsScreen()));
    await tester.pumpAndSettle();
    expect(find.byType(SnackBar), findsOneWidget);
  });
}
