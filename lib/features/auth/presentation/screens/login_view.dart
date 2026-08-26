import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/routes/app_router.dart';
import '../../../../core/core.dart';
import '../../data/data.dart';
import '../../domain/domain.dart';
import '../cubit/cubit.dart';
import '../services/google_auth_service.dart';
import '../widget/widget.dart';

@RoutePage()
class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginByGoogleCubit(
        googleAuthService: GoogleAuthService(),
        loginByGoogleUseCase: LoginByGoogleUseCase(
          authRepo: AuthRepoImpl(
            remoteDataSource: AuthRemoteDataSourceImpl(
              networkService: DioService(baseDio: BaseDio()),
            ),
          ),
        ),
      ),
      child: BlocListener<LoginByGoogleCubit, LoginByGoogleState>(
        listener: (context, state) {
          if (state is LoginByGoogleSuccess) {
            context.router.replace(const RecordMeetingViewRoute());
          }

          if (state is LoginByGoogleError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.messageKey.tr()),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: Scaffold(
          appBar: AppBar(title: Text('auth.login.title'.tr())),
          body: const Center(child: LoginWithGoogle()),
        ),
      ),
    );
  }
}
