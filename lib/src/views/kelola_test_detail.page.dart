import 'package:erecruitment/src/controllers/test_controller.dart';
import 'package:erecruitment/src/models/question_m.dart';
import 'package:erecruitment/utils/app_constanta_empty.dart';
import 'package:erecruitment/utils/app_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/app_color.dart';
import '../../utils/app_text_normal.dart';
import '../../utils/app_validator.dart';
import 'widgets/custom_pagination.dart';

class KelolaTestDetailPage extends StatelessWidget {
  KelolaTestDetailPage({super.key});

  final _tC = Get.find<TestController>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: Obx(
        () {
          if (_tC.isLoading.value) {
            return Center(
              child: Container(
                alignment: Alignment.center,
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: colorPrimaryDark,
                ),
                child: const CupertinoActivityIndicator(
                  color: Colors.white,
                ),
              ),
            );
          }

          if (_tC.exam.value == examEmpty) {
            return const SizedBox();
          }

          return Column(
            children: [
              Container(
                width: double.infinity,
                height: 60,
                color: colorPrimaryDark.withOpacity(0.8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      width: 14,
                    ),
                    IconButton(
                      onPressed: () => context.pop(),
                      icon: const Icon(
                        Icons.close_rounded,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      width: 14,
                    ),
                    Text(
                      _tC.exam.value.title,
                      style: GoogleFonts.sourceCodePro(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 3,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Obx(
                          () {
                            if (_tC.questions.isEmpty) {
                              return const SizedBox();
                            }

                            List<QuestionsM> questions = [];
                            if (_tC.questionsSearch.isNotEmpty ||
                                _tC.tcSearch.text.isNotEmpty) {
                              questions = _tC.questionsSearch
                                  .where((e) => e.page == _tC.page.value)
                                  .toList();
                            } else {
                              questions = _tC.questions
                                  .where((e) => e.page == _tC.page.value)
                                  .toList();
                            }

                            return Column(
                              children: List.generate(
                                questions.length,
                                (index) => Container(
                                  width: double.infinity,
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 14),
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.white,
                                  ),
                                  child: Column(
                                    children: [
                                      Stack(
                                        children: [
                                          Center(
                                            child: AppTextNormal.labelW600(
                                              questions[index]
                                                  .question
                                                  .toUpperCase(),
                                              18,
                                              Colors.black,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 60),
                                            child: Align(
                                              alignment: Alignment.centerRight,
                                              child: InkWell(
                                                onTap: () {
                                                  AppDialog.dialogLogout(
                                                    title: "Hapus",
                                                    subtitle:
                                                        "Yakin ingin menghapus data ini ${questions[index].question}? ",
                                                    ontap: () {
                                                      context.pop();
                                                      _tC.deleteQuestionIST(
                                                          questions[index].id);
                                                    },
                                                  );
                                                },
                                                child: const Icon(
                                                  Icons.delete_rounded,
                                                  color: Colors.red,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 16),
                                            child: Align(
                                              alignment: Alignment.centerRight,
                                              child: InkWell(
                                                onTap: () {
                                                  _tC.editQuestion(
                                                      questions[index]);
                                                },
                                                child: const Icon(
                                                  Icons.edit_document,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Container(
                                        height: 4,
                                        color: Colors.grey.shade200,
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Column(
                                        children: List.generate(
                                          questions[index].options.length,
                                          (innerIndex) => InkWell(
                                            onTap: () {},
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 12,
                                                      horizontal: 16),
                                              child: Row(
                                                children: [
                                                  if (questions[index]
                                                      .options[innerIndex]
                                                      .answer)
                                                    const Icon(
                                                      Icons.check_rounded,
                                                      color: Colors.green,
                                                    ),
                                                  if (!questions[index]
                                                      .options[innerIndex]
                                                      .answer)
                                                    const Icon(
                                                      Icons.close_rounded,
                                                      color: Colors.red,
                                                    ),
                                                  const SizedBox(
                                                    width: 16,
                                                  ),
                                                  AppTextNormal.labelW600(
                                                    questions[index]
                                                        .options[innerIndex]
                                                        .teks,
                                                    16,
                                                    Colors.black,
                                                  ),
                                                  const Spacer(),
                                                  AppTextNormal.labelW600(
                                                    "${questions[index].options[innerIndex].point} point",
                                                    14,
                                                    Colors.grey,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.only(left: 12),
                              height: 45,
                              width: size.width / 2.8,
                              child: TextFormField(
                                controller: _tC.tcSearch,
                                onChanged: _tC.onSearch,
                                style: GoogleFonts.poppins(
                                  height: 1.4,
                                ),
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                decoration: InputDecoration(
                                  hintText: "Cari pertanyaanmu disini..",
                                  fillColor: Colors.white,
                                  filled: true,
                                  hintStyle: GoogleFonts.poppins(
                                    fontSize: 14,
                                    wordSpacing: 4,
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 12),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.grey.shade300),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ),
                            ),
                            const Spacer(),
                            Obx(() {
                              List<QuestionsM> questions = [];
                              if (_tC.questionsSearch.isNotEmpty ||
                                  _tC.tcSearch.text.isNotEmpty) {
                                questions = _tC.questionsSearch;
                              } else {
                                questions = _tC.questions;
                              }
                              return CustomPagination(
                                currentPage: _tC.page.value,
                                totalPage: (questions.length / 2).ceil(),
                                onPageChanged: _tC.onChangePage,
                                displayItemCount: 1,
                              );
                            }),
                            const SizedBox(
                              width: 10,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      margin: const EdgeInsets.only(
                          top: 20, bottom: 14, right: 20, left: 6),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
                      ),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 15,
                          ),
                          AppTextNormal.labelW600(
                            "FORM PERTANYAAN",
                            18,
                            Colors.black,
                          ),
                          const SizedBox(
                            height: 18,
                          ),
                          Container(
                            height: 4,
                            color: Colors.grey.shade200,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 20,
                                ),
                                AppTextNormal.labelW600(
                                  "Pertanyaan",
                                  18,
                                  Colors.black,
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                SizedBox(
                                  height: 40,
                                  child: TextFormField(
                                    controller: _tC.tcOptionQuestion,
                                    validator: (val) =>
                                        AppValidator.requiredField(val!),
                                    style: GoogleFonts.poppins(
                                      height: 1.4,
                                    ),
                                    decoration: InputDecoration(
                                      hintStyle: GoogleFonts.poppins(
                                        fontSize: 14,
                                        wordSpacing: 4,
                                      ),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 0, horizontal: 12),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey.shade300),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                AppTextNormal.labelW600(
                                  "Options",
                                  18,
                                  Colors.black,
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                SizedBox(
                                  height: 50,
                                  width: double.infinity,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: SizedBox(
                                          height: 40,
                                          child: TextFormField(
                                            controller: _tC.tcOptionTitle,
                                            validator: (val) =>
                                                AppValidator.requiredField(
                                                    val!),
                                            style: GoogleFonts.poppins(
                                              height: 1.4,
                                            ),
                                            decoration: InputDecoration(
                                              hintStyle: GoogleFonts.poppins(
                                                fontSize: 14,
                                                wordSpacing: 4,
                                              ),
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 0,
                                                      horizontal: 12),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color:
                                                        Colors.grey.shade300),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 12,
                                      ),
                                      SizedBox(
                                        height: 40,
                                        width: 70,
                                        child: TextFormField(
                                          controller: _tC.tcOptionPoint,
                                          validator: (val) =>
                                              AppValidator.requiredField(val!),
                                          style: GoogleFonts.poppins(
                                            height: 1.4,
                                          ),
                                          keyboardType: TextInputType.number,
                                          inputFormatters: [
                                            FilteringTextInputFormatter
                                                .digitsOnly
                                          ],
                                          decoration: InputDecoration(
                                            hintText: "Point",
                                            hintStyle: GoogleFonts.poppins(
                                              fontSize: 14,
                                              wordSpacing: 4,
                                            ),
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    vertical: 0,
                                                    horizontal: 12),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey.shade300),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 12,
                                      ),
                                      SizedBox(
                                        height: 36,
                                        child: ElevatedButton(
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    colorPrimaryDark),
                                          ),
                                          onPressed: () =>
                                              _tC.addToListOption(),
                                          child: AppTextNormal.labelBold(
                                            "Tambah",
                                            14,
                                            Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Obx(
                                  () => Column(
                                    children: List.generate(
                                      _tC.optionsIst.length,
                                      (index) => Column(
                                        children: [
                                          Row(
                                            children: [
                                              Checkbox(
                                                activeColor: colorPrimaryDark,
                                                value: _tC
                                                    .optionsIst[index].answer,
                                                onChanged: (val) =>
                                                    _tC.onCheckOptionIst(
                                                        index, val!),
                                              ),
                                              const SizedBox(
                                                width: 16,
                                              ),
                                              AppTextNormal.labelW600(
                                                _tC.optionsIst[index].teks,
                                                16,
                                                Colors.black,
                                              ),
                                              const SizedBox(
                                                width: 14,
                                              ),
                                              AppTextNormal.labelW400(
                                                "${_tC.optionsIst[index].point} point",
                                                14,
                                                Colors.grey,
                                              ),
                                              const Spacer(),
                                              IconButton(
                                                onPressed: () => _tC
                                                    .deleteListOptionIst(index),
                                                icon: const Icon(
                                                  Icons.close_rounded,
                                                ),
                                              ),
                                            ],
                                          ),
                                          if (index !=
                                              (_tC.optionsIst.length + 1))
                                            const SizedBox(
                                              height: 8,
                                            ),
                                          if (index !=
                                              (_tC.optionsIst.length + 1))
                                            Container(
                                              height: 2,
                                              color: Colors.grey.shade200,
                                            ),
                                          if (index !=
                                              (_tC.optionsIst.length + 1))
                                            const SizedBox(
                                              height: 8,
                                            ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  height: 50,
                                  child: Row(
                                    children: [
                                      Obx(() {
                                        if (!_tC.isEdited.value) {
                                          return const SizedBox();
                                        }

                                        return Expanded(
                                          child: Container(
                                            padding: const EdgeInsets.only(
                                                right: 14),
                                            width: double.infinity,
                                            height: 40,
                                            child: ElevatedButton(
                                              style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all(
                                                  Colors.grey.shade400,
                                                ),
                                              ),
                                              onPressed: () => _tC.cancelEdit(),
                                              child: AppTextNormal.labelBold(
                                                "Batal Ubah",
                                                16,
                                                Colors.white,
                                              ),
                                            ),
                                          ),
                                        );
                                      }),
                                      Expanded(
                                        child: SizedBox(
                                          width: double.infinity,
                                          height: 40,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              if (_tC.isEdited.value) {
                                                _tC.updateQuestionIst();
                                              } else {
                                                _tC.addQuestionIst();
                                              }
                                            },
                                            child: AppTextNormal.labelBold(
                                              "Simpan",
                                              16,
                                              Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 35,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          );
        },
      ),
    );
  }
}
