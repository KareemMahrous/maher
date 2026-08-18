import 'package:flutter/material.dart';

import '../../../../helper/extensions/context.dart';
import '../../../../helper/extensions/screen_spaces_extension.dart';
import '../../../../utils/Constants/Decorations/app_durations.dart';
import '../../../../utils/Constants/Decorations/app_sizes.dart';
import '../../Builders/conditional_builder.dart';

class ButtonIcon extends StatelessWidget {
  final IconData? iconData;

  final String? iconImage;
  final double size;
  final Color? circleColor;
  final VoidCallback? onTap;
  final Color? color;

  const ButtonIcon({
    super.key,
    this.iconData,
    this.onTap,
    this.color,
    this.iconImage,
    this.size = AppSizes.iconRad,
    this.circleColor,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      padding: EdgeInsets.all(5.0.toRad()),
      duration: AppDurations.buttonToggle,
      decoration: BoxDecoration(color: circleColor, shape: BoxShape.circle),
      child: IconButton(
        padding: EdgeInsetsDirectional.all(2.toRad()),
        iconSize: size,
        splashRadius: size * 0.7,
        icon: ConditionalBuilder(
          condition: iconData != null,
          onBuild: Icon(
            iconData,
            size: size,
            color: color ?? context.color.whiteColor,
          ),
          onFeedBack: ImageIcon(
            AssetImage("$iconImage"),
            size: size,
            color: color,
          ),
        ),
        onPressed: onTap,
      ),
    );
  }
}
