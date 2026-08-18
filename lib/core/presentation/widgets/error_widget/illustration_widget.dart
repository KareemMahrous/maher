import 'package:flutter/material.dart';

import '../../../core.dart';

enum IllustrationType { error, empty, warning }

class IllustrationWidget extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final String? buttonTitle;
  final VoidCallback? onTap;
  final Color? buttonColor;
  final Widget? icon;
  final IllustrationType? type;
  final bool hasCloseButton;

  const IllustrationWidget({
    super.key,
    this.title,
    this.subtitle,
    this.buttonTitle,
    this.onTap,
    this.buttonColor,
    this.icon,
    this.type,
    this.hasCloseButton = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 45.toW(context)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (icon != null) icon!,
          if (icon == null) renderIcon(context),
          54.esh(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.toW(context)),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomText(
                      title ?? LocaleKeys.anErrorOccurred.tr(),
                      color: context.color.descriptionColorDark,
                      fontWeight: FW.semiBold,
                      isFontResponsive: false,
                      fontSize: 16,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                15.esh(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: CustomText(
                        subtitle ?? LocaleKeys.errorDetails.tr(),
                        color: context.color.descriptionColorDark6,
                        fontWeight: FW.regular,
                        isFontResponsive: false,
                        textAlign: TextAlign.center,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          54.esh(),
          if (onTap != null)
            ButtonDefault(
              title: buttonTitle ?? LocaleKeys.tryAgain.tr(),
              buttonColor: buttonColor ?? renderColor(context),
              isResponsive: false,
              onTap: () {
                if (onTap != null) {
                  onTap!();
                }
              },
            ),
          if (hasCloseButton)
            Column(
              children: [
                context.verticalSpace(14),
                ButtonDefault(
                  title: LocaleKeys.close.tr(),
                  titleColor: context.color.colorBlack,
                  buttonColor: context.color.whiteColor,
                  borderColor: context.color.borderColor,
                  isResponsive: false,
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
        ],
      ),
    );
  }

  renderIcon(BuildContext context) {
    switch (type) {
      case IllustrationType.warning:
        return AppImages.images.png.warning.image(height: 130);
      case IllustrationType.error:
        return AppImages.images.svg.warning.svg(
          height: 130,
          colorFilter: ColorFilter.mode(
            context.color.currentTrans,
            BlendMode.srcIn,
          ),
        );
      case IllustrationType.empty:
        return AppImages.images.svg.warning.svg(
          height: 130,
          colorFilter: ColorFilter.mode(
            context.color.primaryFillColorLight,
            BlendMode.srcIn,
          ),
        );
      default:
        return AppImages.images.svg.warning.svg(
          height: 130,
          colorFilter: ColorFilter.mode(
            context.color.currentTrans,
            BlendMode.srcIn,
          ),
        );
    }
  }

  renderColor(BuildContext context) {
    switch (type) {
      case IllustrationType.error:
        return context.color.currentTrans;
      case IllustrationType.empty:
        return context.color.primaryFillColorLight;
      case IllustrationType.warning:
        return context.color.warning;
      default:
        return context.color.currentTrans;
    }
  }
}
