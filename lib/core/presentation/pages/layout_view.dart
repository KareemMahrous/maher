import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../features/home_feature/presentation/manager/home_feature/fetch_transactions_cubit.dart';
import '../../core.dart';
import '../manager/box_count/get_box_count_cubit.dart';
import '../manager/user_profile/get_user_profile_cubit.dart';
import '../manager/user_settings/user_settings_cubit.dart';
import '../widgets/bottom_sheet/bottom_sheet_widget.dart';
import '../widgets/drawers/drawer_boxes.dart';
import '../widgets/error_widget/illustration_widget.dart';

class LayoutView extends StatefulWidget {
  const LayoutView({super.key});

  @override
  State<LayoutView> createState() => _LayoutViewState();
}

class _LayoutViewState extends State<LayoutView> {
  // late ScribbleNotifier scribbleNotifier;
  // GlobalKey globalKeys = GlobalKey();

  @override
  void initState() {
    // scribbleNotifier = ScribbleNotifier();
    // scribbleNotifier.addListener(() {
    //   print('hiii');
    // });
    context.read<LayoutCubit>().checkUserRole();
    context.read<GetUserProfileCubit>().getUserProfile();

    super.initState();
    // context.read<GetHomeStatisticsCubit>().getStatistics();
  }

  // saveImage() async {
  //   // final byteData = await scribbleNotifier.renderImage(
  //   //   pixelRatio: 2.0,
  //   //   format: ImageByteFormat.png,
  //   // );
  //   final boundary =
  //       globalKeys.currentContext!.findRenderObject() as RenderRepaintBoundary;
  //   final image = await boundary.toImage(pixelRatio: 2.0);
  //   final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
  //   final Uint8List pngBytes = byteData!.buffer.asUint8List();
  //   final directory = await getTemporaryDirectory();
  //   final imagePath = '${directory.path}/vvv.png';
  //   print(imagePath);
  //   await File(imagePath).writeAsBytes(pngBytes);
  // }

  @override
  Widget build(BuildContext context) {
    // return RepaintBoundary(
    //   key: globalKeys,
    //   child: Container(
    //     color: Colors.transparent,
    //     width: context.width,
    //     height: context.height,
    //     child: Column(
    //       children: [
    //         Expanded(
    //           child: Scribble(
    //             notifier: scribbleNotifier,
    //             drawPen: true,
    //             drawEraser: false,
    //           ),
    //         ),
    //
    //         InkWell(
    //           onTap: () {
    //             saveImage();
    //           },
    //           child: Container(
    //             width: context.width,
    //             height: 80,
    //             color: Colors.transparent,
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
    return BlocBuilder<LayoutCubit, LayoutState>(
      builder: (context, state) {
        if (state is UserTypeNotManagerOrExcellencyOrEmployee) {
          return Scaffold(
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                IllustrationWidget(
                  type: IllustrationType.warning,
                  title: LocaleKeys.user_type_permission.tr(),
                  subtitle: LocaleKeys.user_type_permission_sup.tr(),
                ),
                const Spacer(),
                BaseButton(
                  width: context.width / 1.5,
                  isResponsive: false,
                  onTap: () {
                    context.showCustomBottomSheet(
                      BottomSheetWidget(
                        widget: AppImages.images.svg.warning.svg(
                          height: 80.toH(context),
                        ),
                        isError: true,
                        title: LocaleKeys.logout.tr(),
                        subtitle: LocaleKeys.logout_subtitle.tr(),
                        confirm: LocaleKeys.confirm.tr(),
                        cancel: LocaleKeys.cancel.tr(),
                        onConfirm: () async {
                          await context.read<FetchTransactionsCubit>().clear();
                          // ignore: use_build_context_synchronously
                          await context.read<GetBoxCountCubit>().clear();
                          // ignore: use_build_context_synchronously
                          context
                              .read<UserSettingsCubit>()
                              .deleteUserSettingsWhenLogOut();
                        },
                        onCancel: () {
                          Navigator.pop(context);
                        },
                      ),
                      isDismissible: false,
                    );
                  },
                  child: Center(
                    child: Text(
                      LocaleKeys.logout.tr(),
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: context.color.whiteColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                context.verticalSpace(context.viewPaddingBottom),
              ],
            ),
          );
        }
        return Scaffold(
          // key: scaffoldKey,
          drawer: const DrawerBoxes(),
          // bottomNavigationBar: BottomNavigationBarWidget(
          //   currentIndex: context.read<LayoutCubit>().currentPageIndex,
          // ),
          body:
              context.read<LayoutCubit>().screens[context
                  .read<LayoutCubit>()
                  .currentPageIndex],
        );
      },
    );
  }
}
