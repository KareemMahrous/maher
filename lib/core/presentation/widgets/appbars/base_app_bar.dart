import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../../../core.dart';

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double? toolbarHeight;
  final double? bottomHeight;
  final String title;
  final bool withBack;
  final Widget? actions;

  const BaseAppBar({
    super.key,
    this.toolbarHeight = 100,
    this.bottomHeight = 20,
    this.title = '',
    this.withBack = false,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: toolbarHeight,
      color: context.color.primaryColor,
      child: Padding(
        padding: EdgeInsets.only(
          left: 16.toW(context),
          right: 16.toW(context),
          top: 8.toH(context),
          bottom: 8.toH(context),
        ),
        child: Row(
          mainAxisAlignment:
              !withBack && actions == null
                  ? MainAxisAlignment.center
                  : MainAxisAlignment.spaceBetween,
          children: [
            if (withBack)
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      context.back();
                    },
                    child: Container(
                      color: Colors.transparent,
                      child: AppImages.images.svg.arrowBackAr.svg(
                        height: 24.toH(context),
                      ),
                    ),
                  ),
                  16.esw(),
                  CustomText(
                    title,
                    fontSize: 14,
                    fontWeight: FW.semiBold,
                    color: context.color.whiteColor,
                  ),
                ],
              ),
            if (title.isNotEmpty && !withBack)
              CustomText(
                title,
                fontSize: 14,
                fontWeight: FW.semiBold,
                color: context.color.whiteColor,
              ),
            if (!withBack && actions == null) const SizedBox(),
          ],
        ),
      ),
    );
  }

  Widget renderIcon({
    required BuildContext context,
    required SvgGenImage icon,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: () {
        if (onTap != null) {
          onTap();
        }
      },
      child: Container(
        height: 26.toH(context),
        width: 26.toH(context),
        decoration: BoxDecoration(
          color: context.color.whiteColor.withAlpha(15),
          borderRadius: BorderRadius.circular(36.toRad()),
        ),
        child: Center(child: icon.svg(height: 15.toH(context))),
      ),
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight((toolbarHeight ?? kToolbarHeight) + (bottomHeight ?? 0));
}
