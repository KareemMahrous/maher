import 'package:equatable/equatable.dart';

class ResponseModel with EquatableMixin {
  final int? statusCode;
  final String? message;
  final dynamic data;
  final dynamic error;

  const ResponseModel({
    this.data,
    this.error,
    required this.statusCode,
    required this.message,
  });

  @override
  List<Object?> get props => [statusCode, message, data, error];

  factory ResponseModel.fromJson(Map<String, dynamic> json) => ResponseModel(
    data: json['data'],
    error: json['error'],
    statusCode: json['httpStatusCode'],
    message: json['message'] ?? "",
  );
}