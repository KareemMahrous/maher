import 'package:flutter/material.dart';

class GenericConditionalBuilder<T> {
  final bool condition;
  final T onBuild;
  final T onFeedBack;

  GenericConditionalBuilder({
    required this.condition,
    required this.onBuild,
    required this.onFeedBack,
  });

  T get build {
    if (condition) {
      return onBuild;
    } else {
      return onFeedBack;
    }
  }
}


class ConditionalBuilder extends StatelessWidget {
  final bool condition;
  final Widget onBuild;
  final Widget? onFeedBack;

  const ConditionalBuilder({
    super.key,
    required this.condition,
    required this.onBuild,
    this.onFeedBack,
  });

  // static void function({
  //   required bool condition,
  //   required VoidCallback onBuild,
  //   VoidCallback? onFeedBack,
  // }) {
  //   if (condition) {
  //     onBuild;
  //   } else {
  //     onFeedBack ?? () {};
  //   }
  // }
  //
  // T generic({
  //   required bool condition,
  //   required T onBuild,
  //   required T onFeedBack,
  // }) {
  //   if (condition) {
  //     return onBuild;
  //   } else {
  //     return onFeedBack;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    Widget? widgetIs = const SizedBox();
    if (onFeedBack == null) {
      if (condition == true) {
        widgetIs = onBuild;
      }
    } else {
      if (condition == true) {
        widgetIs = onBuild;
      } else {
        widgetIs = onFeedBack;
      }
    }
    return widgetIs!;
  }
}
