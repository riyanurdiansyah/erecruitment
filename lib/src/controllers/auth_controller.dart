import 'package:erecruitment/src/repositories/auth_repository.dart';
import 'package:erecruitment/utils/app_route.dart';
import 'package:erecruitment/utils/app_route_name.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  final tcUsername = TextEditingController();

  final tcPassword = TextEditingController();

  final AuthRepository authRepository = AuthRepositoryImpl();

  late SharedPreferences prefs;

  final isLoading = false.obs;

  final errorMessage = "".obs;

  final Rx<bool> isLoggedIn = false.obs;

  @override
  void onInit() async {
    prefs = await SharedPreferences.getInstance();
    isLoggedIn.value = await isAuthenticated();
    super.onInit();
  }

  @override
  void dispose() {
    tcUsername.dispose();
    tcPassword.dispose();
    super.dispose();
  }

  Future<bool> isAuthenticated() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return true;
    }

    return false;
  }

  void signIn() async {
    isLoading.value = true;
    errorMessage.value = "";

    final user = await authRepository.getUser(tcUsername.text);
    if (user == null) {
      Future.delayed(const Duration(seconds: 2), () {
        isLoading.value = false;
        errorMessage.value = "Username tidak terdaftar";
      });
    } else {
      final body = {
        "email": user.email,
        "password": tcPassword.text,
      };

      final loggedIn = await authRepository.signIn(body);
      Future.delayed(const Duration(seconds: 2), () {
        isLoading.value = false;
        if (loggedIn != null) {
          isLoggedIn.value = true;
          prefs.setString("username", user.username);
          prefs.setString("email", user.email);
          prefs.setInt("role", user.role);
          rootNavigatorKey.currentContext!.goNamed(AppRouteName.home);
        } else {
          errorMessage.value = "Username atau password salah";
        }
      });
    }
  }

  void signOut() async {
    await authRepository.signOut();
  }
}
