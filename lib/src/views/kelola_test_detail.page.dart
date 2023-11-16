import 'package:erecruitment/src/controllers/test_controller.dart';
import 'package:erecruitment/utils/app_constanta_empty.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/app_color.dart';

class KelolaTestDetailPage extends StatelessWidget {
  KelolaTestDetailPage({super.key});

  final _tC = Get.find<TestController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: Obx(
        () {
          if (_tC.isLoading.value) {
            return Center(
              child: Container(
                alignment: Alignment.center,
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: colorPrimary,
                ),
                child: const CupertinoActivityIndicator(
                  color: colorPrimaryDark,
                ),
              ),
            );
          }

          if (_tC.exam.value == examEmpty) {
            return const SizedBox();
          }

          return Column(
            children: [
              Container(
                width: double.infinity,
                height: 60,
                color: colorPrimaryDark.withOpacity(0.8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      width: 14,
                    ),
                    IconButton(
                      onPressed: () => context.pop(),
                      icon: const Icon(
                        Icons.close_rounded,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      width: 14,
                    ),
                    Text(
                      _tC.exam.value.title,
                      style: GoogleFonts.sourceCodePro(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 14, bottom: 14, left: 20, right: 6),
                      child: Container(
                        height: 500,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 14, bottom: 14, right: 20, left: 6),
                      child: Container(
                        height: 250,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          );
        },
      ),
    );
  }
}
