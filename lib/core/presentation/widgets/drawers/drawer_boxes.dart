import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/helper/extensions/context.dart';
import '../../../../../core/helper/extensions/screen_spaces_extension.dart';
import '../../../../../core/helper/generated/assets.gen.dart';
import '../../../../../core/presentation/widgets/text/custom_text_lib.dart';
import '../../../../features/home_feature/domain/facrtories/drawer_boxes_factory.dart';
import '../../../../features/home_feature/presentation/manager/builders/home_data_builder.dart';
import '../../../../features/home_feature/presentation/manager/callers/home_api_caller.dart';
import '../../manager/box_count/get_box_count_cubit.dart';
import 'drawer_item.dart';

class DrawerBoxes extends StatefulWidget {
  const DrawerBoxes({super.key});

  @override
  State<DrawerBoxes> createState() => _DrawerBoxesState();
}

class _DrawerBoxesState extends State<DrawerBoxes> {
  final int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    final boxes = DrawerBoxesFactory.instance.getBoxes(context);
    final cubit = context.read<GetBoxCountCubit>();
    return Drawer(
      width: 230.toW(context),
      shape: const RoundedRectangleBorder(),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        height: double.infinity,
        width: 230.toW(context),
        color: context.color.primaryColor,
        child: BlocBuilder<GetBoxCountCubit, GetBoxCountState>(
          builder:
              (context, state) => Column(
                children: [
                  Expanded(
                    child: ListView(
                      children: [
                        if (MediaQuery.of(context).size.shortestSide < 600) ...[
                          renderHeader(context),
                          32.esh(),
                        ],
                        if (MediaQuery.of(context).size.shortestSide >= 600)
                          90.esh(),
                        ...boxes.map(
                          (e) => Padding(
                            padding: const EdgeInsets.only(
                              bottom: 16,
                              right: 16,
                              left: 16,
                            ),
                            child: DrawerItem(
                              box: e,
                              active: e.id == cubit.box!.id,
                              onTap: () {
                                HomeDataBuilder.instance.setBoxNumber(e.id);
                                HomeDataBuilder.instance.setBx(e);
                                context.read<GetBoxCountCubit>().setBox(e);
                                HomeApiCaller.instance.callHome(context);
                                if (MediaQuery.of(context).size.shortestSide <
                                    600) {
                                  Navigator.pop(context);
                                }
                              },
                              count:
                                  state is GetBoxCountSuccess
                                      ? cubit.getBoxByNumber(e.id).count
                                      : 0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
        ),
      ),
    );
  }

  Widget renderHeader(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 16.toW(context),
        vertical: 16.toH(context),
      ),
      child: Row(
        children: [
          AppImages.images.logos.splashLogo.image(height: 50.toH(context)),
          8.esw(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CustomText(
                    'نظام',
                    color: context.color.primaryFillColorLight,
                    fontWeight: FW.semiBold,
                    fontSize: 11,
                  ),
                  2.esw(),
                  CustomText(
                    'المراسلات',
                    color: context.color.whiteColor,
                    fontWeight: FW.semiBold,
                    fontSize: 11,
                  ),
                ],
              ),
              CustomText(
                'المطور',
                color: context.color.whiteColor,
                fontWeight: FW.semiBold,
                fontSize: 11,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
