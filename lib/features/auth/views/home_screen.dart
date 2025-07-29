import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nike/features/auth/controller/auth_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = AuthController.to;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Nike Home"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: "Logout",
            onPressed: () async {
              await authController.signOut();
            },
          ),
        ],
      ),
      body: Center(
        child: Obx(() {
          final user = authController.user.value;
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Welcome, ${user?.name ?? "User"}!',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Text('Email: ${user?.email ?? "No email"}'),
              const SizedBox(height: 10),
            ],
          );
        }),
      ),
    );
  }
}
