import 'package:flutter/material.dart';

import '../../../../core.dart';

class ButtonHolder extends StatelessWidget {
  final Widget child;
  final bool hasChild;
  final bool hasShadow;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;
  final bool hasBorder;

  const ButtonHolder({
    super.key,
    required this.child,
    this.backgroundColor,
    this.hasBorder = true,
    this.hasChild = true,
    this.padding,
    this.hasShadow = true,
  });

  @override
  Widget build(BuildContext context) {
    return hasChild
        ? Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: backgroundColor ?? context.color.whiteColor,
            borderRadius:
                hasBorder
                    ? const BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                    )
                    : null,
            boxShadow: [
              if (hasShadow)
                BoxShadow(
                  color: context.color.lightGrey,
                  blurRadius: 10,
                  spreadRadius: 0,
                  offset: const Offset(0, -4),
                ),
            ],
          ),
          child: Padding(
            padding:
                padding ??
                EdgeInsets.only(
                  left: 35.toW(context),
                  right: 35.toW(context),
                  top: 20.toH(context),
                  bottom: context.viewPaddingBottom * 1.2,
                ),
            child: child,
          ),
        )
        : const SizedBox.shrink();
  }
}
