import 'package:attendance_app/core/common_widgets/snackbar.dart';
import 'package:attendance_app/core/local_storage/storage_service.dart';
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

    final attendanceProvider = context.read<AttendanceProvider>();
    Future.microtask(() async {
      await attendanceProvider.fetchAttendanceStatus();
      if (!mounted) return;
      final error = attendanceProvider.errorMessage;
      if (error != null) {
        AppSnackbar.showError(context, error);
      }
    });

    getLocationName();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffEEF2F1),
      appBar: AppBar(
        backgroundColor: const Color(0xffEEF2F1),
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Text(
          'Dashboard',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.black),
            onPressed: () async {
              await StorageService().clearAll();

              if (!context.mounted) return;

              AppSnackbar.showSuccess(context, 'Logged out successfully');

              context.goNamed('login');
            },
          ),
        ],
      ),
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
                      try {
                        final position = await LocationService()
                            .getCurrentLocation();
                        if (!context.mounted) return;
                        final markProvider = context
                            .read<AttendanceMarkProvider>();
                        final success = await markProvider.markAttendance(
                          attendanceStatus: 1,
                          latitude: position.latitude.toString(),
                          longitude: position.longitude.toString(),
                        );

                        if (!context.mounted) return;

                        if (success &&
                            markProvider.attendanceMarkResponse?.status ==
                                true) {
                          AppSnackbar.showSuccess(
                            context,
                            markProvider.attendanceMarkResponse?.message ??
                                'Mark In successful',
                          );
                          if (!context.mounted) return;
                          await context
                              .read<AttendanceProvider>()
                              .fetchAttendanceStatus();
                        } else {
                          AppSnackbar.showError(
                            context,
                            markProvider.errorMessage ??
                                markProvider.attendanceMarkResponse?.message ??
                                'Failed to Mark In',
                          );
                        }
                      } catch (e) {
                        if (!context.mounted) return;
                        AppSnackbar.showError(
                          context,
                          e.toString().replaceAll('Exception: ', ''),
                        );
                      }
                    },

                    onMarkOut: () async {
                      try {
                        final position = await LocationService()
                            .getCurrentLocation();
                        if (!context.mounted) return;
                        final markProvider = context
                            .read<AttendanceMarkProvider>();
                        final success = await markProvider.markAttendance(
                          attendanceStatus: 2,
                          latitude: position.latitude.toString(),
                          longitude: position.longitude.toString(),
                        );

                        if (!context.mounted) return;

                        if (success &&
                            markProvider.attendanceMarkResponse?.status ==
                                true) {
                          AppSnackbar.showSuccess(
                            context,
                            markProvider.attendanceMarkResponse?.message ??
                                'Mark Out successful',
                          );
                          if (!context.mounted) return;
                          await context
                              .read<AttendanceProvider>()
                              .fetchAttendanceStatus();
                        } else {
                          AppSnackbar.showError(
                            context,
                            markProvider.errorMessage ??
                                markProvider.attendanceMarkResponse?.message ??
                                'Failed to Mark Out',
                          );
                        }
                      } catch (e) {
                        if (!context.mounted) return;
                        AppSnackbar.showError(
                          context,
                          e.toString().replaceAll('Exception: ', ''),
                        );
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
