import 'package:attendance_app/core/local_storage/storage_service.dart';
import 'package:attendance_app/core/theams/app_colors.dart';
import 'package:attendance_app/features/leave_list/data/provider/leave_list_provider.dart';
import 'package:attendance_app/features/leave_list/view/widgets/leave_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LeaveListView extends StatefulWidget {
  const LeaveListView({super.key});

  @override
  State<LeaveListView> createState() => _LeaveListViewState();
}

class _LeaveListViewState extends State<LeaveListView> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() async {
      final userId = await StorageService().getUserId();

      if (userId != null) {
        context.read<LeaveListProvider>().getLeaves(employeeId: userId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,

      appBar: AppBar(
        backgroundColor: const Color(0xffEEF2F1),
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.person, color: Color(0xff042222)),
            ),
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Leave List",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: Consumer<LeaveListProvider>(
                builder: (context, provider, child) {
                  if (provider.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final leaves = provider.response?.leaves ?? [];

                  if (leaves.isEmpty) {
                    return const Center(child: Text('No leave records found'));
                  }

                  return ListView.builder(
                    itemCount: leaves.length,
                    itemBuilder: (context, index) {
                      final leave = leaves[index];

                      return LeaveCard(
                        leaveMode: leave.leaveMode,
                        leaveType: leave.leaveType,
                        startDate: leave.startDate,
                        endDate: leave.endDate,
                        reason: leave.reason,
                        status: leave.status,
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
