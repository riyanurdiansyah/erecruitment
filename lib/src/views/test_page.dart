import 'dart:math';

import 'package:erecruitment/src/controllers/dashboard_controller.dart';
import 'package:erecruitment/src/models/exam_m.dart';
import 'package:erecruitment/utils/app_color.dart';
import 'package:erecruitment/utils/app_text_normal.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../utils/app_route_name.dart';

class TestPage extends StatelessWidget {
  TestPage({super.key});

  final _dC = Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: colorPrimary,
      body: Column(
        children: [
          // Container(
          //   width: double.infinity,
          //   height: 60,
          //   color: colorPrimaryDark.withOpacity(0.8),
          // ),
          StreamBuilder<List<ExamM>>(
            stream: _dC.streamExam(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const SizedBox();
              }

              final exams = snapshot.data ?? [];

              return Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      childAspectRatio: 1.6,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 25,
                    ),
                    itemCount: exams.length,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: Colors.white,
                        ),
                        child: Column(
                          children: [
                            Expanded(
                              flex: 3,
                              child: Container(
                                width: double.infinity,
                                padding: const EdgeInsets.only(
                                    top: 35, left: 14, right: 14, bottom: 16),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  color: Color(
                                          (Random().nextDouble() * 0xFFFFFF)
                                              .toInt())
                                      .withOpacity(0.2),
                                ),
                                child: AppTextNormal.labelW600(
                                  exams[index].subname,
                                  30,
                                  Colors.black,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 14),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 25,
                                      height: 25,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                      ),
                                      child: Center(
                                        child: Icon(
                                          Icons.timer_outlined,
                                          color: Colors.grey.shade400,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    AppTextNormal.labelW500(
                                      "${(exams[index].time / 60).roundToDouble()} Menit",
                                      12,
                                      Colors.grey.shade600,
                                    ),
                                    const Spacer(),
                                    ElevatedButton(
                                      style: ButtonStyle(
                                        shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(18.0),
                                          ),
                                        ),
                                      ),
                                      onPressed: exams[index]
                                              .users
                                              .contains(_dC.user.value.id)
                                          ? null
                                          : () {
                                              _dC.isStarting.value = true;
                                              context.goNamed(
                                                  AppRouteName.ongoing,
                                                  extra: {
                                                    "exam": exams[index]
                                                  });
                                            },
                                      child: AppTextNormal.labelW600(
                                        "ASIGN",
                                        16,
                                        Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
