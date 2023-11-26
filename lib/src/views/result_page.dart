import 'package:erecruitment/src/controllers/result_controller.dart';
import 'package:erecruitment/utils/app_color.dart';
import 'package:erecruitment/utils/app_text_normal.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResultPage extends StatelessWidget {
  ResultPage({super.key});

  final _rC = Get.find<ResultController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(
              () => Row(
                children: List.generate(
                  _rC.exams.length,
                  (index) => Padding(
                    padding: const EdgeInsets.only(right: 6.0),
                    child: OutlinedButton(
                      onPressed: () {
                        _rC.selectedTabIndex.value = index;
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          _rC.selectedTabIndex.value == index
                              ? colorPrimaryDark
                              : Colors.white,
                        ),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(
                              color: _rC.selectedTabIndex.value == index
                                  ? colorPrimaryDark
                                  : Colors.grey.shade500,
                            ),
                          ),
                        ),
                      ),
                      child: AppTextNormal.labelBold(
                        _rC.exams[index].title,
                        14,
                        _rC.selectedTabIndex.value == index
                            ? Colors.white
                            : Colors.grey.shade500,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
