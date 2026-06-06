import 'package:attendance_app/core/location/location_service.dart';
import 'package:attendance_app/features/dashboard/data/models/attendance_status_model.dart';
import 'package:attendance_app/features/dashboard/data/provider/attendance_mark_provider.dart';
import 'package:attendance_app/features/dashboard/data/provider/attendance_provider.dart';
import 'package:attendance_app/features/dashboard/view/widget/attendance_status_card_widget.dart';
import 'package:attendance_app/features/dashboard/view/widget/dashboard_menu_card_widget.dart';
import 'package:attendance_app/features/dashboard/view/widget/profile_section_widget.dart';
import 'package:attendance_app/features/dashboard/view/widget/recent_ativity_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  AttendanceStatus status = AttendanceStatus.markIn;
  String locationName = "Loading...";

  Future<void> getLocationName() async {
    try {
      final position = await LocationService().getCurrentLocation();

      final placeName = await LocationService().getPlaceName(
        position.latitude,
        position.longitude,
      );

      if (mounted) {
        setState(() {
          locationName = placeName;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          locationName = "Unknown";
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<AttendanceProvider>().fetchAttendanceStatus();
    });

    getLocationName();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffEEF2F1),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              ProfileSection(location: locationName),

              const SizedBox(height: 20),

              Consumer<AttendanceProvider>(
                builder: (context, provider, child) {
                  final attendance =
                      provider.attendanceStatusResponse?.attendance;

                  return AttendanceStatusCard(
                    attendanceStatus:
                        attendance?.attendanceStatus ?? 'not_marked_in',
                    shiftStartTime: attendance?.shiftStartTime ?? '--:--',

                    onMarkIn: () async {
                      final position = await LocationService()
                          .getCurrentLocation();
                      print("LAT : ${position.latitude}");

                      print("LNG : ${position.longitude}");
                      final success = await context
                          .read<AttendanceMarkProvider>()
                          .markAttendance(
                            attendanceStatus: 1,
                            latitude: position.latitude.toString(),
                            longitude: position.longitude.toString(),
                          );

                      if (success) {
                        await context
                            .read<AttendanceProvider>()
                            .fetchAttendanceStatus();
                      }
                    },

                    onMarkOut: () async {
                      final position = await LocationService()
                          .getCurrentLocation();

                      final success = await context
                          .read<AttendanceMarkProvider>()
                          .markAttendance(
                            attendanceStatus: 2,
                            latitude: position.latitude.toString(),
                            longitude: position.longitude.toString(),
                          );

                      if (success) {
                        await context
                            .read<AttendanceProvider>()
                            .fetchAttendanceStatus();
                      }
                    },
                  );
                },
              ),
              const SizedBox(height: 20),

              Row(
                children: [
                  DashboardMenuCard(
                    title: "Route",
                    imagePath: "assets/icons/route_icon.png",
                    iconSize: 22,
                    isPrimary: true,
                    onTap: () {
                      context.pushNamed('routelist');
                    },
                  ),

                  const SizedBox(width: 16),

                  DashboardMenuCard(
                    title: "Apply Leave",
                    imagePath: "assets/icons/calendar.png",
                    iconSize: 25,
                    onTap: () {
                      context.pushNamed('applyleave');
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),

              Row(
                children: [
                  const Text(
                    "Recent Activity",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),

                  const Spacer(),

                  TextButton(onPressed: () {}, child: const Text("View All")),
                ],
              ),

              Expanded(
                child: Consumer<AttendanceProvider>(
                  builder: (context, provider, child) {
                    if (provider.isLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    final attendance =
                        provider.attendanceStatusResponse?.attendance;

                    if (attendance == null) {
                      return const Center(child: Text('No attendance data'));
                    }

                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          RecentActivityCard(
                            date: DateFormat(
                              'dd MMM yyyy',
                            ).format(DateTime.now()),
                            markInTime: attendance.markInTime ?? 'Not Marked',
                            markOutTime: attendance.markOutTime ?? 'Not Marked',
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
