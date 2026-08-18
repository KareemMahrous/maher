import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../helper/extensions/context.dart';
import '../../../../helper/extensions/native_navigation_extension.dart';
import '../../../../helper/extensions/screen_spaces_extension.dart';

class ButtonClose extends StatelessWidget {
  final VoidCallback? onTap;
  final Color? backgroundColor;
  final Color? closeColor;

  const ButtonClose({
    super.key,
    this.onTap,
    this.backgroundColor,
    this.closeColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:
          onTap ??
          () {
            context.goBack();
          },
      child: Container(
        height: 25.toH(context),
        width: 25.toH(context),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          color:
              backgroundColor ?? context.color.colorGrey.withValues(alpha: .4),
        ),
        child: Center(
          child: Icon(
            Icons.close,
            color: closeColor ?? context.color.colorBlack,
            size: 14.5.h,
          ),
        ),
      ),
    );
  }
}
