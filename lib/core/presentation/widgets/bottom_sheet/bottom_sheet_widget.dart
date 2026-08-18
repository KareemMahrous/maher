import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core.dart';

class BottomSheetWidget extends StatelessWidget {
  const BottomSheetWidget({
    super.key,
    required this.widget,
    required this.title,
    required this.subtitle,
    this.onConfirm,
    this.onCancel,
    this.isError = false,
    required this.confirm,
    required this.cancel,
  });
  final Widget widget;
  final String title;
  final String subtitle;
  final String confirm;
  final String cancel;
  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;
  final bool isError;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          25.esh(),
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: context.color.fillColor,
            ),
            padding: const EdgeInsets.all(50),
            child: widget,
          ),
          SizedBox(height: 50.h),
          Text(
            title,
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10.h),
          Text(
            subtitle,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 50.h),
          BaseButton(
            height: 48,
            width: double.infinity,
            onTap: onConfirm,
            buttonColor:
                isError
                    ? context.color.currentTrans
                    : context.color.buttonNavigationBarSelectedColor,
            child: Center(
              child: Text(
                confirm,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: context.color.whiteColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(height: 10.h),
          BaseButton(
            height: 48,
            width: double.infinity,
            onTap: onCancel,
            buttonColor: Colors.transparent,
            borderColor:
            context.color.greyBorder,
            child: Center(
              child: Text(
                cancel,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
