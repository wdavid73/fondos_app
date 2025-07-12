part of 'user_cubit.dart';

class UserState extends Equatable {
  final String name;
  final double balance;

  const UserState({
    required this.name,
    required this.balance,
  });

  factory UserState.initial() => const UserState(
        name: 'Joe doe',
        balance: 500000,
      );

  @override
  List<Object> get props => [balance];

  UserState copyWith({
    String? name,
    double? balance,
  }) =>
      UserState(
        name: name ?? this.name,
        balance: balance ?? this.balance,
      );
}
