part of 'get_box_count_cubit.dart';

sealed class GetBoxCountState extends Equatable {}

final class GetBoxCountInitial extends GetBoxCountState {
  @override
  List<Object> get props => [];
}

final class GetBoxCountLoading extends GetBoxCountState {
  @override
  List<Object> get props => [];
}


final class GetBoxCountDump extends GetBoxCountState {
  @override
  List<Object> get props => [];
}


final class GetBoxCountSuccess extends GetBoxCountState {

  @override
  List<Object> get props => [];
}

final class GetBoxCountFailed extends GetBoxCountState {
  final Failure failure;

  GetBoxCountFailed(this.failure);

  @override
  List<Object> get props => [failure];
}
