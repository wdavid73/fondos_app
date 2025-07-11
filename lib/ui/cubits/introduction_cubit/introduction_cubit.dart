import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_starter_kit/ui/shared/service/service.dart';

part 'introduction_state.dart';

class IntroductionCubit extends Cubit<IntroductionState> {
  final KeyValueStorageService keyValueStorageService;
  IntroductionCubit(
    this.keyValueStorageService,
  ) : super(IntroductionState(
          hasSeen: false,
          isLoading: true,
        )) {
    checkIntroductionStatus();
  }

  Future<void> checkIntroductionStatus() async {
    final bool hasSeen =
        await keyValueStorageService.getValue('hasSeenIntroduction') ?? false;
    emit(state.copyWith(hasSeen: hasSeen, isLoading: false));
  }

  Future<void> markIntroductionAsSeen() async {
    await keyValueStorageService.setKeyValue('hasSeenIntroduction', true);
    emit(state.copyWith(hasSeen: true));
  }
}
