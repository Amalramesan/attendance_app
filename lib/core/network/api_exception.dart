import 'package:dio/dio.dart';

class ApiException implements Exception {
  final String message;
  ApiException(this.message);

  factory ApiException.fromDioException(DioException e) {
    String message = "Something went wrong";
    if (e.response != null) {
      final data = e.response!.data;
      if (data is Map) {
        if (data.containsKey('message') && data['message'] != null) {
          message = data['message'].toString();
        } else if (data.containsKey('error') && data['error'] != null) {
          message = data['error'].toString();
        } else if (data.containsKey('errors') && data['errors'] != null) {
          final errors = data['errors'];
          if (errors is Map) {
            final buffer = StringBuffer();
            for (var entry in errors.entries) {
              final val = entry.value;
              if (val is List) {
                buffer.write("${val.join(', ')}\n");
              } else {
                buffer.write("${val.toString()}\n");
              }
            }
            if (buffer.isNotEmpty) {
              message = buffer.toString().trim();
            }
          } else {
            message = errors.toString();
          }
        }
      } else if (data is String && data.isNotEmpty) {
        message = data;
      }
    } else {
      switch (e.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          message = "Connection timed out. Please check your internet connection.";
          break;
        case DioExceptionType.connectionError:
          message = "No internet connection. Please check your network.";
          break;
        case DioExceptionType.cancel:
          message = "Request was cancelled.";
          break;
        default:
          message = "Network error occurred. Please try again.";
      }
    }
    return ApiException(message);
  }

  @override
  String toString() => message;
}
