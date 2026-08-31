import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../cubit/cubit.dart';

class LoginWithMicrosoft extends StatelessWidget {
  const LoginWithMicrosoft({super.key});

  static const _brandColor = Color(0xFF0F2D5F);
  static const _buttonColor = Color(0xFFF2F5FA);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginByGoogleCubit, LoginByGoogleState>(
      builder: (context, state) {
        final isLoading =
            state is LoginByGoogleLoading &&
            state.provider == LoginProvider.microsoft;
        final hasAnyLoading = state is LoginByGoogleLoading;

        return SizedBox(
          width: double.infinity,
          height: 56,
          child: Material(
            color: hasAnyLoading
                ? _buttonColor.withValues(alpha: 0.7)
                : _buttonColor,
            borderRadius: BorderRadius.circular(8),
            child: InkWell(
              borderRadius: BorderRadius.circular(8),
              onTap: hasAnyLoading
                  ? null
                  : context.read<LoginByGoogleCubit>().loginByMicrosoft,
              child: Padding(
                padding: const EdgeInsetsDirectional.only(start: 22, end: 19),
                child: Row(
                  children: [
                    isLoading
                        ? const SizedBox.square(
                            dimension: 24,
                            child: CircularProgressIndicator(strokeWidth: 2.4),
                          )
                        : const _MicrosoftMark(),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'auth.login.microsoftButton'.tr(),
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

class _MicrosoftMark extends StatelessWidget {
  const _MicrosoftMark();

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset('assets/auth/microsoft.svg', width: 32, height: 32);
  }
}
