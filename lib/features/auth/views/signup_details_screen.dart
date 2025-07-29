import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nike/features/auth/views/signup_succes.dart';
import '../../../core/constants/app_constants.dart';
import '../controller/auth_controller.dart';
import 'home_screen.dart';

class SignupDetailsScreen extends StatefulWidget {
  final String? email;
  const SignupDetailsScreen({Key? key, this.email}) : super(key: key);

  @override
  State<SignupDetailsScreen> createState() => _SignupDetailsScreenState();
}

class _SignupDetailsScreenState extends State<SignupDetailsScreen> {
  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _dobDayController = TextEditingController();
  final TextEditingController _dobMonthController = TextEditingController();
  final TextEditingController _dobYearController = TextEditingController();

  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 32),
              Image.asset('assets/logos.png'),
              const SizedBox(height: 32),
              const Text(
                "Now let’s make you a Nike Member.",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w600,
                  color: AppConstants.primaryColor,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                "We’ve sent a code to ${widget.email ?? 'your email'}",
                style: const TextStyle(fontSize: 16),
              ),
              TextButton(onPressed: () {}, child: const Text("Edit")),
              const SizedBox(height: 12),
              TextField(
                controller: _codeController,
                onChanged: (value) {
                  setState(() {}); // Triggers UI rebuild for dynamic icon
                },
                decoration: InputDecoration(
                  hintText: 'Code*',
                  suffixIcon: _codeController.text.trim() == '1234'
                      ? const Icon(Icons.check_circle, color: Colors.green)
                      : const Icon(Icons.refresh),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 16,
                  ),
                ),
              ),

              const SizedBox(height: 8),
              const Align(
                alignment: Alignment.centerRight,
                child: Text("Resend code in 9s"),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _firstNameController,
                      decoration: InputDecoration(
                        hintText: 'First Name*',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextField(
                      controller: _lastNameController,
                      decoration: InputDecoration(
                        hintText: 'Surname*',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _passwordController,
                obscureText: _obscurePassword,
                decoration: InputDecoration(
                  hintText: 'Password*',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'x Minimum of 8 characters\nX Uppercase, lowercase letters and one number',
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 24),
              const Text(
                'Date of Birth',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppConstants.primaryColor,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _dobDayController,
                      decoration: InputDecoration(
                        hintText: 'Day*',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextField(
                      controller: _dobMonthController,
                      decoration: InputDecoration(
                        hintText: 'Month*',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextField(
                      controller: _dobYearController,
                      decoration: InputDecoration(
                        hintText: 'Year*',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              const Text("Get a Nike Member Reward on your birthday."),
              const SizedBox(height: 32),
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    print('Sign Up button pressed');
                    if (_codeController.text.trim() == '1234') {
                      final firstName = _firstNameController.text.trim();
                      final lastName = _lastNameController.text.trim();
                      final password = _passwordController.text.trim();
                      final email = widget.email ?? '';

                      if (firstName.isEmpty ||
                          lastName.isEmpty ||
                          password.length < 8) {
                        print('Validation failed');
                        Get.snackbar(
                          'Error',
                          'Please fill all fields correctly.',
                        );
                        return;
                      }

                      final fullName = "$firstName $lastName";

                      try {
                        print('Calling signUpWithEmail');
                        final user = await AuthController.to.signUpWithEmail(
                          name: fullName,
                          email: email,
                          password: password,
                        );
                        print(
                          'signUpWithEmail returned: ' +
                              (user != null ? user.toString() : 'null'),
                        );
                        if (user != null) {
                          print('Navigating to SignupSuccessScreen');
                          Get.snackbar("Success", "Signup successful");
                        }
                      } catch (e) {
                        print('Signup Failed: $e');
                        Get.snackbar("Signup Failed", e.toString());
                      }
                    } else {
                      print('Invalid code');
                      Get.snackbar(
                        "Invalid Code",
                        "The OTP code you entered is incorrect.",
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 48,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    "Sign Up",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
