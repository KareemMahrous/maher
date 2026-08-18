import 'package:equatable/equatable.dart';

class ExampleEntity with EquatableMixin {
  final int id;

  const ExampleEntity({required this.id});

  @override
  List<Object?> get props => [id];
}
