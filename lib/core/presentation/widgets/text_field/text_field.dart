import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../helper/extensions/context.dart';
import '../../../helper/translations/locale_keys.g.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String? errorText;
  final String hintText;
  final String? labelText;
  final TextDirection? neededTextDirection;
  final String? svgPrefixIconPath;
  final String? svgSuffixIconPath;
  final Widget? passwordSuffixWidget;
  final VoidCallback? suffixIconPress;
  final VoidCallback? onTap;
  final bool? isEnabled;

  final String? Function(String? value)? onSave;
  final dynamic Function(String? value)? onChange;
  final String? Function(String? value)? validator;

  final bool? isPasswordField;
  final int? maxLines;
  final int? maxLength;
  final Color? suffixIconColor;
  final Color? fillColor;
  final bool? filled;
  final bool? showOutPadding;
  final EdgeInsetsGeometry? contentPadding;
  final Color? prefixIconColor;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final double? width;
  final double? borderRadius;
  final bool? enabledBorder;
  final List<TextInputFormatter>? inputFormatters;

  final TextInputAction? inputAction;
  final TextInputType? textInputType;

  const CustomTextField({
    super.key,
    this.controller,
    this.borderRadius,
    this.passwordSuffixWidget,
    this.neededTextDirection,
    this.enabledBorder,
    required this.hintText,
    this.textStyle,
    this.hintStyle,
    this.labelText,
    this.svgPrefixIconPath,
    this.svgSuffixIconPath,
    this.suffixIconPress,
    this.onTap,
    this.isEnabled = true,
    this.onSave,
    this.onChange,
    this.showOutPadding,
    this.contentPadding,
    this.errorText,
    this.isPasswordField = false,
    this.maxLines,
    this.maxLength,
    this.suffixIconColor,
    this.fillColor,
    this.filled,
    this.prefixIconColor,
    this.validator,
    this.width,
    this.inputFormatters,
    this.inputAction,
    this.textInputType,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool isObscure = true;

  final _focus = FocusNode();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return TapRegion(
      onTapOutside: (tap) {
        // FocusScope.of(context).unfocus();
        // _focus.unfocus();
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: widget.width ?? MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              border:
                  widget.errorText != null
                      ? Border.all(color: context.color.redColor, width: 2)
                      : _focus.hasFocus
                      ? Border.all(color: context.color.primaryColor, width: 2)
                      : Border.all(color: context.color.borderColor, width: 1),
              borderRadius: BorderRadius.circular(widget.borderRadius ?? 6),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (widget.labelText != null)
                  Text(
                    widget.labelText!,
                    style: textTheme.bodyLarge?.copyWith(
                      color: context.color.greyBorder,
                    ),
                  ),
                TextFormField(
                  focusNode: _focus,
                  textDirection: widget.neededTextDirection,
                  inputFormatters: widget.inputFormatters ?? [],
                  textInputAction: widget.inputAction ?? TextInputAction.done,
                  onTapOutside: (_) {
                    _focus.unfocus();
                    setState(() {});
                  },
                  maxLength: widget.maxLength,
                  maxLines: widget.maxLines ?? 1,
                  keyboardType: widget.textInputType ?? TextInputType.text,
                  controller: widget.controller,
                  style:
                      widget.textStyle ??
                      textTheme.bodyLarge?.copyWith(
                        color: context.color.primaryColor,
                      ),
                  onTap: () {
                    _focus.requestFocus();
                    widget.onTap?.call();
                    setState(() {});
                  },
                  maxLengthEnforcement: MaxLengthEnforcement.enforced,
                  onChanged:
                      widget.onChange != null
                          ? (v) => widget.onChange!(v)
                          : null,
                  obscuringCharacter: "*",
                  enabled: widget.isEnabled,
                  cursorColor: context.color.primaryColor,
                  cursorHeight: 20,
                  decoration: InputDecoration(
                    contentPadding: widget.contentPadding ?? EdgeInsets.zero,
                    errorMaxLines: 2,
                    isDense: true,
                    filled: widget.filled ?? false,
                    fillColor: widget.fillColor ?? Colors.white,
                    disabledBorder: InputBorder.none,
                    // focusedBorder:  OutlineInputBorder(
                    //   borderSide: BorderSide(
                    //     color: context.color.primaryFillColor!,
                    //   ),
                    //   borderRadius: BorderRadius.circular(
                    //       widget.borderRadius ?? 6),
                    //
                    // ),
                    enabledBorder:
                        widget.enabledBorder ?? false
                            ? OutlineInputBorder(
                              borderSide: BorderSide(
                                color: context.color.primaryFillColor,
                              ),
                              borderRadius: BorderRadius.circular(
                                widget.borderRadius ?? 6,
                              ),
                            )
                            : InputBorder.none,
                    border:
                        widget.enabledBorder ?? false
                            ? OutlineInputBorder(
                              borderSide: BorderSide(
                                color: context.color.primaryFillColor,
                              ),
                              borderRadius: BorderRadius.circular(
                                widget.borderRadius ?? 6,
                              ),
                            )
                            : InputBorder.none,
                    hintText: widget.hintText,
                    labelStyle: widget.textStyle,
                    hintStyle:
                        widget.hintStyle ??
                        textTheme.bodyLarge?.copyWith(
                          color: context.color.hintColor,
                        ),
                    prefixIcon:
                        widget.svgPrefixIconPath == null
                            ? null
                            : SizedBox(
                              child: SvgPicture.asset(
                                widget.svgPrefixIconPath!,
                                colorFilter: ColorFilter.mode(
                                  widget.errorText != null
                                      ? context.color.redColor
                                      : widget.prefixIconColor ??
                                          context.color.colorGrey,
                                  BlendMode.srcIn,
                                ),
                                height: 0,
                                width: 0,
                              ),
                            ),

                    suffix:
                        widget.isPasswordField ?? false
                            ? GestureDetector(
                              onTap: () {
                                setState(() {
                                  isObscure = !isObscure;
                                });
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    isObscure
                                        ? LocaleKeys.show.tr()
                                        : LocaleKeys.hide.tr(),
                                    style: textTheme.bodyMedium!.copyWith(
                                      color:
                                          context
                                              .color
                                              .buttonNavigationBarSelectedColor,
                                    ),
                                  ),

                                  context.horizontalSpace(4),
                                  Icon(
                                    isObscure
                                        ? Icons.remove_red_eye_outlined
                                        : Icons.visibility_off_outlined,
                                    color:
                                        context
                                            .color
                                            .buttonNavigationBarSelectedColor,
                                  ),
                                ],
                              ),
                            )
                            : widget.svgSuffixIconPath == null
                            ? const SizedBox()
                            : GestureDetector(
                              onTap: widget.suffixIconPress,
                              child: SvgPicture.asset(
                                widget.svgSuffixIconPath!,
                                colorFilter: ColorFilter.mode(
                                  widget.suffixIconColor ??
                                      context.color.colorGrey,
                                  BlendMode.srcIn,
                                ),
                                width: 20,
                                height: 20,
                                fit: BoxFit.cover,
                              ),
                            ),
                  ),
                  obscureText: isObscure && widget.isPasswordField!,
                  onSaved:
                      widget.onSave == null ? null : (v) => widget.onSave!(v),
                  validator:
                      widget.validator == null
                          ? null
                          : (v) => widget.validator!(v),
                ),
              ],
            ),
          ),

          if (widget.errorText != null) ...[
            const SizedBox(height: 8),
            Text(
              widget.errorText!,
              style: textTheme.bodyLarge?.copyWith(
                color: context.color.redColor,
              ),
              maxLines: 2,
            ),
          ],
        ],
      ),
    );
  }
}
