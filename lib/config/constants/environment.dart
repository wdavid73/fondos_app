import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static late String _flavor;

  static Future<void> initEnvironment({required String flavor}) async {
    _flavor = flavor;
    await dotenv.load(fileName: "flavors/.env.$flavor");
  }

  static String get flavor => _flavor;
  static String get apiUrl => dotenv.env['API_URL'] ?? '';
  static bool get showOnboarding => dotenv.env['SHOW_ONBOARDING'] == 'true';
  static String get appName => "My App";
}
