import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../../features/home_feature/presentation/manager/builders/home_data_builder.dart';
import '../../../../injection/injection.dart';
import '../../../core.dart';
import '../../../data/models/user_data_model/user_data_model.dart';
import '../../../data/models/user_departments_model/user_departments_model.dart';
import '../../../domain/use_cases/user_data_use_case.dart';
import '../../../domain/use_cases/user_departments_use_case.dart';
import '../../../domain/use_cases/user_logout_use_case.dart';
import '../../../domain/use_cases/user_select_department.dart';
import '../../../domain/use_cases/user_token_use_case.dart';
import '../../../domain/use_cases/user_type_use_case.dart';
import '../../../utils/constants/db_keys/db_keys.dart';
import '../delegation_mode/delegation_mode_cubit.dart';

part 'user_settings_state.dart';

class UserSettingsCubit extends Cubit<UserSettingsState> {
  UserSettingsCubit({
    required GetUserDataUseCase getUserDataUseCase,
    required UserSelectedDepartmentUseCase userSelectedDepartmentUseCase,
    required GetUserTokenUseCase getUserTokenUseCase,
    required GetUserDepartmentsUseCase getUserDepartmentsUseCase,
    required UserLogoutUseCase userLogoutUseCase,
    required GetUserTypeUseCase getUserTypeUseCase,
  }) : _getUserDataUseCase = getUserDataUseCase,
       _userSelectedDepartmentUseCase = userSelectedDepartmentUseCase,
       _getUserTokenUseCase = getUserTokenUseCase,
       _getUserDepartmentsUseCase = getUserDepartmentsUseCase,
       _userLogoutUseCase = userLogoutUseCase,
       _getUserTypeUseCase = getUserTypeUseCase,
       super(UserSettingsStateInitial());

  final GetUserDataUseCase _getUserDataUseCase;
  final GetUserDepartmentsUseCase _getUserDepartmentsUseCase;
  final GetUserTokenUseCase _getUserTokenUseCase;
  final UserSelectedDepartmentUseCase _userSelectedDepartmentUseCase;
  final UserLogoutUseCase _userLogoutUseCase;
  final GetUserTypeUseCase _getUserTypeUseCase;
  final secureStorage = InjectionContainer.locator<FlutterSecureStorage>();

  String? userToken;
  UserDataModel? userData;
  List<UserDepartmentsModel>? userDepartmentsList;
  UserDepartmentsModel? userSelectedDepartment;
  UserRole? userType;

  Future<void> getUserSettings() async {
    emit(UserSettingsStateLoading());

    userToken = await _getUserTokenUseCase.call();
    if (userToken == null) {
      emit(UserSettingsStateInitial()); // or an error state if desired
      return;
    }

    userType = await _getUserTypeUseCase.call();

    userData = await _getUserDataUseCase.call();
    userDepartmentsList = await _getUserDepartmentsUseCase.call();
    userSelectedDepartment = await _userSelectedDepartmentUseCase.call();

    emit(UserSettingsStateChangeValues());
  }

  /// Silent update after token refresh — no loading UI flicker.
  Future<void> applyRefreshedSession(String accessToken) async {
    userToken = accessToken;
    userType = await _getUserTypeUseCase.call();
    userData = await _getUserDataUseCase.call();
    userDepartmentsList = await _getUserDepartmentsUseCase.call();
    emit(UserSettingsStateChangeValues());
  }

  void overrideDepartments(List<UserDepartmentsModel> departments) {
    userDepartmentsList = departments;
    if (departments.isNotEmpty) {
      userSelectedDepartment = departments.first;
    }
    emit(UserSettingsStateDump());
    emit(UserSettingsStateChangeValues());
  }

  void overrideSelectedDepartment(UserDepartmentsModel selectedDepartment) async{
    userSelectedDepartment = selectedDepartment;
    userSelectedDepartment = await _userSelectedDepartmentUseCase.call(selectedDepartment:selectedDepartment);
    emit(UserSettingsStateChangeValues());
  }

  Future<void> restoreDepartmentsFromToken() async {
    userDepartmentsList = await _getUserDepartmentsUseCase.call();
    if (userDepartmentsList != null && userDepartmentsList!.isNotEmpty) {
      userSelectedDepartment = await _userSelectedDepartmentUseCase.call(
        selectedDepartment: userDepartmentsList!.first,
      );
    } else {
      userSelectedDepartment = await _userSelectedDepartmentUseCase.call();
    }
    emit(UserSettingsStateDump());
    emit(UserSettingsStateChangeValues());
  }

  Future<void> changeSelectedDepartment(
    UserDepartmentsModel? selectedDepartment,
  ) async {
    emit(UserSettingsStateLoading());

    userSelectedDepartment = await _userSelectedDepartmentUseCase.call(
      selectedDepartment: selectedDepartment,
    );

    emit(UserSettingsStateChangeValues());
  }

  Future<void> deleteUserSettingsWhenLogOut() async {
    emit(UserSettingsStateLoading());
    final result = await _userLogoutUseCase.call(NoParams());
    if (kDebugMode) {
      log('userLogout');
      log(result.toString());
    }
    await secureStorage.delete(key: LocalDbKeys.departmentName);
    await secureStorage.delete(key: LocalDbKeys.departmentIsActive);
    await secureStorage.delete(key: LocalDbKeys.departmentId);
    await secureStorage.delete(key: LocalDbKeys.userToken);
    await secureStorage.delete(key: LocalDbKeys.userRefreshToken);
    await secureStorage.delete(key: LocalDbKeys.userRefreshTokenExpiration);
    await secureStorage.delete(key: LocalDbKeys.userType);
    await secureStorage.delete(key: LocalDbKeys.userPassword);
    await secureStorage.delete(key: LocalDbKeys.userName);
    await secureStorage.delete(key: LocalDbKeys.userId);
    InjectionContainer.locator<DelegationModeCubit>().exit();
    HomeDataBuilder.instance.clear();
    userToken = null;
    userData = null;
    userDepartmentsList = null;
    userSelectedDepartment = null;
    emit(UserSettingsStateRemoveAllValues());
  }
}
