import 'package:erecruitment/src/controllers/auth_controller.dart';
import 'package:erecruitment/src/controllers/dashboard_controller.dart';
import 'package:erecruitment/src/controllers/home_controller.dart';
import 'package:erecruitment/src/controllers/ongoing_controller.dart';
import 'package:erecruitment/src/controllers/result_controller.dart';
import 'package:erecruitment/src/controllers/test_controller.dart';
import 'package:erecruitment/src/controllers/test_type_controller.dart';
import 'package:erecruitment/src/controllers/user_controller.dart';
import 'package:erecruitment/utils/app_color.dart';
import 'package:erecruitment/utils/app_route_name.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class SignoutPage extends StatefulWidget {
  const SignoutPage({super.key});

  @override
  State<SignoutPage> createState() => _SignoutPageState();
}

class _SignoutPageState extends State<SignoutPage> {
  @override
  void initState() {
    Get.delete<HomeController>();
    Get.delete<TestController>();
    Get.delete<OngoingController>();
    Get.delete<UserController>();
    Get.delete<ResultController>();
    Get.delete<TestTypeController>();
    Get.delete<AuthController>();
    Get.delete<DashboardController>();
    Future.delayed(const Duration(seconds: 3), () async {
      await FirebaseAuth.instance
          .signOut()
          .then((value) => context.goNamed(AppRouteName.signin));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          color: colorPrimaryDark,
        ),
      ),
    );
  }
}
