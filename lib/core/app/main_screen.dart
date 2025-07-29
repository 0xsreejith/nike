import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nike/features/auth/controller/auth_controller.dart';
import 'package:nike/features/auth/views/login_or_signup_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = AuthController.to.user.value;
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome,  ${user?.name ?? "User"}'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              AuthController.to.signOut();
              Get.offAll(() => const LoginOrSignupScreen());
            },
          ),
        ],
      ),
      body: const Center(child: Text('Main Screen')),
    );
  }
}
