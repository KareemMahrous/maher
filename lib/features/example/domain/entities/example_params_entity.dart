import 'package:equatable/equatable.dart';

class ExampleParamsEntity with EquatableMixin {
  final String name;

  const ExampleParamsEntity({required this.name});

  @override
  List<Object?> get props => [name];
}
