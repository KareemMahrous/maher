import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/cubit.dart';

class LoginWithGoogle extends StatelessWidget {
  const LoginWithGoogle({super.key});

  static const _brandColor = Color(0xFF0F2D5F);
  static const _buttonColor = Color(0xFFF2F5FA);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginByGoogleCubit, LoginByGoogleState>(
      builder: (context, state) {
        final isLoading = state is LoginByGoogleLoading;

        return SizedBox(
          width: double.infinity,
          height: 56,
          child: Material(
            color: isLoading
                ? _buttonColor.withValues(alpha: 0.7)
                : _buttonColor,
            borderRadius: BorderRadius.circular(8),
            child: InkWell(
              borderRadius: BorderRadius.circular(8),
              onTap: isLoading
                  ? null
                  : context.read<LoginByGoogleCubit>().loginByGoogle,
              child: Padding(
                padding: const EdgeInsetsDirectional.only(start: 22, end: 14),
                child: Row(
                  children: [
                    isLoading
                        ? const SizedBox.square(
                      dimension: 24,
                      child: CircularProgressIndicator(strokeWidth: 2.4),
                    )
                        : const _GoogleMark(),
                    const SizedBox(width: 8,),
                    Expanded(
                      child: Text(
                        'auth.login.googleButton'.tr(),
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                          color: _brandColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          height: 1.2,
                        ),
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _GoogleMark extends StatelessWidget {
  const _GoogleMark();

  @override
  Widget build(BuildContext context) {
    return const SizedBox.square(
      dimension: 28,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Text(
            'G',
            style: TextStyle(
              color: Color(0xFF4285F4),
              fontSize: 28,
              fontWeight: FontWeight.w900,
              height: 1,
            ),
          ),
          Positioned(
            right: 0,
            bottom: 7,
            child: DecoratedBox(
              decoration: BoxDecoration(color: Color(0xFF34A853)),
              child: SizedBox(width: 8, height: 4),
            ),
          ),
          Positioned(
            right: 1,
            top: 6,
            child: DecoratedBox(
              decoration: BoxDecoration(color: Color(0xFFEA4335)),
              child: SizedBox(width: 7, height: 4),
            ),
          ),
          Positioned(
            right: 2,
            bottom: 3,
            child: DecoratedBox(
              decoration: BoxDecoration(color: Color(0xFFFBBC05)),
              child: SizedBox(width: 5, height: 4),
            ),
          ),
        ],
      ),
    );
  }
}
