import 'package:equatable/equatable.dart';

class ExampleEntity with Equatable {
  const ExampleEntity({required this.id});

  final int id;

  @override
  List<Object?> get props => [id];
}
