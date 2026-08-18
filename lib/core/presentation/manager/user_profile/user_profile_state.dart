part of 'get_user_profile_cubit.dart';

sealed class UserProfileState extends Equatable {
  const UserProfileState();

  @override
  List<Object> get props => [];
}

final class UserProfileInitial extends UserProfileState {}

final class UserProfileLoadingState extends UserProfileState {}

final class UserProfileErrorState extends UserProfileState {}

final class UserProfileLoadedState extends UserProfileState {}
