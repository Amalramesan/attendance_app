import 'package:dio/dio.dart';
import '../local_storage/storage_service.dart';
import 'api_constants.dart';

class DioClient {
  static final DioClient _instance = DioClient._internal();
  late final Dio dio;

  factory DioClient() {
    return _instance;
  }

  DioClient._internal() {
    dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        headers: {
          'Content-Type': 'application/json',
        },
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token =
              await StorageService().getToken();

          if (token != null) {
            options.headers['Authorization'] =
                'Bearer $token';
          }

          handler.next(options);
        },

        onError: (error, handler) async {
          if (error.response?.statusCode == 401) {
            await StorageService().clearToken();

            // Later:
            // context.goNamed('login');
          }

          handler.next(error);
        },
      ),
    );

    // Optional logging
    dio.interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true,
      ),
    );
  }
}