import 'package:attendance_app/core/network/api_constants.dart';
import 'package:attendance_app/core/network/dio_client.dart';
import 'package:attendance_app/features/route/data/model/route_list_response_model.dart';



class RouteApiService {
  final DioClient _dioClient = DioClient();

  Future<RouteListResponse> getRoutes() async {
    final response = await _dioClient.dio.get(
      ApiConstants.routeList,
    );

    return RouteListResponse.fromJson(
      response.data,
    );
  }
}