import 'package:fondos_app/ui/blocs/blocs.dart';
import 'package:fondos_app/ui/cubits/subscribe_fund_form_cubit/subscribe_fund_form_cubit.dart';
import 'package:fondos_app/ui/shared/inputs/inputs.dart';
import 'package:mocktail/mocktail.dart';

class FakeSubscribeFundFormState extends Fake
    implements SubscribeFundFormState {}

class MockFundBloc extends Mock implements FundBloc {}

class MockAmountInput extends Mock implements AmountInput {}
