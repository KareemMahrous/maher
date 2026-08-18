import 'package:equatable/equatable.dart';

abstract class ManageExampleState extends Equatable {
  const ManageExampleState();

  @override
  List<Object> get props => [];
}

class ManageExampleInitial extends ManageExampleState {}

class ManageExampleLoading extends ManageExampleState {}

class ManageExampleSuccess extends ManageExampleState {}

class ManageExampleFailure extends ManageExampleState {
  final String message;

  const ManageExampleFailure({required this.message});

  @override
  List<Object> get props => [message];
}
