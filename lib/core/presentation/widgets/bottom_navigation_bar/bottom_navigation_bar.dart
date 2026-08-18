import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core.dart';

class BottomNavigationBarWidget extends StatelessWidget {
  const BottomNavigationBarWidget({super.key, required this.currentIndex});

  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final textStyle =
        context.phone ? textTheme.titleMedium : textTheme.titleLarge;
    final double bottomPadding =
        context.viewPaddingBottom * (context.phone ? 3 : 4);
    return Container(
      width: context.width,
      height: bottomPadding,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          left: 50.0,
          right: 50,
          top: context.ipad ? 12 : 8,
          bottom: 0,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment:
              context.ipad
                  ? MainAxisAlignment.spaceEvenly
                  : MainAxisAlignment.spaceEvenly,
          children: [
            InkWell(
              onTap: () {
                context.read<LayoutCubit>().changePageIndex(0);
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AppImages.images.svg.homeIcon.svg(
                    colorFilter: ColorFilter.mode(
                      currentIndex == 0
                          ? context.color.buttonNavigationBarSelectedColor
                          : context.color.buttonNavigationBarUnSelectedColor,
                      BlendMode.srcIn,
                    ),
                  ),
                  context.verticalSpace(5),
                  Text(
                    LocaleKeys.home.tr(),
                    style: textStyle!.copyWith(
                      fontSize: !context.isPortrait ? 8.sp : 8.sp,
                      color:
                          currentIndex == 0
                              ? context.color.buttonNavigationBarSelectedColor
                              : context
                                  .color
                                  .buttonNavigationBarUnSelectedColor,
                    ),
                  ),
                ],
              ),
            ),
            // InkWell(
            //   onTap: () {
            //     // context.read<LayoutCubit>().changePageIndex(1);
            //   },
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.center,
            //     children: [
            //       AppImages.images.svg.calendarIcon.svg(
            //         colorFilter: ColorFilter.mode(
            //           currentIndex == 1
            //               ? context.color.buttonNavigationBarSelectedColor
            //               : context.color.buttonNavigationBarUnSelectedColor,
            //           BlendMode.srcIn,
            //         ),
            //       ),
            //       context.verticalSpace(2),
            //       Text(
            //         LocaleKeys.calendar.tr(),
            //         style: textStyle.copyWith(
            //           fontSize: !context.isPortrait ? 8.sp : 8.sp,
            //           color:
            //               currentIndex == 1
            //                   ? context.color.buttonNavigationBarSelectedColor
            //                   : context
            //                       .color
            //                       .buttonNavigationBarUnSelectedColor,
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            // InkWell(
            //   onTap: () {
            //     //context.read<LayoutCubit>().changePageIndex(2);
            //   },
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.center,
            //     children: [
            //       AppImages.images.svg.statisticsIcon.svg(
            //         colorFilter: ColorFilter.mode(
            //           currentIndex == 2
            //               ? context.color.buttonNavigationBarSelectedColor
            //               : context.color.buttonNavigationBarUnSelectedColor,
            //           BlendMode.srcIn,
            //         ),
            //       ),
            //       context.verticalSpace(2),
            //       Text(
            //         LocaleKeys.statistics.tr(),
            //         style: textStyle.copyWith(
            //           fontSize: !context.isPortrait ? 8.sp : 8.sp,
            //           color:
            //               currentIndex == 2
            //                   ? context.color.buttonNavigationBarSelectedColor
            //                   : context
            //                       .color
            //                       .buttonNavigationBarUnSelectedColor,
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            InkWell(
              onTap: () {
                context.read<LayoutCubit>().changePageIndex(3);
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AppImages.images.svg.profileIcon.svg(
                    colorFilter: ColorFilter.mode(
                      currentIndex == 3
                          ? context.color.buttonNavigationBarSelectedColor
                          : context.color.buttonNavigationBarUnSelectedColor,
                      BlendMode.srcIn,
                    ),
                  ),
                  context.verticalSpace(5),
                  Text(
                    LocaleKeys.profile.tr(),
                    style: textStyle.copyWith(
                      fontSize: !context.isPortrait ? 8.sp : 8.sp,
                      color:
                          currentIndex == 3
                              ? context.color.buttonNavigationBarSelectedColor
                              : context
                                  .color
                                  .buttonNavigationBarUnSelectedColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
