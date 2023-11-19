import 'dart:math';

import 'package:erecruitment/utils/app_dialog.dart';
import 'package:erecruitment/utils/app_route.dart';
import 'package:erecruitment/utils/app_route_name.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

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
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          AppTextNormal.labelW600(
                                            exams[index].subname,
                                            30,
                                            Colors.black,
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          AppTextNormal.labelW600(
                                            exams[index].title,
                                            18,
                                            Colors.grey.shade600,
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
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
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Colors.red),
                                          shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(14.0),
                                            ),
                                          ),
                                        ),
                                        onPressed: () {
                                          AppDialog.dialogLogout(
                                            title: "Hapus",
                                            subtitle:
                                                "Yakin ingin menghapus data ini?",
                                            ontap: () {
                                              rootNavigatorKey.currentContext!
                                                  .pop();
                                              _dC.deleteExams(exams[index].id);
                                            },
                                          );
                                        },
                                        child: const Icon(
                                          Icons.delete_rounded,
                                          size: 20,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 6,
                                      ),
                                      ElevatedButton(
                                        style: ButtonStyle(
                                          shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(14.0),
                                            ),
                                          ),
                                        ),
                                        onPressed: () {
                                          context.goNamed(
                                              AppRouteName.kelolaTestDetail,
                                              pathParameters: {
                                                "id": exams[index].id
                                              });
                                        },
                                        child: const Icon(
                                          Icons.edit_rounded,
                                          size: 20,
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
