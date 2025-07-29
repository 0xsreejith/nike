import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nike/core/app/splash_screen.dart';
import 'package:nike/features/auth/controller/auth_controller.dart';
import 'package:nike/features/auth/views/home_screen.dart';
import 'package:nike/features/auth/views/login_or_signup_screen.dart';
import 'package:nike/features/auth/views/greetings_screen.dart';
import 'package:nike/features/splash-section/splash_screen_one.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final authController = AuthController.to;

      // 1. Not logged in
      if (authController.user.value == null) {
        return const LoginOrSignupScreen();
      }

      // 2. First time after signup → Show greetings
      if (authController.isFirstLogin.value) {
        return GreetingsScreen();
      }

      // 3. Already logged in, not first time → Home
      return const HomeScreen();
    });
  }
}

