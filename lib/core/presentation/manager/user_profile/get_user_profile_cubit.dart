import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core.dart';
import '../../../data/models/user_data_model/user_profile_model.dart';
import '../../../domain/use_cases/get_user_profile_use_case.dart';
import '../../../utils/constants/db_keys/db_keys.dart';

part 'user_profile_state.dart';

class GetUserProfileCubit extends Cubit<UserProfileState> {
  final GetUserProfileUseCase _getUserProfileUseCase;
  GetUserProfileCubit(this._getUserProfileUseCase)
    : super(UserProfileInitial());
  UserProfileModel? userProfileModel;

  //  String getUserRank()   {
  //   final String userRank =   SharedPref.getString(LocalDbKeys.userRank);
  //   return userRank;
  // }

  Future<void> getUserProfile() async {
    emit(UserProfileLoadingState());
    final result = await _getUserProfileUseCase.call(NoParams());
    result.fold((l) => emit(UserProfileErrorState()), (r) async {
      userProfileModel = r;
      await SharedPref.setString(LocalDbKeys.userRank, r.rankName);
      emit(UserProfileLoadedState());
    });
  }
}
