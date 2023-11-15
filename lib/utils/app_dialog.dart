import 'package:erecruitment/utils/app_route.dart';
import 'package:erecruitment/utils/app_text_normal.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppDialog {
  static dialogEndQuiz({
    required String title,
    required String subtitle,
    required Function() ontap,
    bool? isFinished,
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
            onPressed: ontap,
            child: AppTextNormal.labelBold(
              "Kumpulkan",
              16,
              Colors.white,
            ),
          ),
          if (isFinished == true)
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Colors.grey.shade400)),
              onPressed: () => rootNavigatorKey.currentContext!.pop(),
              child: AppTextNormal.labelBold(
                "Batal",
                16,
                Colors.white,
              ),
            ),
        ],
      ),
    );
  }
}
