import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:nike/features/auth/views/greetings_screen.dart';
import 'package:nike/features/auth/views/home_screen.dart';
import 'package:nike/features/auth/views/login_or_signup_screen.dart';
import 'package:nike/features/auth/views/signup_succes.dart';
import '../models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:nike/features/splash-section/splash_screen_one.dart';

class AuthController extends GetxController {
  static AuthController get to => Get.find();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final Rxn<UserModel> user = Rxn<UserModel>();
  RxBool isFirstLogin = false.obs;

  @override
  void onInit() {
    _auth.authStateChanges().listen(_handleAuthStateChanged);
    super.onInit();
  }

  void _handleAuthStateChanged(User? firebaseUser) async {
    if (firebaseUser != null) {
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(firebaseUser.uid)
          .get();

      if (doc.exists) {
        user.value = UserModel(
          uid: firebaseUser.uid,
          email: doc['email'],
          name: doc['name'],
        );
      } else {
        user.value = UserModel.fromFirebaseUser(firebaseUser);
      }
    } else {
      user.value = null;
    }
  }

  Future<void> navigateAfterLogin(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final hasSeenSplash = prefs.getBool('hasSeenSplash') ?? false;
    if (!hasSeenSplash) {
      Get.offAll(() => const SplashPager());
    } else {
      Get.offAll(() => const HomeScreen());
    }
  }

  Future<void> setSplashSeen() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('hasSeenSplash', true);
  }

  Future<void> signInWithEmail(String email, String password) async {
    try {
      Get.dialog(
        const Center(child: CircularProgressIndicator()),
        barrierDismissible: false,
      );
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      _handleAuthStateChanged(credential.user);
      isFirstLogin.value = false;
      Get.back();
      Get.snackbar("Success", "Logged in successfully");
      await navigateAfterLogin(Get.context!);
    } on FirebaseAuthException catch (e) {
      Get.back();
      Get.snackbar("Login Failed", e.message ?? "Unknown error");
    }
  }

  Future<User?> signUpWithEmail({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      Get.dialog(
        const Center(child: CircularProgressIndicator()),
        barrierDismissible: false,
      );

      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await FirebaseFirestore.instance
          .collection('users')
          .doc(credential.user!.uid)
          .set({
            'name': name,
            'email': email,
            'createdAt': DateTime.now().toIso8601String(),
          });

      isFirstLogin.value = true;

      user.value = UserModel(
        uid: credential.user!.uid,
        email: email,
        name: name,
      );

      Get.back();
      Get.snackbar("Success", "Signup successful");
      await navigateAfterLogin(Get.context!);
      return credential.user;
    } catch (e) {
      Get.back();
      Get.snackbar("Signup Failed", e.toString());
      return null;
    }
  }

  Future<UserCredential?> signInWithGoogle() async {
    try {
      Get.dialog(
        const Center(child: CircularProgressIndicator()),
        barrierDismissible: false,
      );

      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        Get.back();
        return null;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await _auth.signInWithCredential(credential);
      final userId = userCredential.user!.uid;
      final isNew = userCredential.additionalUserInfo?.isNewUser ?? false;

      final userDoc = FirebaseFirestore.instance
          .collection('users')
          .doc(userId);
      final docSnapshot = await userDoc.get();

      if (!docSnapshot.exists && isNew) {
        await userDoc.set({
          'name': googleUser.displayName ?? '',
          'email': googleUser.email,
          'createdAt': DateTime.now().toIso8601String(),
        });
        isFirstLogin.value = true;
      } else {
        isFirstLogin.value = false;
      }

      user.value = UserModel(
        uid: userId,
        email: googleUser.email,
        name: googleUser.displayName ?? '',
      );

      Get.back();
      Get.snackbar("Success", "Google Sign-in successful");
      await navigateAfterLogin(Get.context!);
      return userCredential;
    } catch (e) {
      Get.back();
      Get.snackbar("Google Sign-In Failed", e.toString());
      return null;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
    user.value = null;
    Get.offAll(() => const LoginOrSignupScreen());
  }
}
