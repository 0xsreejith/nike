import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nike/core/app/landing_page.dart';
import 'package:nike/core/constants/app_constants.dart';
import 'package:nike/features/auth/views/greetings_screen.dart';

class SignupSuccessScreen extends StatefulWidget {
  const SignupSuccessScreen({Key? key}) : super(key: key);

  @override
  State<SignupSuccessScreen> createState() => _SignupSuccessScreenState();
}

class _SignupSuccessScreenState extends State<SignupSuccessScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      Get.offAll(() => const GreetingsScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 48.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Image.asset("assets/logos.png"),
            const SizedBox(height: 80),
            const Text(
              'You have been signed in\nsuccessfully.',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A102C),
                height: 1.2,
              ),
            ),
            const SizedBox(height: 40),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppConstants.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 12,
                  ),
                ),
                onPressed: () {
                  Get.offAll(() => const GreetingsScreen());
                },
                child: const Text(
                  'Continue',
                  style: TextStyle(fontSize: 22, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
