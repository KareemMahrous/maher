import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../services/shared_prefrences/shared_prefrences.dart';
import '../../../utils/constants/db_keys/db_keys.dart';
import 'delegation_mode_state.dart';

class DelegationModeCubit extends Cubit<DelegationModeState> {
  DelegationModeCubit() : super(const DelegationModeState.inactive());

  void load() {
    final isActive =
        SharedPref.getBoolean(LocalDbKeys.isUserInDelegationMode) ?? false;
    if (isActive) {
      emit(DelegationModeState(
        isActive: true,
        delegatorName:
            SharedPref.getString(LocalDbKeys.delegationModeDelegatorName) ?? '',
        delegationTo:
            SharedPref.getString(LocalDbKeys.delegationModeDelegationTo) ?? '',
      ));
    }
  }

  void enter({
    required String delegatorName,
    required String delegationTo,
    required String delegationId,
    required String delegationUserId,   // authorizedID (the logged-in user)
    required String delegatorId,        // delegatorID (the one who delegated)
  }) {
    SharedPref.setBoolean(
      key: LocalDbKeys.isUserInDelegationMode,
      value: true,
    );
    SharedPref.setString(LocalDbKeys.delegationModeDelegatorName, delegatorName);
    SharedPref.setString(LocalDbKeys.delegationModeDelegationTo, delegationTo);
    SharedPref.setString(LocalDbKeys.delegationModeId, delegationId);
    SharedPref.setString(LocalDbKeys.delegationModeUserId, delegationUserId);
    SharedPref.setString(LocalDbKeys.delegationModeDelegatorId, delegatorId);

    emit(DelegationModeState(
      isActive: true,
      delegatorName: delegatorName,
      delegationTo: delegationTo,
    ));
  }

  void exit() {
    SharedPref.setBoolean(
      key: LocalDbKeys.isUserInDelegationMode,
      value: false,
    );
    SharedPref.removePreference(LocalDbKeys.delegationModeDelegatorName);
    SharedPref.removePreference(LocalDbKeys.delegationModeDelegationTo);
    SharedPref.removePreference(LocalDbKeys.delegationModeId);
    SharedPref.removePreference(LocalDbKeys.delegationModeUserId);
    SharedPref.removePreference(LocalDbKeys.delegationModeDelegatorId);

    emit(const DelegationModeState.inactive());
  }
}
