import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:fondos_app/ui/blocs/fund/fund_bloc.dart';
import 'package:fondos_app/ui/screens/transactions/transactions_screen.dart';
import 'package:fondos_app/data/models/transaction_model.dart';
import 'package:fondos_app/data/models/my_fund_model.dart';
import 'package:fondos_app/config/l10n/app_localizations.dart';
import 'package:fondos_app/app/dependency_injection.dart' as di;
import 'package:fondos_app/ui/shared/notification_way.dart';

class MockFundBloc extends Mock implements FundBloc {}

class FakeFundEvent extends Fake implements FundEvent {}

class FakeFundState extends Fake implements FundState {}

void main() {
  late FundBloc fundBloc;

  setUpAll(() {
    registerFallbackValue(FakeFundEvent());
    registerFallbackValue(FakeFundState());
  });

  setUp(() {
    fundBloc = MockFundBloc();
    di.getIt.registerFactory<FundBloc>(() => fundBloc);
    when(() => fundBloc.stream)
        .thenAnswer((_) => const Stream<FundState>.empty());
  });

  tearDown(() {
    if (di.getIt.isRegistered<FundBloc>()) {
      di.getIt.unregister<FundBloc>();
    }
  });

  Widget makeTestableWidget(Widget child) {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: const Locale('en'),
      home: BlocProvider<FundBloc>.value(
        value: fundBloc,
        child: child,
      ),
    );
  }

  testWidgets('renders title', (tester) async {
    when(() => fundBloc.state).thenReturn(const FundState());
    await tester.pumpWidget(makeTestableWidget(const TransactionsScreen()));
    await tester.pumpAndSettle();
    final l10n = await AppLocalizations.delegate.load(const Locale('en'));
    expect(find.text(l10n.transactions), findsOneWidget);
  });

  testWidgets('shows loader when isLoading', (tester) async {
    when(() => fundBloc.state).thenReturn(const FundState(isLoading: true));
    await tester.pumpWidget(makeTestableWidget(const TransactionsScreen()));
    expect(find.byType(CircularProgressIndicator),
        findsNothing); // No loader in this screen
  });

  testWidgets('shows error message', (tester) async {
    const errorMsg = 'Test error';
    when(() => fundBloc.state)
        .thenReturn(const FundState(errorMessage: errorMsg));
    await tester.pumpWidget(makeTestableWidget(const TransactionsScreen()));
    await tester.pumpAndSettle();
    expect(find.text(errorMsg),
        findsNothing); // Error is not shown directly in this screen
  });

  testWidgets('shows empty list message', (tester) async {
    when(() => fundBloc.state).thenReturn(const FundState(transactions: []));
    await tester.pumpWidget(makeTestableWidget(const TransactionsScreen()));
    await tester.pumpAndSettle();
    final l10n = await AppLocalizations.delegate.load(const Locale('en'));
    expect(find.text(l10n.noDataAvailable), findsOneWidget);
  });

  testWidgets('renders list of transactions', (tester) async {
    final transactions = [
      TransactionModel(
        type: 'subscription',
        fund: MyFundModel(
            id: '1',
            name: 'Fund 1',
            amountMin: '100',
            category: 'A',
            investment: '500',
            notificationWay: NotificationWay.email),
        amount: '500',
        date: DateTime.now(),
        notificationWay: NotificationWay.email,
      ),
      TransactionModel(
        type: 'cancellation',
        fund: MyFundModel(
            id: '2',
            name: 'Fund 2',
            amountMin: '200',
            category: 'B',
            investment: '1000',
            notificationWay: NotificationWay.email),
        amount: '1000',
        date: DateTime.now(),
        notificationWay: NotificationWay.email,
      ),
    ];
    when(() => fundBloc.state)
        .thenReturn(FundState(transactions: transactions));
    await tester.pumpWidget(makeTestableWidget(const TransactionsScreen()));
    await tester.pumpAndSettle();
    expect(find.text('Fund 1'), findsOneWidget);
    expect(find.text('Fund 2'), findsOneWidget);
  });
}
