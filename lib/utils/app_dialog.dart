import 'package:erecruitment/utils/app_route.dart';
import 'package:erecruitment/utils/app_text_normal.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'app_route_name.dart';

class AppDialog {
  static dialogEndQuiz({
    required String title,
    required String subtitle,
  }) {
    return showDialog(
      context: rootNavigatorKey.currentContext!,
      builder: (context) => AlertDialog(
        title: AppTextNormal.labelW600(
          title,
          16,
          Colors.black,
        ),
        content: AppTextNormal.labelW500(
          subtitle,
          16,
          Colors.grey.shade500,
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              rootNavigatorKey.currentContext!.goNamed(AppRouteName.test);
            },
            child: AppTextNormal.labelBold(
              "Kumpulkan",
              16,
              Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
