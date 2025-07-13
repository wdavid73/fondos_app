/// {@template home_screen_test}
/// Widget tests for the [HomeScreen] widget.
///
/// These tests verify:
/// - Rendering of titles and descriptions
/// - Loader, error, and empty states
/// - Fund list rendering
/// - SnackBars for success and error events
///
/// The tests use a mocked [FundBloc] and dependency injection for isolation.
/// {@endtemplate}
/// Widget test for the HomeScreen widget.
///
/// Verifies rendering of titles, loading, error, empty state, fund list, and SnackBars for success and error.
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:fondos_app/ui/blocs/fund/fund_bloc.dart';
import 'package:fondos_app/ui/screens/home/home_screen.dart';
import 'package:fondos_app/data/models/fund_model.dart';
import 'package:fondos_app/config/l10n/app_localizations.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:fondos_app/app/dependency_injection.dart' as di;

// Mock FundBloc
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
      locale: const Locale('es'),
      home: BlocProvider<FundBloc>.value(
        value: fundBloc,
        child: child,
      ),
    );
  }

  testWidgets('Renderiza título y descripción', (tester) async {
    when(() => fundBloc.state).thenReturn(const FundState());
    whenListen(fundBloc, Stream<FundState>.empty(),
        initialState: const FundState());
    await tester.pumpWidget(makeTestableWidget(const HomeScreen()));
    await tester.pumpAndSettle(); // Asegura que todo se renderice

    final l10n = await AppLocalizations.delegate.load(const Locale('es'));
    expect(find.text(l10n.exploreFunds), findsOneWidget);
    expect(find.text(l10n.descriptionExploreFunds), findsOneWidget);
  });

  testWidgets('Muestra loader cuando isLoading', (tester) async {
    when(() => fundBloc.state).thenReturn(const FundState(isLoading: true));
    whenListen(fundBloc, Stream<FundState>.empty(),
        initialState: const FundState(isLoading: true));
    await tester.pumpWidget(makeTestableWidget(const HomeScreen()));
    // Solo pump, no pumpAndSettle
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('Muestra mensaje de error', (tester) async {
    const errorMsg = 'Error de prueba';
    when(() => fundBloc.state)
        .thenReturn(const FundState(errorMessage: errorMsg));
    whenListen(fundBloc, Stream<FundState>.empty(),
        initialState: const FundState(errorMessage: errorMsg));
    await tester.pumpWidget(makeTestableWidget(const HomeScreen()));
    await tester.pumpAndSettle();
    expect(find.text(errorMsg), findsOneWidget);
  });

  testWidgets('Muestra mensaje de vacío', (tester) async {
    when(() => fundBloc.state).thenReturn(const FundState(funds: []));
    whenListen(fundBloc, Stream<FundState>.empty(),
        initialState: const FundState(funds: []));
    await tester.pumpWidget(makeTestableWidget(const HomeScreen()));
    await tester.pumpAndSettle();
    final l10n = await AppLocalizations.delegate.load(const Locale('es'));
    expect(find.text(l10n.itsEmpty), findsOneWidget); // l10n.itsEmpty
  });

  testWidgets('Renderiza lista de fondos', (tester) async {
    final fondos = [
      FundModel(id: '1', name: 'Fondo 1', amountMin: '100', category: 'A'),
      FundModel(id: '2', name: 'Fondo 2', amountMin: '200', category: 'B'),
    ];
    when(() => fundBloc.state).thenReturn(FundState(funds: fondos));
    whenListen(fundBloc, Stream<FundState>.empty(),
        initialState: FundState(funds: fondos));
    await tester.pumpWidget(makeTestableWidget(const HomeScreen()));
    await tester.pumpAndSettle();
    expect(find.text('Fondo 1'), findsOneWidget);
    expect(find.text('Fondo 2'), findsOneWidget);
  });

  testWidgets('Muestra SnackBar de éxito', (tester) async {
    when(() => fundBloc.state)
        .thenReturn(const FundState(status: SubscribeFundStatus.success));
    whenListen(
      fundBloc,
      Stream<FundState>.fromIterable([
        const FundState(),
        const FundState(status: SubscribeFundStatus.success),
      ]),
      initialState: const FundState(),
    );
    await tester.pumpWidget(makeTestableWidget(const HomeScreen()));
    await tester.pumpAndSettle();
    final l10n = await AppLocalizations.delegate.load(const Locale('es'));
    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text(l10n.subscriptionSuccess),
        findsOneWidget); // l10n.subscriptionSuccess
  });

  testWidgets('Muestra SnackBar de error', (tester) async {
    when(() => fundBloc.state).thenReturn(const FundState(
        status: SubscribeFundStatus.error,
        errorSubscribe: 'validationUserBalance'));
    whenListen(
      fundBloc,
      Stream<FundState>.fromIterable([
        const FundState(),
        const FundState(
            status: SubscribeFundStatus.error,
            errorSubscribe: 'validationUserBalance'),
      ]),
      initialState: const FundState(),
    );
    await tester.pumpWidget(makeTestableWidget(const HomeScreen()));
    await tester.pumpAndSettle();
    expect(find.byType(SnackBar), findsOneWidget);
  });
}
