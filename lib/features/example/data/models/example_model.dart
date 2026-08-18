import '../../example.dart';

class ExampleModel extends ExampleEntity {
  const ExampleModel({required super.id});

  factory ExampleModel.fromJson(Map<String, dynamic> json) {
    return ExampleModel(id: json['id'] as int);
  }
}
