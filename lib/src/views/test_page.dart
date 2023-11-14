import 'package:erecruitment/src/controllers/dashboard_controller.dart';
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
            Obx(
              () {
                if (_dC.exams.isEmpty) {
                  return const SizedBox();
                }

                return Expanded(
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      childAspectRatio: 6,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 25,
                    ),
                    itemCount: _dC.exams.length,
                    itemBuilder: (context, index) {
                      return ElevatedButton(
                        onPressed: _dC.exams[index].users
                                .contains(_dC.user.value.id)
                            ? null
                            : () {
                                _dC.isStarting.value = true;
                                context.goNamed(AppRouteName.ongoing, extra: {
                                  "exam": _dC.exams[index],
                                });
                              },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AppTextNormal.labelBold(
                              _dC.exams[index].title,
                              14,
                              Colors.white,
                            ),
                            AppTextNormal.labelBold(
                              "${_dC.exams[index].number} Soal",
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
