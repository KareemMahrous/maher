import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/cubit.dart';

class LoginWithGoogle extends StatelessWidget {
  const LoginWithGoogle({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginByGoogleCubit, LoginByGoogleState>(
      builder: (context, state) {
        final isLoading = state is LoginByGoogleLoading;

        return FilledButton.icon(
          onPressed: isLoading
              ? null
              : context.read<LoginByGoogleCubit>().loginByGoogle,
          icon: isLoading
              ? const SizedBox.square(
                  dimension: 18,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Text('G', style: TextStyle(fontWeight: FontWeight.w700)),
          label: Text('auth.login.googleButton'.tr()),
        );
      },
    );
  }
}
