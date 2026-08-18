import 'package:flutter/material.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';

import 'core/routes/app_router.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterForegroundTask.initCommunicationPort();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  static final AppRouter _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return WithForegroundTask(
      child: MaterialApp.router(routerConfig: _appRouter.config()),
    );
  }
}
