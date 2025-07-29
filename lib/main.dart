import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nike/core/app/splash_screen.dart';
import 'package:nike/features/auth/controller/auth_controller.dart';
import 'package:nike/firebase_options.dart';
import 'core/app/landing_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Must be called first
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  Get.put(AuthController()); // Now it's safe to initialize AuthController

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}
