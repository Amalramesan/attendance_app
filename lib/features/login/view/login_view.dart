import 'package:attendance_app/core/local_storage/storage_service.dart';
import 'package:attendance_app/features/login/data/provider/login_provider.dart';
import 'package:attendance_app/features/login/view/widgets/custom_button_widget.dart';
import 'package:attendance_app/features/login/view/widgets/custom_text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});

  final TextEditingController usernameController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF6F6F6),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              const Spacer(),

              Image.asset('assets/icons/logo.png', height: 90),

              const SizedBox(height: 80),

              CustomTextField(
                hintText: 'Username',
                controller: usernameController,
              ),

              const SizedBox(height: 16),

              CustomTextField(
                hintText: 'Password',
                controller: passwordController,
                obscureText: true,
              ),

              const SizedBox(height: 25),

              Consumer<LoginProvider>(
                builder: (context, provider, child) {
                  return CustomButton(
                    title: provider.isLoading ? 'Loading...' : 'Login',
                    onTap: () async {
                      final success = await provider.login(
                        mobileNumber: usernameController.text.trim(),
                        password: passwordController.text.trim(),
                      );

                      if (success && provider.loginResponse?.status == true) {
                        await StorageService().saveToken(
                          provider.loginResponse!.token,
                        );

                        await StorageService().saveUserId(
                          provider.loginResponse!.user.userId,
                        );

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(provider.loginResponse!.message),
                          ),
                        );

                        print("TOKEN : ${provider.loginResponse!.token}");

                        print(
                          "USER : ${provider.loginResponse!.user.firstName}",
                        );

                        // Navigate to Dashboard
                        if (context.mounted) {
                          context.goNamed('dashboard');
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              provider.errorMessage ?? 'Login failed',
                            ),
                          ),
                        );
                      }
                    },
                  );
                },
              ),
              const SizedBox(height: 12),

              CustomButton(
                title: 'Create Account',
                outlined: true,
                onTap: () {
                  context.pushNamed('registration');
                },
              ),
              const Spacer(flex: 2),
            ],
          ),
        ),
      ),
    );
  }
}
