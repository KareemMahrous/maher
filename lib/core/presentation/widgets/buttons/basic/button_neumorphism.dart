import 'package:flutter/material.dart';

import '../../../../helper/extensions/screen_spaces_extension.dart';
import '../../../../utils/Constants/Decorations/app_durations.dart';
import '../../../../utils/Constants/Decorations/app_sizes.dart';
import '../../Text/src/imports_text.dart';

class ButtonNeumorphism extends StatefulWidget {
  final bool isCircle;
  final double curve;
  final Widget? child;
  final Color? backColor;
  final String? title;
  final Color? titleColor;
  final double? titleSize;
  final double? height;
  final double? width;

  const ButtonNeumorphism({
    super.key,
    this.isCircle = false,
    this.curve = AppSizes.buttonCurve,
    this.child,
    this.backColor,
    this.title,
    this.titleColor,
    this.titleSize,
    this.height,
    this.width,
  });

  @override
  State<ButtonNeumorphism> createState() => _NeumorphismState();
}

class _NeumorphismState extends State<ButtonNeumorphism> {
  bool selected = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPressStart: (details) {
        setState(() {
          selected = !selected;
        });
      },
      onLongPressEnd: (details) {
        selected = !selected;
      },
      //...
      onLongPressCancel: () {
        selected = !selected;
      },
      onTap: () {
        setState(() {
          selected = !selected;
        });
        Future.delayed(AppDurations.miniButtonToggle).then((value) {
          setState(() {
            selected = !selected;
          });
        });
      },
      child: AnimatedContainer(
        margin: EdgeInsets.all(2.toH(context)),
        height: (widget.height ?? 40).toH(context),
        width: (widget.width ?? double.infinity).toW(context),
        duration: AppDurations.buttonToggle,
        decoration: BoxDecoration(
          color: widget.backColor ?? Colors.grey[300],
          borderRadius:
              widget.isCircle
                  ? null
                  : BorderRadius.circular(widget.curve.toRad()),
          shape: widget.isCircle ? BoxShape.circle : BoxShape.rectangle,
          boxShadow:
              selected
                  ? [
                    BoxShadow(
                      color: Colors.grey[500]!,
                      offset: const Offset(4, 4),
                      blurRadius: 7,
                      spreadRadius: 0.7,
                    ),
                    const BoxShadow(
                      color: Colors.white,
                      offset: Offset(-4, -4),
                      blurRadius: 7,
                      spreadRadius: 0.7,
                    ),
                  ]
                  : null,
        ),
        child: Center(
          child:
              widget.child ??
              CustomText(
                widget.title ?? "",
                fontSize: widget.titleSize,
                color: widget.titleColor,
              ),
        ),
      ),
    );
  }
}
