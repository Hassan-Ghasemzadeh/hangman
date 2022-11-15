import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hangman/core/get_it_config/get_it_config.dart';
import 'package:hemend/crash_handler/crash_handler.dart';
import 'package:hemend/generated_env.dart';

import 'core/nav_tools/nav_tools.dart';

void main() {
  CrashHandler.registerAndRunZoned(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await getItInitialRegistration();
      final tasks = [
        CrashHandler.I.activateLocalStorage,
        () {
          if ($Environments.HEMEND_CONFIG_DEBUG_LEVEL > 0) {
            CrashHandler.I.cleanBucket();
          }
        },
        CrashHandler.I.gatherBasicData,
      ];
      await CrashHandler.I.runTasks(
        tasks,
      );
      runApp(const MyApp());
    },
    useDefaultUri: false,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: GetIt.I.get(instanceName: GetItScopes.navigator.name),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: _routes,
      useInheritedMediaQuery: true,
      initialRoute: AppRoute.landing.path,
    );
  }
}

Map<String, Widget Function(BuildContext)> get _routes => //
    Map.fromEntries(
      appRoutes.values.map(
        (e) => MapEntry(
          e.route,
          e.builder,
        ),
      ),
    );
