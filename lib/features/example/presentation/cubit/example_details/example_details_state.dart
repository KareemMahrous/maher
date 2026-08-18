part of 'example_details_cubit.dart';

abstract class ExampleDetailsState extends Equatable {
  const ExampleDetailsState();

  @override
  List<Object?> get props => [];
}

class ExampleDetailsInitial extends ExampleDetailsState {}

class ExampleDetailsLoading extends ExampleDetailsState {}

class ExampleDetailsSuccess extends ExampleDetailsState {
  final ExampleEntity data;

  const ExampleDetailsSuccess({required this.data});

  @override
  List<Object?> get props => [data];
}

class ExampleDetailsFailure extends ExampleDetailsState {
  final String message;

  const ExampleDetailsFailure({required this.message});

  @override
  List<Object?> get props => [message];
}
