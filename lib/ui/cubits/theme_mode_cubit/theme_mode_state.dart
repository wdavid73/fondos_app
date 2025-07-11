part of 'theme_mode_cubit.dart';

class ThemeModeState extends Equatable {
  final bool isDarkMode;

  const ThemeModeState({
    this.isDarkMode = false,
  });

  @override
  List<Object?> get props => [isDarkMode];

  ThemeModeState copyWith({
    bool? isDarkMode,
  }) {
    return ThemeModeState(
      isDarkMode: isDarkMode ?? this.isDarkMode,
    );
  }

  Map<String, dynamic> toJson() {
    return {'isDarkMode': isDarkMode};
  }

  static ThemeModeState fromJson(Map<String, dynamic> json) {
    return ThemeModeState(isDarkMode: json['isDarkMode'] ?? false);
  }
}