part of 'show_loading_cubit.dart';

sealed class ShowLoadingState extends Equatable {
  const ShowLoadingState();

  @override
  List<Object> get props => [];
}

final class ShowLoadingInitial extends ShowLoadingState {}

final class ShowLoadingLoadingState extends ShowLoadingState {}

final class ShowLoadingErrorState extends ShowLoadingState {}

final class ShowLoadingLoadedState extends ShowLoadingState {}
