//
// import 'package:arch/core/helper/extensions/context.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// class CustomRoundedButton extends StatelessWidget {
//   final Widget? child;
//   final String? title;
//
//   final Color? backgroundColor;
//   final Color? disabledBackgroundColor;
//   final Color? titleColor;
//   final Color? disabledColor;
//   final Color? color;
//   final VoidCallback? onPressed;
//   final double elevation;
//   final double? height;
//   final BorderRadius? borderRadius;
//   final double? width;
//   final double? titleSize;
//   final bool isDisabled;
//   final EdgeInsetsGeometry? padding;
//
//   final String tooltip;
//
//   const CustomRoundedButton({
//     Key? key,
//     this.backgroundColor,
//     this.disabledBackgroundColor,
//     this.disabledColor = Colors.grey,
//     this.color = Colors.white,
//     this.onPressed,
//     this.elevation = 1.0,
//     this.padding,
//     this.child,
//     this.tooltip = '',
//     this.isDisabled = false,
//     this.height,
//     this.width,
//     this.title,
//     this.titleColor = Colors.white,
//     this.titleSize = 10,
//     this.borderRadius,
//   }) : super(key: key);
//
//   //
//   // Rounded Icon Button -------------------------------------------------------
//   factory CustomRoundedButton.icon({
//     /// new
//     required final String label,
//     required final IconData icon,
//
//     /// super
//     final Color? backgroundColor,
//     final Color? disabledBackgroundColor = Colors.black12,
//     final Color? disabledColor = Colors.white70,
//     final Color? color = Colors.white,
//     final VoidCallback? onPressed,
//     final bool isDisabled = false,
//     final bool isUpperCase = false,
//     final String tooltip = '',
//   }) =>
//       CustomRoundedButton(
//         tooltip: tooltip,
//         onPressed: onPressed,
//         isDisabled: isDisabled,
//         color: color,
//         disabledColor: disabledColor,
//         disabledBackgroundColor: disabledBackgroundColor,
//         backgroundColor: backgroundColor ?? AppColors.get.primary,
//         child: Builder(builder: (context) {
//           Color? _color;
//           if (isDisabled) {
//             _color = AppColors.get.disabled;
//           } else {
//             _color = color;
//           }
//           return _IconRoundedChild(
//             color: _color,
//             label: label,
//             icon: icon,
//             isUpperCase: isUpperCase,
//           );
//         }),
//       );
//
//   // Rounded Image Button ------------------------------------------------------
//   factory CustomRoundedButton.image({
//     /// new
//     required final String label,
//     required final ImageProvider image,
//     final double side = 25,
//
//     /// super
//     final Color? backgroundColor,
//     final Color? disabledBackgroundColor = Colors.black12,
//     final Color? disabledColor = Colors.white70,
//     final double? height,
//     final Color? color = Colors.white,
//     final VoidCallback? onPressed,
//     final bool isDisabled = false,
//     final bool isUpperCase = false,
//     final EdgeInsetsGeometry? padding,
//     final String tooltip = '',
//   }) =>
//       CustomRoundedButton(
//         padding: padding,
//         tooltip: tooltip,
//         onPressed: onPressed,
//         height: height,
//         isDisabled: isDisabled,
//         color: color,
//         disabledColor: disabledColor,
//         disabledBackgroundColor: disabledBackgroundColor,
//         backgroundColor: backgroundColor ?? AppColors.get.primary,
//         child: Builder(builder: (context) {
//           Color? _color;
//           if (isDisabled) {
//             _color = context.color;
//           } else {
//             _color = color;
//           }
//           return _ImageRoundedChild(
//             label: label,
//             image: image,
//             color: _color,
//             side: side,
//             isUpperCase: isUpperCase,
//           );
//         }),
//       );
//
//   @override
//   Widget build(BuildContext context) {
//     return Builder(builder: (context) {
//       Color? _backgroundColor;
//       Color? _color;
//       if (isDisabled) {
//         _backgroundColor = disabledBackgroundColor;
//         _color = disabledColor;
//       } else {
//         _backgroundColor = backgroundColor ?? AppColors.get.primary;
//         _color = color;
//       }
//       return IgnorePointer(
//         ignoring: isDisabled,
//         child: SizedBox(
//           width: width,
//           child: CupertinoButton(
//             color: _backgroundColor,
//             disabledColor: disabledColor!,
//             borderRadius: borderRadius ?? BorderRadius.circular(28.toRad()),
//             minSize: height,
//             child: tooltip != ''
//                 ? Tooltip(
//                     message: tooltip,
//                     child: child ??
//                         CustomText(
//                           "$title",
//                           fontSize: titleSize,
//                           fontWeight: FW.regular,
//                           color: titleColor,
//                         ),
//                   )
//                 : child ??
//                     CustomText(
//                       "$title",
//                       fontSize: titleSize,
//                       fontWeight: FW.regular,
//                       color: titleColor,
//                     ),
//             onPressed: onPressed,
//           ),
//           // child: Padding(
//           //   padding: padding ?? EdgeInsets.zero,
//           //   child: Material(
//           //     borderRadius: BorderRadius.circular(8.0),
//           //     color: _backgroundColor,
//           //     elevation: isDisabled ? 0.0 : elevation,
//           //     child: MaterialButton(
//           //       textColor: _color,
//           //       child: tooltip != ''
//           //           ? Tooltip(
//           //               message: tooltip,
//           //               child: child ??
//           //                   CustomText(
//           //                     "$title",
//           //                     fontSize: titleSize,
//           //                     fontWeight: FW.regular,
//           //                     color: titleColor,
//           //                   ),
//           //             )
//           //           : child ??
//           //               CustomText(
//           //                 "$title",
//           //                 fontSize: titleSize,
//           //                 fontWeight: FW.regular,
//           //                 color: titleColor,
//           //               ),
//           //       onPressed: isDisabled ? null : onPressed,
//           //       padding: EdgeInsets.zero,
//           //     ),
//           //   ),
//           // ),
//         ),
//       );
//     });
//   }
// }
//
// class _IconRoundedChild extends StatelessWidget {
//   final String label;
//   final IconData icon;
//   final Color? color;
//
//   final bool isUpperCase;
//
//   const _IconRoundedChild(
//       {Key? key,
//       required this.label,
//       required this.icon,
//       this.color,
//       required this.isUpperCase})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.start,
//       children: [
//         Icon(icon, color: color),
//         Expanded(
//           child: text(
//             isUpperCase ? label.toUpperCase() : label,
//             textAlign: TextAlign.center,
//             style:
//                 Theme.of(context).
//textTheme.bodyMedium?.copyWith(color: color),
//           ),
//         ),
//       ],
//     );
//   }
// }
//
// class _ImageRoundedChild extends StatelessWidget {
//   final String label;
//   final ImageProvider image;
//   final Color? color;
//
//   final bool isUpperCase;
//   final double side;
//
//   const _ImageRoundedChild(
//       {Key? key,
//       required this.label,
//       required this.image,
//       this.color,
//       required this.isUpperCase,
//       required this.side})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Image(
//           image: image,
//           width: side,
//           height: side,
//         ),
//         XSpace.light,
//         CustomText(
//           isUpperCase ? label.toUpperCase() : label,
//           textAlign: TextAlign.center,
//           color: color,
//           fontSize: 12,
//           fontWeight: FW.medium,
//         ),
//       ],
//     );
//   }
// }
