import 'package:auto_route/auto_route.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'View,ViewRoute')
class AppRouter extends RootStackRouter {
  AppRouter({super.navigatorKey}); // ✅ accept the navigatorKey here

  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: SplashViewRoute.page, initial: true),
  ];
}
