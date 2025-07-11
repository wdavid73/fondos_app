import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'theme_mode_state.dart';

/// Cubit that handles the theme mode (light/dark mode) state.
class ThemeModeCubit extends HydratedCubit<ThemeModeState> {
  /// Constructor initializes the cubit with the initial state.
  ThemeModeCubit() : super(ThemeModeState());

  /// Toggles between dark and light mode by updating the state.
  /// This method will emit the new state with the opposite value of `isDarkMode`.
  void toggleTheme() async {
    emit(state.copyWith(isDarkMode: !state.isDarkMode));
  }

  /// Converts the JSON representation of the state back into a `ThemeModeState`.
  ///
  /// [json] The JSON map representing the previous state.
  /// Returns the `ThemeModeState` instance recreated from the JSON.
  @override
  ThemeModeState? fromJson(Map<String, dynamic> json) {
    return ThemeModeState.fromJson(json);
  }

  /// Converts the current `ThemeModeState` instance into a JSON map for persistence.
  ///
  /// [state] The current state to be serialized.
  /// Returns a map that represents the `ThemeModeState` as JSON.
  @override
  Map<String, dynamic>? toJson(ThemeModeState state) {
    return state.toJson();
  }
}