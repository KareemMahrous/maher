import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';

import '../../../helper/extensions/context.dart';

class SharedAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SharedAppBar({
    super.key,
    this.title,
    this.centerTitle = true,
    this.customHeight = kToolbarHeight,
    this.hasBackIcon = true,
    this.backButton,
    this.actions,
    this.backgroundColor,
  });

  final String? title;
  final bool centerTitle;
  final double customHeight;
  final bool hasBackIcon;
  final Widget? backButton;
  final List<Widget>? actions;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final bg = backgroundColor ?? context.color.primaryColor;
    final isLight = backgroundColor != null;
    final contentColor = isLight ? context.color.textBlack : context.color.whiteColor;
    return ColorfulSafeArea(
      color: bg,
      top: true,
      bottom: false,
      left: false,
      right: false,
      child: AppBar(
        surfaceTintColor: bg,
        centerTitle: centerTitle,
        backgroundColor: bg,
        automaticallyImplyLeading: hasBackIcon,
        iconTheme: IconThemeData(color: contentColor),
        leading: backButton,
        title:
            title != null
                ? Text(
                  title!,
                  style: textTheme.bodyMedium!.copyWith(
                    color: contentColor,
                    fontWeight: FontWeight.w700,
                  ),
                )
                : null,
        actions: actions,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(customHeight);
}
