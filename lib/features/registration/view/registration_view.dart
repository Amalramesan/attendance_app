import 'package:attendance_app/core/common_widgets/snackbar.dart';
import 'package:attendance_app/core/utils/validation.dart';
import 'package:attendance_app/features/registration/data/provider/registration_provider.dart';
import 'package:attendance_app/features/registration/view/widgets/custom_register_button.dart';
import 'package:attendance_app/features/registration/view/widgets/custom_register_textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterView extends StatelessWidget {
  RegisterView({super.key});

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();
  final dobController = TextEditingController();
  final mobileController = TextEditingController();
  final locationController = TextEditingController();
  final dojController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F6F6),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back_ios_new),
                  ),

                  const Expanded(
                    child: Text(
                      "Create Account",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),

                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xff083C3A)),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.person),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          RegisterTextField(
                            label: "First Name",
                            hintText: "Enter First Name",
                            controller: firstNameController,
                            validator: (value) =>
                                Validators.requiredField(value, "First Name"),
                          ),

                          const SizedBox(height: 16),

                          RegisterTextField(
                            label: "Last Name",
                            hintText: "Enter Last Name",
                            controller: lastNameController,
                            validator: (value) =>
                                Validators.requiredField(value, "Last Name"),
                          ),
                          const SizedBox(height: 16),

                          RegisterTextField(
                            label: "Email",
                            hintText: "Enter Email",
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            validator: Validators.email,
                          ),
                          const SizedBox(height: 16),

                          RegisterTextField(
                            label: "Address",
                            hintText: "Enter Address",
                            controller: addressController,
                            validator: (value) =>
                                Validators.requiredField(value, "Address"),
                          ),
                          const SizedBox(height: 16),

                          RegisterTextField(
                            label: "DOB",
                            hintText: "Enter DOB",
                            controller: dobController,
                            validator: (value) =>
                                Validators.requiredField(value, "DOB"),
                          ),

                          const SizedBox(height: 16),
                          RegisterTextField(
                            label: "Mobile Number",
                            hintText: "Enter Number",
                            controller: mobileController,
                            keyboardType: TextInputType.phone,
                            validator: Validators.mobile,
                          ),

                          const SizedBox(height: 16),

                          RegisterTextField(
                            label: "Location",
                            hintText: "Enter Location",
                            controller: locationController,
                            validator: (value) =>
                                Validators.requiredField(value, "Location"),
                          ),

                          const SizedBox(height: 16),

                          RegisterTextField(
                            label: "DOJ",
                            hintText: "Enter Date Of Joining",
                            controller: dojController,
                            validator: (value) => Validators.requiredField(
                              value,
                              "Date Of Joining",
                            ),
                          ),

                          const SizedBox(height: 16),

                          RegisterTextField(
                            label: "Password",
                            hintText: "Enter Password",
                            controller: passwordController,
                            obscureText: true,
                            validator: Validators.password,
                          ),

                          const SizedBox(height: 24),

                          Consumer<RegistrationProvider>(
                            builder: (context, provider, child) {
                              return CustomSaveButton(
                                title: provider.isLoading
                                    ? "Please Wait..."
                                    : "Save",
                                onTap: () async {
                                  if (!_formKey.currentState!.validate()) {
                                    return;
                                  }
                                  final success = await provider.register(
                                    firstName: firstNameController.text.trim(),
                                    lastName: lastNameController.text.trim(),
                                    email: emailController.text.trim(),
                                    password: passwordController.text.trim(),
                                    address: addressController.text.trim(),
                                    dob: dobController.text.trim(),
                                    mobileNumber: mobileController.text.trim(),
                                    doj: dojController.text.trim(),
                                    location: locationController.text.trim(),
                                  );

                                  if (!context.mounted) return;

                                  if (success && provider.registrationResponse?.status == true) {
                                    AppSnackbar.showSuccess(
                                      context,
                                      provider.registrationResponse?.message ?? 'Registration Successful',
                                    );

                                    Navigator.pop(context);
                                  } else {
                                    AppSnackbar.showError(
                                      context,
                                      provider.errorMessage ?? provider.registrationResponse?.message ?? 'Registration Failed',
                                    );
                                  }
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
