import 'package:erecruitment/src/views/widgets/custom_progress_bar.dart';
import 'package:erecruitment/utils/app_color.dart';
import 'package:erecruitment/utils/app_text_normal.dart';
import 'package:flutter/material.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 60,
            color: colorPrimaryDark.withOpacity(0.8),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
              child: GridView.count(
                crossAxisCount: 3,
                mainAxisSpacing: 15,
                crossAxisSpacing: 10,
                childAspectRatio: 1,
                children: List.generate(
                  25,
                  (index) => Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 25),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                            width: 75,
                            height: 75,
                            child: Image.asset("images/man.png")),
                        const SizedBox(
                          height: 18,
                        ),
                        AppTextNormal.labelW600(
                          "6281381161992",
                          14,
                          Colors.grey.shade600,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        AppTextNormal.labelW600(
                          "Riyan Nurdiansyah",
                          16,
                          Colors.black,
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: AppTextNormal.labelW600(
                                "Experimental",
                                12,
                                Colors.grey.shade600,
                              ),
                            ),
                            Expanded(
                              child: CustomProgressBar(
                                width: size.width / 8.55,
                                height: 10,
                                progress: 0.75,
                                radius: 26,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 14,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: AppTextNormal.labelW600(
                                "Mentalitas",
                                12,
                                Colors.grey.shade600,
                              ),
                            ),
                            Expanded(
                              child: CustomProgressBar(
                                width: size.width / 8.55,
                                height: 10,
                                progress: 0.70,
                                radius: 26,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 14,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: AppTextNormal.labelW600(
                                "Loyalitas",
                                12,
                                Colors.grey.shade600,
                              ),
                            ),
                            Expanded(
                              child: CustomProgressBar(
                                width: size.width / 8.55,
                                height: 10,
                                progress: 0.58,
                                radius: 26,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 14,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: AppTextNormal.labelW600(
                                "Kejujuran",
                                12,
                                Colors.grey.shade600,
                              ),
                            ),
                            Expanded(
                              child: CustomProgressBar(
                                width: size.width / 8.55,
                                height: 10,
                                progress: 0.45,
                                radius: 26,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 14,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: AppTextNormal.labelW600(
                                "Leadership",
                                12,
                                Colors.grey.shade600,
                              ),
                            ),
                            Expanded(
                              child: CustomProgressBar(
                                width: size.width / 8.55,
                                height: 10,
                                progress: 0.35,
                                radius: 26,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        SizedBox(
                          height: 30,
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {},
                            child: AppTextNormal.labelBold(
                              "Lihat Detail",
                              14,
                              Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
