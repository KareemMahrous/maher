part of 'get_box_priority_count_cubit.dart';

sealed class GetBoxPriorityCountState extends Equatable {}

final class GetBoxPriorityCountInitial extends GetBoxPriorityCountState {
  @override
  List<Object> get props => [];
}

final class GetBoxPriorityCountLoading extends GetBoxPriorityCountState {
  @override
  List<Object> get props => [];
}

final class GetBoxPriorityCountDump extends GetBoxPriorityCountState {
  @override
  List<Object> get props => [];
}

final class GetBoxPriorityCountSuccess extends GetBoxPriorityCountState {
  final List<BoxPriorityCountEntity>? data;
  final int? selectedPriorityCode;
  GetBoxPriorityCountSuccess({this.data, this.selectedPriorityCode});

  // copy with method
  GetBoxPriorityCountSuccess copyWith({
    List<BoxPriorityCountEntity>? data,
    int? selectedPriorityCode,
  }) {
    return GetBoxPriorityCountSuccess(
      data: data ?? this.data,
      selectedPriorityCode: selectedPriorityCode ?? this.selectedPriorityCode,
    );
  }

  @override
  List<Object> get props => [];
}

final class GetBoxPriorityCountFailed extends GetBoxPriorityCountState {
  final Failure failure;

  GetBoxPriorityCountFailed(this.failure);

  @override
  List<Object> get props => [failure];
}
