import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

extension NavigationExtension on BuildContext {
  void goTo<T>(dynamic to, {AnimationType animationType = AnimationType.fade}) {
    if (Platform.isIOS) {
      Navigator.push(this, CupertinoPageRoute(builder: (context) => to));
    } else {
      Navigator.push(
        this,
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 300),
          transitionsBuilder:
              (
                BuildContext context,
                Animation<double> animation,
                Animation<double> secondaryAnimation,
                Widget child,
              ) {
                animation = CurvedAnimation(
                  parent: animation,
                  curve: Curves.fastOutSlowIn,
                  reverseCurve: Curves.easeInOutBack,
                );
                return TransitionPageBuilder(
                  animation: animation,
                  type: animationType,
                  secondaryAnimation: secondaryAnimation,
                  child: child,
                );
              },
          pageBuilder:
              (
                BuildContext context,
                Animation<double> animation,
                Animation<double> secondaryAnimation,
              ) => to,
        ),
      );
    }
  }

  void goBack() {
    Navigator.pop(this);
  }

  void goToUntil<T>(
    dynamic to, {
    AnimationType animationType = AnimationType.fade,
  }) {
    if (Platform.isIOS) {
      Navigator.pushAndRemoveUntil(
        this,
        CupertinoPageRoute(builder: (context) => to),
        (route) => false,
      );
    } else {
      Navigator.pushAndRemoveUntil(
        this,
        MaterialPageRoute(builder: (context) => to),
        (route) => false,
      );
    }
  }
}

enum AnimationType { fade, scale, slide }

class TransitionPageBuilder extends StatelessWidget {
  final AnimationType type;
  final Animation<double> animation;
  final Animation<double> secondaryAnimation;
  final Widget child;

  const TransitionPageBuilder({
    super.key,
    required this.type,
    required this.animation,
    required this.secondaryAnimation,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case AnimationType.fade:
        return FadeTransition(opacity: animation, child: child);
      case AnimationType.scale:
        return ScaleTransition(scale: animation, child: child);
      case AnimationType.slide:
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0.0, 1.0),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        );
    }
  }
}
