import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';

import 'core/core.dart';
import 'core/routes/app_router.dart';

Future<void> main() => bootstrap(Flavor.production);

Future<void> bootstrap(Flavor flavor) async {
  WidgetsFlutterBinding.ensureInitialized();
  BuildConfig.setFlavor(flavor);
  await EasyLocalization.ensureInitialized();
  await SharedPref.instantiatePreferences();
  FlutterForegroundTask.initCommunicationPort();
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      startLocale: const Locale('ar'),
      fallbackLocale: const Locale('ar'),
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  static final AppRouter _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return WithForegroundTask(
      child: MaterialApp.router(
        title: 'app.title'.tr(),
        routerConfig: _appRouter.config(),
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
      ),
    );
  }
}
