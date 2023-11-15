import 'package:erecruitment/src/controllers/dashboard_controller.dart';
import 'package:erecruitment/src/models/exam_m.dart';
import 'package:erecruitment/utils/app_route_name.dart';
import 'package:erecruitment/utils/app_text_normal.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class TestPage extends StatelessWidget {
  TestPage({super.key});

  final _dC = Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 14),
        child: Column(
          children: [
            StreamBuilder<List<ExamM>>(
              stream: _dC.streamExam(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const SizedBox();
                }

                final exams = snapshot.data ?? [];

                return Expanded(
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      childAspectRatio: 6,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 25,
                    ),
                    itemCount: exams.length,
                    itemBuilder: (context, index) {
                      return ElevatedButton(
                        onPressed: exams[index]
                                .users
                                .contains(_dC.user.value.id)
                            ? null
                            : () {
                                _dC.isStarting.value = true;
                                context.goNamed(AppRouteName.ongoing, extra: {
                                  "exam": exams[index],
                                });
                              },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AppTextNormal.labelBold(
                              exams[index].title,
                              14,
                              Colors.white,
                            ),
                            AppTextNormal.labelBold(
                              "${exams[index].number} Soal",
                              14,
                              Colors.white,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
