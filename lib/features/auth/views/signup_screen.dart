import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nike/features/auth/views/greetings_screen.dart';
import 'package:nike/features/auth/views/home_screen.dart';
import 'package:nike/features/auth/views/signup_details_screen.dart';
import '../../../core/constants/app_constants.dart';
import '../controller/auth_controller.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({Key? key}) : super(key: key);

  final TextEditingController _emailController = TextEditingController();

  bool _isValidEmail(String email) {
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    return emailRegex.hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 48),
                Image.asset("assets/logos.png"),
                const SizedBox(height: 48),
                const Text(
                  'Enter your email to join us\nor sign in.',
                  style: TextStyle(
                    color: AppConstants.primaryColor,
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 32),
                Row(
                  children: [
                    const Text(
                      'India',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: () {},
                      child: const Text(
                        'Change',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    hintText: 'Email*',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 20,
                      horizontal: 16,
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 16),
                RichText(
                  text: const TextSpan(
                    style: TextStyle(color: Colors.black54, fontSize: 16),
                    children: [
                      TextSpan(text: 'By continuing, I agree to Nike\'s '),
                      TextSpan(
                        text: 'Privacy Policy.',
                        style: TextStyle(
                          color: Colors.black,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      TextSpan(text: ' and '),
                      TextSpan(
                        text: 'Terms of Use.',
                        style: TextStyle(
                          color: Colors.black,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      final email = _emailController.text.trim();
                      if (_isValidEmail(email)) {
                        Get.to(() => SignupDetailsScreen(email: email));
                      } else {
                        Get.snackbar(
                          "Invalid Email",
                          "Please enter a valid email",
                        );
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 32,
                      ),
                      child: const Text(
                        'Continue',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                Row(
                  children: const [
                    Expanded(child: Divider()),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.0),
                      child: Text(
                        'or',
                        style: TextStyle(color: Colors.black54),
                      ),
                    ),
                    Expanded(child: Divider()),
                  ],
                ),
                const SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _SocialButton(
                      assetPath: 'assets/google.jpg',
                      onTap: () async {
                        try {
                          final userCredential = await AuthController.to
                              .signInWithGoogle();
                          if (userCredential != null) {
                            if (AuthController.to.isFirstLogin.value) {
                              Get.offAll(() => const GreetingsScreen());
                            } else {
                              Get.offAll(() => HomeScreen());
                            }
                          }
                        } catch (e) {
                          Get.snackbar('Error', e.toString());
                        }
                      },
                    ),
                    _SocialButton(
                      assetPath: 'assets/facebook.jpg',
                      onTap: () {},
                    ),
                    _SocialButton(assetPath: 'assets/apple.jpg', onTap: () {}),
                  ],
                ),
                const SizedBox(height: 48),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SocialButton extends StatelessWidget {
  final String assetPath;
  final VoidCallback onTap;
  const _SocialButton({required this.assetPath, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      elevation: 2,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: SizedBox(width: 32, height: 32, child: Image.asset(assetPath)),
        ),
      ),
    );
  }
}