import 'package:flutter/material.dart';

import '../../../../core.dart';

enum ButtonStyle { withBorder, withOutBorder }

class ButtonDefault extends StatelessWidget {
  final String title;
  final String iconImage;
  final Color? buttonColor;
  final Color? disActiveButtonColor;
  final Color? titleColor;
  final Color? iconColor;
  final VoidCallback? onTap;
  final double height;
  final double? width;
  final double radius;
  final double titleSize;
  final double iconHeight;
  final Color? borderColor;
  final Color? disActiveBorderColor;
  final bool? active;
  final Widget? child;
  final FW fontWeight;
  final bool isResponsive;
  final bool isLoading;
  final MainAxisAlignment contentAlignment;

  const ButtonDefault({
    super.key,
    this.child,
    this.borderColor,
    this.disActiveButtonColor,
    //= AppColors.get.d,
    this.disActiveBorderColor, // = AppColors.buttonDisabled,
    this.titleSize = 16,
    this.iconHeight = 18,
    this.radius = AppSizes.radius,
    this.title = '',
    this.iconImage = '',
    this.buttonColor,
    this.titleColor = Colors.white,
    this.iconColor = Colors.white,
    this.onTap,
    this.height = 52,

    this.width,
    this.contentAlignment = MainAxisAlignment.center,
    this.active = true,
    this.isLoading = false,
    this.fontWeight = FW.semiBold,
    this.isResponsive = false,
  });

  @override
  Widget build(BuildContext context) {
    return BaseButton(
      height: height,
      width: width ?? AppSizes.screenSize.width,
      radius: radius,
      borderColor: active! ? borderColor : disActiveBorderColor,
      buttonColor: active! ? buttonColor : disActiveButtonColor,
      onTap: onTap,
      child:
          isLoading
              ? Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  children: [CustomLoading(color: context.color.whiteColor)],
                ),
              )
              : child ?? drawChild(context, isResponsive: isResponsive),
    );
  }

  Widget drawChild(BuildContext context, {bool isResponsive = true}) {
    if (title.isNotEmpty && iconImage.isEmpty) {
      //  return text only
      return Center(
        child: CustomText(
          title,
          color: titleColor ?? Colors.white,
          fontSize:
              // context.ipad? titleSize/AppSizes.orientationRatio:
              titleSize,
          fontWeight: fontWeight,
          isFontResponsive: isResponsive,
        ),
      );
    } else if (title.isEmpty && iconImage.isNotEmpty) {
      //  return icon only
      return Center(
        child: Image.asset(iconImage, color: iconColor, height: iconHeight),
      );
    } else if (title.isNotEmpty && iconImage.isNotEmpty) {
      //  return icon and text
      return Center(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 16.toW(context, isResponsive: isResponsive),
          ),
          child: Row(
            mainAxisAlignment: contentAlignment,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomText(
                title,
                color: titleColor ?? Colors.white,
                fontSize: titleSize,
                fontWeight: fontWeight,
              ),
              7.0.esw(),
              Image.asset(
                iconImage,
                color: iconColor ?? Colors.white,
                height: iconHeight,
              ),
            ],
          ),
        ),
      );
    } else {
      //  return text only
      //
      return Center(
        child: CustomText(
          title,
          color: titleColor ?? Colors.white,
          fontSize: titleSize,
          fontWeight: fontWeight,
          isFontResponsive: isResponsive,
        ),
      );
    }
  }
}
