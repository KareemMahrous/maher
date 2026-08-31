import 'dart:ui' as ui;

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
        child: const Scaffold(body: _LoginBody()),
      ),
    );
  }
}

class _LoginBody extends StatelessWidget {
  const _LoginBody();

  static const _brandColor = Color(0xFF1A417F);
  static const _softBlue = Color(0xFF419CEB);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: ui.TextDirection.rtl,
      child: DecoratedBox(
        decoration: const BoxDecoration(color: Colors.white),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Stack(
              children: [
                const Positioned(top: -180, left: -150, child: _TopGlow()),
                PositionedDirectional(
                  bottom: 52,
                  start: 0,
                  child: IgnorePointer(
                    child: Opacity(
                      opacity: 0.48,
                      child: Image.asset(
                        'assets/auth/login_pattern.png',
                        width: 350,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                SafeArea(
                  child: SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight:
                            constraints.maxHeight -
                            MediaQuery.paddingOf(context).vertical,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 38),
                        child: Column(
                          children: [
                            SizedBox(
                              height: (constraints.maxHeight * 0.255).clamp(
                                150.0,
                                230.0,
                              ),
                            ),
                            const _MaherLogo(),
                            const SizedBox(height: 46),
                            const LoginWithGoogle(),
                            const SizedBox(height: 114),
                            const _CreateAccountText(),
                            const SizedBox(height: 270),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _TopGlow extends StatelessWidget {
  const _TopGlow();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 420,
      height: 420,
      decoration: const BoxDecoration(
        gradient: RadialGradient(
          colors: [Color(0x33419CEB), Color(0x14419CEB), Colors.transparent],
        ),
      ),
    );
  }
}

class _MaherLogo extends StatelessWidget {
  const _MaherLogo();

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/auth/login_logo.png',
      width: 250,
      fit: BoxFit.contain,
    );
  }
}

class _CreateAccountText extends StatelessWidget {
  const _CreateAccountText();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        context.router.replace(const RecordMeetingViewRoute());
      },
      child: Text.rich(
        TextSpan(
          text: '${'auth.login.noAccount'.tr()} ',
          style: const TextStyle(
            color: _LoginBody._brandColor,
            fontSize: 15,
            fontWeight: FontWeight.w400,
          ),
          children: [
            TextSpan(
              text: 'auth.login.createAccount'.tr(),
              style: const TextStyle(
                color: _LoginBody._softBlue,
                fontWeight: FontWeight.w700,
                decoration: TextDecoration.underline,
                decorationColor: _LoginBody._softBlue,
              ),
            ),
          ],
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
