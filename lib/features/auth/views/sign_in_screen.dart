import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_constants.dart';
import 'package:nike/features/auth/controller/auth_controller.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isValid = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _emailController.addListener(_validateEmail);
    _passwordController.addListener(_onPasswordChanged);
  }

  void _validateEmail() {
    final email = _emailController.text;
    setState(() {
      _isValid = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$").hasMatch(email);
    });
  }

  void _onPasswordChanged() {
    setState(() {}); // Triggers rebuild so canContinue updates
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.removeListener(_onPasswordChanged);
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final canContinue =
        _isValid && _passwordController.text.isNotEmpty && !_isLoading;

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
                Image.asset('assets/logos.png', height: 36),
                const SizedBox(height: 48),
                const Text(
                  'Sign in with email',
                  style: TextStyle(
                    color: AppConstants.primaryColor,
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Maecenas a quam a elit porta hendrerit id elementum massa.',
                  style: TextStyle(color: Colors.grey, fontSize: 18),
                ),
                const SizedBox(height: 32),
                Material(
                  elevation: 4,
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          child: Icon(
                            Icons.email_outlined,
                            size: 28,
                            color: AppConstants.primaryColor,
                          ),
                        ),
                        Expanded(
                          child: TextField(
                            controller: _emailController,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Email',
                              hintStyle: TextStyle(fontSize: 18),
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 20,
                              ),
                            ),
                            keyboardType: TextInputType.emailAddress,
                            style: const TextStyle(fontSize: 18),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 200),
                            child: _isValid
                                ? const Icon(
                                    Icons.check_circle,
                                    color: Colors.green,
                                    size: 28,
                                  )
                                : const SizedBox(width: 28),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Material(
                  elevation: 4,
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          child: Icon(
                            Icons.lock_outline,
                            size: 28,
                            color: AppConstants.primaryColor,
                          ),
                        ),
                        Expanded(
                          child: TextField(
                            controller: _passwordController,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Password',
                              hintStyle: TextStyle(fontSize: 18),
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 20,
                              ),
                            ),
                            obscureText: true,
                            style: const TextStyle(fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                Center(
                  child: GestureDetector(
                    onTap: canContinue
                        ? () async {
                            setState(() {
                              _isLoading = true;
                            });
                            try {
                              await AuthController.to.signInWithEmail(
                                _emailController.text.trim(),
                                _passwordController.text.trim(),
                              );
                            } catch (e) {
                              Get.snackbar('Error', e.toString());
                            } finally {
                              setState(() {
                                _isLoading = false;
                              });
                            }
                          }
                        : null,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 18,
                        horizontal: 60,
                      ),
                      decoration: BoxDecoration(
                        color: canContinue
                            ? Colors.black
                            : Colors.grey.shade400,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Center(
                        child: _isLoading
                            ? const SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2.5,
                                ),
                              )
                            : const Text(
                          'Continue',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                          ),
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
                        'or continue with',
                        style: TextStyle(color: Colors.grey, fontSize: 18),
                      ),
                    ),
                    Expanded(child: Divider()),
                  ],
                ),
                const SizedBox(height: 32),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _SocialButton(
                      assetPath: 'assets/google.jpg',
                      onTap: () async {
                        try {
                          await AuthController.to.signInWithGoogle();
                        } catch (e) {
                          Get.snackbar('Error', e.toString());
                        }
                      },
                    ),
                      const SizedBox(width: 32),
                    _SocialButton(
                      assetPath: 'assets/facebook.jpg',
                      onTap: () {
                        Get.snackbar(
                          "Info",
                          "Facebook login not implemented yet.",
                        );
                      },
                    ),
                      const SizedBox(width: 32),
                    _SocialButton(
                      assetPath: 'assets/apple.jpg',
                      onTap: () {
                        Get.snackbar(
                          "Info",
                          "Apple login not implemented yet.",
                        );
                      },
                    ),
                  ],
                  ),
                ),
                const SizedBox(height: 48),
                const Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      'Nam id elementum risus. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer luctus enim non sapien ullamcorper congue.',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                        height: 1.4,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
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

  const _SocialButton({Key? key, required this.assetPath, required this.onTap})
      : super(key: key);

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
          child: SizedBox(
            width: 32,
            height: 32,
            child: Image.asset(assetPath, fit: BoxFit.contain),
          ),
        ),
      ),
    );
  }
}
