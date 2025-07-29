import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nike/features/auth/controller/auth_controller.dart';
import 'package:nike/features/auth/views/home_screen.dart';
import 'package:nike/features/auth/views/sign_in_screen.dart';
import '../../../core/constants/app_constants.dart';

class GreetingsScreen extends StatelessWidget {
  const GreetingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Navigate after 5 seconds
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 5), () {
        AuthController.to.isFirstLogin.value = false;
        Get.offAll(() => const SignInScreen());
      });
    });

    return Scaffold(
      backgroundColor: AppConstants.primaryColor,
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 48),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    'assets/Vector.png',
                    height: 48,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 48),
                  GetX<AuthController>(
                    builder: (controller) {
                      return Text(
                        'Hi ${controller.user.value?.name ?? "User"},\nWelcome to Nike.',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          height: 1.2,
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Thanks for becoming a Member!',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 22,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              left: 32,
              bottom: 48,
              child: Text(
                'Member Since ${DateTime.now().year}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
