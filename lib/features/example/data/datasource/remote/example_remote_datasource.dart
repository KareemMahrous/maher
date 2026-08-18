import '../../../../../core/core.dart';
import '../../../example.dart';

abstract class ExampleRemoteDataSource {
  Future<ResponseHandler> fetchExamples();
  Future<ResponseHandler> fetchExampleDetails({required int id});
  Future<ResponseHandler> createExample({required ExampleParamsEntity input});
  Future<ResponseHandler> updateExample({required ExampleParamsEntity input});
  Future<ResponseHandler> deleteExample({required int id});
}
