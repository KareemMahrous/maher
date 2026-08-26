import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import '../../../../core/routes/app_router.dart';

@RoutePage()
class AuthGateView extends StatefulWidget {
  const AuthGateView({super.key});

  @override
  State<AuthGateView> createState() => _AuthGateViewState();
}

class _AuthGateViewState extends State<AuthGateView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _redirectFromLoginState();
    });
  }

  void _redirectFromLoginState() {
    final isUserLoggedIn =
        SharedPref.getBoolean(PrefKeys.isUserLoggedIn) ?? false;

    if (!mounted) {
      return;
    }

    context.router.replace(
      isUserLoggedIn ? const RecordMeetingViewRoute() : const LoginViewRoute(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
