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
      body: Column(
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
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 25,
                          childAspectRatio: 1,
                          mainAxisExtent: 30,
                          crossAxisSpacing: 6,
                        ),
                        itemCount: _oC.maxQuestion.value,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: _oC.indexQuestion.value == index
                                ? null
                                : () => _oC.onTapQuestion(index),
                            child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: _oC.getColorQuestion(index),
                              ),
                              child: AppTextNormal.labelBold(
                                "${index + 1}",
                                14,
                                Colors.white,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: buildTime(),
                    ),
                  ),
                ],
              ),
            );
          }),
          Expanded(
            child: Obx(() {
              if (_oC.exams.value.type == "ist" && _oC.questionIst.isNotEmpty) {
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
                        _oC.questionIst[_oC.indexQuestion.value].options.length,
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
                      height: 35,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Obx(() {
                          if (_oC.answereds.contains(99) == true) {
                            return const SizedBox();
                          }

                          return Row(
                            children: [
                              SizedBox(
                                width: 150,
                                height: 45,
                                child: ElevatedButton(
                                  onPressed: () {},
                                  child: AppTextNormal.labelW600(
                                    "Kumpulkan",
                                    16,
                                    Colors.white,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 16,
                              ),
                            ],
                          );
                        }),
                        InkWell(
                          onTap: _oC.answereds[_oC.indexQuestion.value] == 99
                              ? null
                              : () => _oC.onBackSeri(),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 12,
                              horizontal: 16,
                            ),
                            child: AppTextNormal.labelW600(
                              "Sebelumnya",
                              16,
                              Colors.black,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        InkWell(
                          onTap: _oC.answereds[_oC.indexQuestion.value] == 99
                              ? null
                              : () {
                                  if ((_oC.indexQuestion.value + 1) !=
                                      _oC.maxQuestion.value) {
                                    _oC.onNextSeri();
                                  } else {
                                    print(_oC.answereds);
                                  }
                                },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 12,
                              horizontal: 16,
                            ),
                            child: AppTextNormal.labelW600(
                              "Selanjutnya",
                              16,
                              Colors.black,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                      ],
                    ),
                  ],
                );
              }

              return const SizedBox();
            }),
          )
        ],
      ),
    );
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
