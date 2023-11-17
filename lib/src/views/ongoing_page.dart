import 'package:camera/camera.dart';
import 'package:erecruitment/src/controllers/ongoing_controller.dart';
import 'package:erecruitment/utils/app_text_normal.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OngoingPage extends StatelessWidget {
  OngoingPage({super.key});

  final _oC = Get.find<OngoingController>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Obx(() {
                if (_oC.isLoading.value) {
                  return SizedBox(
                    height: size.height,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }

                return Container(
                  height: _oC.maxQuestion.value > 50 ? 150 : 100,
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: SizedBox(
                          width: 150,
                          height: 120,
                          child: Obx(() {
                            if (_oC.isLoading.value) {
                              return const SizedBox();
                            }
                            return CameraPreview(_oC.cameraController);
                          }),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: buildTime(),
                      ),
                    ],
                  ),
                );
              }),
              Expanded(
                child: Obx(() {
                  if (_oC.exams.value.type == "multiple_choice" &&
                      _oC.questionIst.isNotEmpty) {
                    return Column(
                      children: [
                        const SizedBox(
                          height: 35,
                        ),
                        AppTextNormal.labelW600(
                          _oC.questionIst[_oC.indexQuestion.value].question,
                          25,
                          Colors.black,
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        Column(
                          children: List.generate(
                            _oC.questionIst[_oC.indexQuestion.value].options
                                .length,
                            (index) => InkWell(
                              onTap: () => _oC.selectedOption(index),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 12, horizontal: 16),
                                child: Row(
                                  children: [
                                    Radio(
                                      value: index,
                                      groupValue: _oC.indexSelectedOption.value,
                                      onChanged: _oC.selectedOption,
                                    ),
                                    const SizedBox(
                                      width: 16,
                                    ),
                                    AppTextNormal.labelW600(
                                      _oC.questionIst[_oC.indexQuestion.value]
                                          .options[index].teks,
                                      16,
                                      Colors.black,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                      ],
                    );
                  }

                  return const SizedBox();
                }),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: Obx(() {
        if (_oC.isLoading.value) {
          return const SizedBox();
        }

        return Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _buildRows(),
            ),
            const SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: _oC.answereds[_oC.indexQuestion.value] == 99
                      ? null
                      : () => _oC.onBackSeri(),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                    child: Row(
                      children: [
                        Icon(
                          Icons.keyboard_double_arrow_left_rounded,
                          color: _oC.indexQuestion.value == 0
                              ? Colors.grey.shade400
                              : Colors.blue,
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        AppTextNormal.labelW600(
                          "Sebelumnya",
                          16,
                          _oC.indexQuestion.value == 0
                              ? Colors.grey.shade400
                              : Colors.blue,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  width: 18,
                ),
                SizedBox(
                  height: 35,
                  width: 100,
                  child: ElevatedButton(
                    onPressed: _oC.answereds.contains(99)
                        ? null
                        : () => _oC.finishedQuiz(isFinished: true),
                    child: AppTextNormal.labelW600(
                      "SELESAI",
                      16,
                      Colors.white,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 18,
                ),
                InkWell(
                  onTap: _oC.answereds[_oC.indexQuestion.value] == 99 ||
                          (_oC.indexQuestion.value + 1) == _oC.maxQuestion.value
                      ? null
                      : () {
                          _oC.onNextSeri();
                        },
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                    child: Row(
                      children: [
                        AppTextNormal.labelW600(
                          "Selanjutnya",
                          16,
                          _oC.answereds[_oC.indexQuestion.value] == 99 ||
                                  (_oC.indexQuestion.value + 1) ==
                                      _oC.maxQuestion.value
                              ? Colors.grey.shade400
                              : Colors.blue,
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Icon(
                          Icons.keyboard_double_arrow_right_rounded,
                          color: _oC.answereds[_oC.indexQuestion.value] == 99 ||
                                  (_oC.indexQuestion.value + 1) ==
                                      _oC.maxQuestion.value
                              ? Colors.grey.shade400
                              : Colors.blue,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 50,
            ),
          ],
        );
      }),
    );
  }

  List<Widget> _buildRows() {
    List<Widget> rows = [];
    int itemsPerRow = _oC.maxQuestion.value > 70 ? 25 : 15;

    for (int i = 0; i < _oC.maxQuestion.value; i += itemsPerRow) {
      int end = (i + itemsPerRow < _oC.maxQuestion.value)
          ? i + itemsPerRow
          : _oC.maxQuestion.value;
      List<Widget> rowItems = [];

      for (int j = i; j < end; j++) {
        rowItems.add(
          InkWell(
            onTap: _oC.indexQuestion.value == j
                ? null
                : () => _oC.onTapQuestion(j),
            child: Container(
              margin: const EdgeInsets.all(2.5),
              width: 30,
              height: 30,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3.0),
                color: _oC.getColorQuestion(j),
              ),
              child: AppTextNormal.labelW600(
                (j + 1).toString(),
                12,
                Colors.white,
              ),
            ),
          ),
        );
      }

      rows.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: rowItems,
        ),
      );
    }

    return rows;
  }

  Widget buildTime() {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(_oC.durations.value.inHours);
    final minutes = twoDigits(_oC.durations.value.inMinutes.remainder(60));
    final seconds = twoDigits(_oC.durations.value.inSeconds.remainder(60));

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        buildTimeCard(time: hours, header: "Jam"),
        const SizedBox(
          width: 8,
        ),
        buildTimeCard(time: minutes, header: "Menit"),
        const SizedBox(
          width: 8,
        ),
        buildTimeCard(time: seconds, header: "Detik"),
      ],
    );
  }

  Widget buildTimeCard({required String time, required String header}) =>
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(5),
            ),
            child: AppTextNormal.labelBold(
              time,
              20,
              _oC.time.value <= 10 ? Colors.red : Colors.black,
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          AppTextNormal.labelW600(
            header,
            14,
            Colors.black,
          ),
        ],
      );
}
