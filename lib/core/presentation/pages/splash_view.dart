import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core.dart';

@RoutePage()
class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    _navigateAfterDelay();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (context.phone) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    }
  }

  void _navigateAfterDelay() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(const Duration(seconds: 1));
      if (mounted) {
        context.router.pushAndPopUntil(
          const LayoutViewRoute(),
          predicate: (r) => false,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: context.width,
        height: context.height,
        decoration: BoxDecoration(
          color: const Color(0xff104631),
          image:
              context.phone
                  ? DecorationImage(
                    image: AssetImage(AppImages.images.png.splashMobile.path),
                    fit: BoxFit.fill,
                  )
                  : context.isPortrait
                  ? DecorationImage(
                    image: AssetImage(
                      AppImages.images.png.splashIpadPortrait.path,
                    ),
                    fit: BoxFit.fill,
                  )
                  : DecorationImage(
                    image: AssetImage(
                      AppImages.images.png.splashIpadLandscape.path,
                    ),
                    fit: BoxFit.fill,
                  ),
        ),
      ),
    );
  }
}
