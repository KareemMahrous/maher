part of 'examples_cubit.dart';

abstract class ExamplesState extends Equatable {
  const ExamplesState();

  @override
  List<Object?> get props => [];
}

class ExampleInitial extends ExamplesState {}

class ExampleLoading extends ExamplesState {}

class ExampleSuccess extends ExamplesState {
  final ExampleEntity data;

  const ExampleSuccess({required this.data});

  @override
  List<Object?> get props => [data];
}

class ExampleFailure extends ExamplesState {
  final String message;

  const ExampleFailure({required this.message});

  @override
  List<Object?> get props => [message];
}
