import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../domain/entities/failure.dart';
import '../../../extensions/context.dart';
import '../../../helper/translations/locale_keys.g.dart';
import '../buttons/Basic/base_button.dart';
import '../text/custom_text_lib.dart';

class CustomErrorWidget extends StatelessWidget {
  final void Function() ?onPressed;
  final Failure? failure;

  const CustomErrorWidget({
    super.key,
    required this.failure,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    String? message;
    if (failure != null) {
      if (failure is ServerFailure) {
        message = (failure as ServerFailure).message;
      } else if (failure is NetworkFailure) {
        message =
            ((failure as NetworkFailure).connectionTimeOut)
                ? 'connectionTimeOut'
                : 'noInternetConnection';
      }
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: CustomText(
                message ?? '',
                textAlign: TextAlign.center,
                fontSize: 18,
                color: Colors.red,
                fontWeight: FW.medium,
              ),
            ),
          ),
          SizedBox(height: 10.h),
          SizedBox(
            width: 200.w,
            child: BaseButton(
              onTap: onPressed,
              child: Center(
                child: CustomText(
                  LocaleKeys.tryAgain.tr(),
                  color: context.color.whiteColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
