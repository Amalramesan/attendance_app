import 'package:attendance_app/core/network/api_exception.dart';
import 'package:attendance_app/features/route/data/datasource/route_list_api_service.dart';
import 'package:attendance_app/features/route/data/model/route_list_response_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';


class RouteProvider extends ChangeNotifier {
  final RouteApiService _apiService =
      RouteApiService();

  bool isLoading = false;
  String? errorMessage;

  RouteListResponse? routeResponse;

  Future<void> fetchRoutes() async {
    try {
      isLoading = true;
      errorMessage = null;
      notifyListeners();

      routeResponse =
          await _apiService.getRoutes();
    } catch (e) {
      if (e is DioException) {
        errorMessage = ApiException.fromDioException(e).message;
      } else {
        errorMessage = e.toString().replaceAll('Exception: ', '');
      }
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}