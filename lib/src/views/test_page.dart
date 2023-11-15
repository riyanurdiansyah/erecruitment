import 'package:erecruitment/src/controllers/dashboard_controller.dart';
import 'package:erecruitment/src/models/exam_m.dart';
import 'package:erecruitment/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class TestPage extends StatelessWidget {
  TestPage({super.key});

  final _dC = Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
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
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.grey.shade300,
                          gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              colorPrimaryDark,
                              colorPrimary,
                              colorPrimaryDark,
                            ],
                          ),
                        ),
                        child: Column(
                          children: [
                            Expanded(
                              child: Center(
                                child: Center(
                                  child: Text(
                                    exams[index].title[0],
                                    style: GoogleFonts.caveat(
                                      fontSize: 60,
                                      color: colorPrimaryDark,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 18),
                              width: double.infinity,
                              height: 80,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: colorPrimary,
                                border: Border.all(
                                  color: colorPrimaryDark.withOpacity(0.6),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      );

                      // ElevatedButton(
                      //   onPressed: exams[index]
                      //           .users
                      //           .contains(_dC.user.value.id)
                      //       ? null
                      //       : () {
                      //           _dC.isStarting.value = true;
                      //           context.goNamed(AppRouteName.ongoing, extra: {
                      //             "exam": exams[index],
                      //           });
                      //         },
                      //   child: Column(
                      //     mainAxisAlignment: MainAxisAlignment.center,
                      //     children: [
                      //       AppTextNormal.labelBold(
                      //         exams[index].title,
                      //         14,
                      //         Colors.white,
                      //       ),
                      //       AppTextNormal.labelBold(
                      //         "${exams[index].number} Soal",
                      //         14,
                      //         Colors.white,
                      //       ),
                      //     ],
                      //   ),
                      // );
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
