part of 'introduction_cubit.dart';

class IntroductionState {
  final bool hasSeen;
  final bool isLoading;

  IntroductionState({required this.hasSeen, required this.isLoading});

  IntroductionState copyWith({bool? hasSeen, bool? isLoading}) {
    return IntroductionState(
      hasSeen: hasSeen ?? this.hasSeen,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
