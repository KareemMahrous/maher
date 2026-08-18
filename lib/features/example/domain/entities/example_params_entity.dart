import 'package:equatable/equatable.dart';

class ExampleParamsEntity with Equatable {
  const ExampleParamsEntity({required this.name});

  final String name;

  @override
  List<Object?> get props => [name];
}
