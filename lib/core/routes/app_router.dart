import 'package:auto_route/auto_route.dart';

import '../../features/record_meeting/record_meeting.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'View,ViewRoute')
class AppRouter extends RootStackRouter {
  AppRouter({super.navigatorKey});

  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: RecordMeetingViewRoute.page, initial: true),
  ];
}
