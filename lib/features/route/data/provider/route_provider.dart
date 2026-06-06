import 'package:attendance_app/features/route/data/datasource/route_list_api_service.dart';
import 'package:attendance_app/features/route/data/model/route_list_response_model.dart';
import 'package:flutter/material.dart';



class RouteProvider extends ChangeNotifier {
  final RouteApiService _apiService =
      RouteApiService();

  bool isLoading = false;

  RouteListResponse? routeResponse;

  Future<void> fetchRoutes() async {
    try {
      isLoading = true;
      notifyListeners();

      routeResponse =
          await _apiService.getRoutes();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}