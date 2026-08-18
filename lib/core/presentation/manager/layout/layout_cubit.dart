import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../features/home_feature/presentation/pages/home_view.dart';
import '../../../../features/profile/presentation/pages/profile_view.dart';
import '../../../domain/use_cases/user_type_use_case.dart';

part 'package:arch/core/presentation/manager/layout/layout_states.dart';

class LayoutCubit extends Cubit<LayoutState> {
  LayoutCubit(this._getUserTypeUseCase) : super(LayoutInitial());

  int currentPageIndex = 0;
  final GetUserTypeUseCase _getUserTypeUseCase;

  checkUserRole() async {
    emit(LayoutInitial());
    final UserRole userRole = await _getUserTypeUseCase.call();
    if (userRole == UserRole.non) {
      emit(UserTypeNotManagerOrExcellencyOrEmployee());
    }
  }

  List<Widget> screens = [
    const HomeView(),
    const SizedBox(),
    const SizedBox(),
    const ProfileView(),
  ];

  changePageIndex(int pageIndex) {
    if (currentPageIndex == pageIndex) {
      return;
    }
    emit(LayoutInitial());
    currentPageIndex = pageIndex;
    emit(LayoutChangeScreenIndex());
  }
}
