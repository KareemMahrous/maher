part of 'user_settings_cubit.dart';

sealed class UserSettingsState extends Equatable {}

final class UserSettingsStateInitial extends UserSettingsState {
  @override
  List<Object> get props => [];
}

final class UserSettingsStateLoading extends UserSettingsState {
  @override
  List<Object> get props => [];
}

final class UserSettingsStateChangeValues extends UserSettingsState {
  @override
  List<Object> get props => [];
}

final class UserSettingsStateRemoveAllValues extends UserSettingsState {
  @override
  List<Object> get props => [];
}

final class UserSettingsStateDump extends UserSettingsState {
  @override
  List<Object> get props => [];
}

