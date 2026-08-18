import 'package:flutter/material.dart';

import '../../../../helper/extensions/context.dart';
import '../../../../helper/extensions/native_navigation_extension.dart';
import '../../../../helper/extensions/screen_spaces_extension.dart';

class ButtonBack extends StatelessWidget {
  final double? width;
  final double? height;
  final VoidCallback? onTap;
  final Color? borderColor;
  final Color? iconColor;

  const ButtonBack({
    super.key,
    this.height,
    this.width,
    this.onTap,
    this.borderColor,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 32.toW(context),
      height: height ?? 32.toW(context),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(32.toRad()),
        border: Border.all(
          color: borderColor ?? context.color.borderColor,
          width: 1.toW(context),
        ),
      ),
      child: IconButton(
        onPressed: () {
          if (onTap != null) {
            onTap!();
          }
          // Get.back();
          context.goBack();
          // SystemChrome.setPreferredOrientations([
          //   DeviceOrientation.portraitUp,
          //   DeviceOrientation.portraitDown,
          // ]);
        },
        icon: Center(
          child: Image.asset(
            '',
            color: iconColor ?? context.color.colorBlack,
            height: 24.toH(context),
          ),
        ),
      ),
    );
  }
}
