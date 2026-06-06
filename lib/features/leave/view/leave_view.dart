import 'package:attendance_app/core/local_storage/storage_service.dart';
import 'package:attendance_app/features/leave/data/provider/apply_leave_rovider.dart';
import 'package:attendance_app/features/leave/view/widget/leave_action_button_widget.dart';
import 'package:attendance_app/features/leave/view/widget/leave_mode_toggle.dart';
import 'package:attendance_app/features/leave/view/widget/leave_reason_field_widget.dart';
import 'package:attendance_app/features/leave/view/widget/leave_textfield_widget.dart';
import 'package:attendance_app/features/leave/view/widget/leave_type_drop_down_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ApplyLeaveView extends StatefulWidget {
  const ApplyLeaveView({super.key});

  @override
  State<ApplyLeaveView> createState() => _ApplyLeaveViewState();
}

class _ApplyLeaveViewState extends State<ApplyLeaveView> {
  bool isFullDay = true;

  final TextEditingController fromController = TextEditingController();

  final TextEditingController toController = TextEditingController();

  final TextEditingController reasonController = TextEditingController();

  String? selectedLeaveType;

  @override
  void dispose() {
    fromController.dispose();
    toController.dispose();
    reasonController.dispose();
    super.dispose();
  }

  Future<void> _applyLeave() async {
    if (fromController.text.trim().isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please enter start date')));
      return;
    }

    if (toController.text.trim().isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please enter end date')));
      return;
    }

    if (reasonController.text.trim().isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please enter reason')));
      return;
    }

    if (selectedLeaveType == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please select leave type')));
      return;
    }
    final userId = await StorageService().getUserId();

    if (userId == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('User not found')));
      return;
    }

    final provider = context.read<ApplyLeaveProvider>();

    final success = await provider.applyLeave(
      leaveMode: isFullDay ? 'full_day' : 'half_day',

      leaveType: selectedLeaveType!.toLowerCase().replaceAll(' ', '_'),

      startDate: fromController.text.trim(),

      endDate: toController.text.trim(),

      reason: reasonController.text.trim(),

      userId: userId,
    );

    if (!mounted) return;

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            provider.applyLeaveResponse?.message ??
                'Leave applied successfully',
          ),
        ),
      );

      fromController.clear();
      toController.clear();
      reasonController.clear();

      setState(() {
        selectedLeaveType = null;
        isFullDay = true;
      });
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Failed to apply leave')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffEEF2F1),

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

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Apply Leave",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
              ),

              const SizedBox(height: 20),

              LeaveModeToggle(
                isFullDay: isFullDay,
                onChanged: (value) {
                  setState(() {
                    isFullDay = value;
                  });
                },
              ),

              const SizedBox(height: 20),

              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Column(
                  children: [
                    LeaveTextField(
                      label: "From",
                      hintText: "DD/MM/YYYY",
                      controller: fromController,
                      suffixIcon: const Icon(Icons.calendar_month),
                    ),

                    const SizedBox(height: 16),

                    LeaveTextField(
                      label: "To",
                      hintText: "DD/MM/YYYY",
                      controller: toController,
                      suffixIcon: const Icon(Icons.calendar_month),
                    ),

                    const SizedBox(height: 16),

                    LeaveReasonField(controller: reasonController),

                    const SizedBox(height: 16),

                    LeaveDropdownField(
                      value: selectedLeaveType,
                      items: const [
                        'Casual Leave',
                        'Sick Leave',
                        'Annual Leave',
                      ],
                      onChanged: (value) {
                        setState(() {
                          selectedLeaveType = value;
                        });
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              Consumer<ApplyLeaveProvider>(
                builder: (context, provider, child) {
                  return LeaveActionButtons(
                    onApply: provider.isLoading ? () {} : _applyLeave,
                    onLeaveList: () {
                      context.pushNamed('leavelist');
                    },
                  );
                },
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
