import 'package:flutter/material.dart';

import '../../../../../core/helper/extensions/context.dart';
import '../../../../../core/helper/extensions/screen_spaces_extension.dart';
import '../../../../../core/presentation/widgets/text/custom_text_lib.dart';
import '../../../../features/home_feature/domain/entities/drawer_box_entity.dart';
import '../../../../features/home_feature/presentation/manager/builders/home_data_builder.dart';
import '../../../domain/entities/enum/box_enum.dart';

class DrawerItem extends StatelessWidget {
  final DrawerBoxEntity box;
  final VoidCallback? onTap;
  final int count;
  final bool active;

  const DrawerItem({
    super.key,
    required this.box,
    this.onTap,
    this.count = 0,
    this.active = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onTap != null) {
          onTap!();
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color:
              active
                  ? context.color.whiteColor
                  : context.color.whiteColor.withAlpha(20),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 10.toW(context),
            vertical: 16.toH(context),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    if (box.icon != null)
                      box.icon!.svg(
                        colorFilter: ColorFilter.mode(
                          active
                              ? context.color.primaryColor
                              : context.color.whiteColor,
                          BlendMode.srcIn,
                        ),
                        height: 24.toH(context),
                        // width: 24.toH(context),
                      ),
                    15.esw(),
                    Expanded(
                      child: CustomText(
                        box.title,
                        color:
                            active
                                ? context.color.primaryColor
                                : context.color.whiteColor,
                        fontSize: 14,
                        fontWeight: FW.bold,
                      ),
                    ),
                  ],
                ),
              ),
              if (!(HomeDataBuilder.instance.outBoxNumbers.contains(box.id)||
                  box.id == BoxNumberEnum.closedBox.value)) ...[
                10.esw(),
                renderCount(context, count: count),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget renderCount(BuildContext context, {int count = 0}) {
    return count > -1
        ? ConstrainedBox(
          constraints: const BoxConstraints(minWidth: 30),
          child: Container(
            decoration: BoxDecoration(
              color:
                  // active?
                  context.color.primaryColor,
              // context.color.whiteColor,
              shape: BoxShape.circle,
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                left: 8,
                right: 8,
                top: 6,
                bottom: 6,
              ),
              child: Center(
                child: CustomText(
                  // count>999?
                  //     "999+":
                  count.toString(),
                  color:
                      // active?
                      context.color.whiteColor,
                  // context.color.primaryColor,
                  fontSize: 14,
                  fontWeight: FW.semiBold,
                ),
              ),
            ),
          ),
        )
        : const Center();
  }
}
