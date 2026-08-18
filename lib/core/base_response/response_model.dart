import 'package:equatable/equatable.dart';

class ResponseModel with Equatable {
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

class ResponseHandler extends Equatable {
  const ResponseHandler({
    required this.success,
    this.message = '',
    this.data,
    this.error,
    this.statusCode,
  });

  final bool success;
  final String message;
  final dynamic data;
  final dynamic error;
  final int? statusCode;

  factory ResponseHandler.fromJson(Map<String, dynamic> json) {
    final statusCode = json['statusCode'] ?? json['httpStatusCode'];
    return ResponseHandler(
      success:
          json['success'] as bool? ??
          json['isSuccess'] as bool? ??
          ((statusCode as int?) ?? 200) < 400,
      message: json['message'] as String? ?? '',
      data: json['data'],
      error: json['error'],
      statusCode: statusCode as int?,
    );
  }

  @override
  List<Object?> get props => [success, message, data, error, statusCode];
}
