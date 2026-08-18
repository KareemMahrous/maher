import '../../../../../core/core.dart';
import '../../../example.dart';

class ExampleRemoteDataSourceImpl implements ExampleRemoteDataSource {
  final BaseDio _baseDio;

  ExampleRemoteDataSourceImpl({required this._baseDio});

  @override
  Future<ResponseHandler> fetchExamples() async {
    final response = await _baseDio.get(EndPoints.examples);
    return ResponseHandler.fromJson(response.data);
  }

  @override
  Future<ResponseHandler> createExample({required ExampleParamsEntity input}) async {
    final inputData = ExampleParamsModel.fromParams(input);
    final response = await _baseDio.post(
      EndPoints.createExample,
      data: inputData.toJson(),
    );
    return ResponseHandler.fromJson(response.data);
  }

  @override
  Future<ResponseHandler> deleteExample({required int id}) async {
    final response = await _baseDio.delete(
    EndPoints.deleteExample,
    queryParameters: {'id': id},
    );
    return ResponseHandler.fromJson(response.data);
  }

  @override
  Future<ResponseHandler> updateExample({required ExampleParamsEntity input}) async {
    final inputData = ExampleParamsModel.fromParams(input);
    final response = await _baseDio.put(
      EndPoints.updateExample,
      data: inputData.toJson(),
      );
    return ResponseHandler.fromJson(response.data);
  }

  @override
  Future<ResponseHandler> fetchExampleDetails({required int id}) async {
    final response = await _baseDio.get(
      EndPoints.exampleDetails,
      queryParameters: {'id': id}
      );
    return ResponseHandler.fromJson(response.data);
  }

}
