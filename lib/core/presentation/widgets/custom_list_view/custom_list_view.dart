// import 'package:flutter/material.dart';
//
// import '../error_widget/illustration_widget.dart';
//
// class CustomListViewBuilder extends StatelessWidget {
//   final Widget? Function(BuildContext, int) itemBuilder;
//   final Widget Function(BuildContext, int)? separatorBuilder;
//   final int itemCount;
//   final EdgeInsetsGeometry? padding;
//   final ScrollController? controller;
//   final ScrollPhysics? physics;
//   final bool shrinkWrap;
//
//   /// Empty list illustration widget
//   final String? emptyTitle;
//   final String? emptyDescription;
//   final Function()? onTap;
//
//   const CustomListViewBuilder({
//     super.key,
//     required this.itemBuilder,
//     this.separatorBuilder,
//     this.padding,
//     this.controller,
//     this.physics,
//     this.shrinkWrap = false,
//     required this.itemCount,
//     this.emptyTitle,
//     this.emptyDescription,
//     this.onTap,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return itemCount == 0
//         ? IllustrationWidget(type: IllustrationType.empty, onTap: onTap)
//         : ListView.separated(
//           physics: physics,
//           shrinkWrap: shrinkWrap,
//           controller: controller,
//           padding: padding,
//           itemBuilder: itemBuilder,
//           separatorBuilder:
//               separatorBuilder ?? (context, index) => const SizedBox(),
//           // separatorBuilder?? (context, index) =>   SizedBox(height: 0),
//           itemCount: itemCount,
//         );
//   }
// }
