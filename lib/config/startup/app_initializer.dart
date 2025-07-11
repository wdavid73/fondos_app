import 'package:flutter/foundation.dart';
import 'package:flutter_starter_kit/app/dependency_injection.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

class AppInitializer {
  static Future<void> init() async {
    /// Initializes environment variables required for the app.
    // await Environment.initEnvironment();

    /// Configures the HydratedBloc storage.
    final storage = await HydratedStorage.build(
      storageDirectory: kIsWeb
          ? HydratedStorageDirectory.web
          : HydratedStorageDirectory((await getTemporaryDirectory()).path),
    );

    /// Sets the storage for HydratedBloc.
    HydratedBloc.storage = storage;

    AppDependencyInjection.init();

    /// You can add more initialization tasks here.
    /// Example: await Firebase.initializeApp();
    /// Example: await Hive.initFlutter();
    /// Example: await GetStorage.init();
  }
}
