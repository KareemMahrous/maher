import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../helper/extensions/context.dart';
import '../../../../helper/extensions/screen_spaces_extension.dart';
import '../../../../utils/Constants/Decorations/app_sizes.dart';

enum ButtonType { withBorder, withOutBorder }

class BaseButton extends StatelessWidget {
  final VoidCallback? onTap;
  final double height;
  final double? width;
  final Color? borderColor;
  final double radius;
  final Widget? child;
  final Color? buttonColor;
  final bool isResponsive;

  const BaseButton({
    super.key,
    this.borderColor,
    this.child,
    this.radius = AppSizes.radius,
    this.buttonColor,
    this.onTap,
    this.height = 55,
    this.width,
    this.isResponsive=true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:
          onTap ??
          () {
            debugPrint('hello this tap in button');
          },
      child: Container(
        height: height.toH(context, isResponsive: isResponsive),
        width: width?.toW(context,isResponsive: isResponsive),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius.r),
          border: Border.all(
            color: borderColor ?? Colors.transparent,
            width: borderColor != null ? 1 : 0,
          ),
          color: buttonColor ?? context.color.primaryFillColorLight,
        ),
        child: child ?? const Center(),
      ),
    );
  }
}
