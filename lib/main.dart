import 'package:attendance_app/core/network/dio_client.dart';
import 'package:attendance_app/core/routes/app_routes.dart';
import 'package:attendance_app/features/dashboard/data/provider/attendance_mark_provider.dart';
import 'package:attendance_app/features/dashboard/data/provider/attendance_provider.dart';
import 'package:attendance_app/features/leave/data/provider/apply_leave_rovider.dart';
import 'package:attendance_app/features/leave_list/data/provider/leave_list_provider.dart';
import 'package:attendance_app/features/login/data/provider/login_provider.dart';

import 'package:attendance_app/features/registration/data/provider/registration_provider.dart';
import 'package:attendance_app/features/registration/data/data_sources/registration_api_service.dart';
import 'package:attendance_app/features/registration/data/repository/registration_repository.dart';
import 'package:attendance_app/features/route/data/provider/route_provider.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => RegistrationProvider(
            RegistrationRepository(RegistrationApiService(DioClient().dio)),
          ),
        ),

        ChangeNotifierProvider(create: (_) => LoginProvider()),
        ChangeNotifierProvider(create: (_) => AttendanceProvider()),
        ChangeNotifierProvider(create: (_) => AttendanceMarkProvider()),
        ChangeNotifierProvider(create: (_) => ApplyLeaveProvider()),
        ChangeNotifierProvider(create: (_) => LeaveListProvider()),
        ChangeNotifierProvider(create: (_) => RouteProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: AppRoutes.router,
    );
  }
}
