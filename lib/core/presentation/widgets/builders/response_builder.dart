import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../domain/entities/failure.dart';
import '../error_widget/error_widget.dart';
class ResponseBuilderWidget<T> extends StatelessWidget {
  final bool? isLoading;
  final Failure? failure;
  final Widget? errorWidget;
  final Widget Function()? childBuilder;
  final void Function()? onRetry;
  const ResponseBuilderWidget({
    super.key,
    required this.isLoading,
    required this.failure,
    required this.onRetry,
    this.childBuilder,
    this.errorWidget,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading ?? false) {
      return Skeletonizer(child: childBuilder!());
    }
    if (failure != null) {
      return CustomErrorWidget(
        failure: failure,
        onPressed: () {
          if (onRetry != null) {
            onRetry!();
          }
        },
      );
    }
    if (childBuilder != null) {
      return childBuilder!();
    }
    return const SizedBox();
  }
}
