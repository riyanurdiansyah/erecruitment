import 'dart:math';

import 'package:erecruitment/utils/app_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/app_text_normal.dart';
import '../controllers/dashboard_controller.dart';
import '../models/exam_m.dart';

class KelolaTestPage extends StatelessWidget {
  KelolaTestPage({super.key});

  final _dC = Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          StreamBuilder<List<ExamM>>(
            stream: _dC.streamExamForAdmin(),
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
                    itemCount: exams.length + 1,
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
                              child: index == exams.length
                                  ? InkWell(
                                      onTap: () =>
                                          AppDialog.dialogAddTes(dC: _dC),
                                      child: Container(
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(6),
                                          color: Colors.grey.shade300,
                                        ),
                                        child: Center(
                                          child: IconButton(
                                            iconSize: 80,
                                            onPressed: () =>
                                                AppDialog.dialogAddTes(dC: _dC),
                                            icon: Icon(
                                              Icons.add_rounded,
                                              color: Colors.grey.shade600,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  : Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.only(
                                          top: 35,
                                          left: 14,
                                          right: 14,
                                          bottom: 16),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(6),
                                        color: Color((Random().nextDouble() *
                                                    0xFFFFFF)
                                                .toInt())
                                            .withOpacity(0.2),
                                      ),
                                      child: AppTextNormal.labelW600(
                                        exams[index].title,
                                        30,
                                        Colors.black,
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                            ),
                            if (index != exams.length)
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 14),
                                  child: Row(
                                    children: [
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
                                        onPressed: () {},
                                        child: AppTextNormal.labelW600(
                                          "KELOLA",
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
