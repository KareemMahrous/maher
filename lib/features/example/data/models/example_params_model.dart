import '../../example.dart';

class ExampleParamsModel extends ExampleParamsEntity {
  const ExampleParamsModel({required super.name});

  factory ExampleParamsModel.fromParams(ExampleParamsEntity params) {
    return ExampleParamsModel(name: params.name);
  }

  Map<String, dynamic> toJson() {
    return {'name': name};
  }
}
