import 'dart:async';

import 'package:erecruitment/src/controllers/dashboard_controller.dart';
import 'package:erecruitment/src/models/question_ist_m.dart';
import 'package:erecruitment/src/repositories/ongoing_repository.dart';
import 'package:erecruitment/utils/app_constanta_empty.dart';
import 'package:erecruitment/utils/app_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/exam_m.dart';

class OngoingController extends GetxController {
  final OngoingRepository ongoingRepository = OngoingRepositoryImpl();

  final Rx<bool> isLoading = true.obs;

  Rx<Duration> durations = const Duration().obs;

  final _dC = Get.put(DashboardController());

  final Rx<int> time = 10.obs;

  final Rx<int> maxQuestion = 0.obs;

  final Rx<int> indexQuestion = 0.obs;

  final Rx<int> indexSelectedOption = 99.obs;

  final Rx<ExamM> exams = examEmpty.obs;

  final RxList<QuestionIstM> questionIst = <QuestionIstM>[].obs;

  final RxList<int> answereds = <int>[].obs;

  Timer? timer;

  Timer? timerRedirect;

  @override
  void onInit() async {
    await Future.delayed(const Duration(seconds: 1), () async {
      await getQuestion();
      startTimer();
      generateAnswereds();
      await changeLoading(false);
    });
    super.onInit();
  }

  Future<void> generateAnswereds() async {
    answereds.value = List.filled(maxQuestion.value, 99);
  }

  Future<void> changeLoading(bool val) async {
    isLoading.value = val;
  }

  void reduceTime() {
    time.value = time.value - 1;
    if (time.value < 0) {
      _dC.isStarting.value = false;
      timer?.cancel();
      AppDialog.dialogEndQuiz(
        title: "Waktu pengerjaan habis..!",
        subtitle: "Silahkan klik kumpulkan",
      );
    } else {
      durations.value = Duration(seconds: time.value);
    }
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) => reduceTime());
  }

  Future<void> getQuestion() async {
    if (exams.value.type == "ist") {
      await getQuestionIst();
    }

    if (exams.value.type == "disc") {
      await getQuestionsDisc();
    }
  }

  Future<void> getQuestionIst() async {
    questionIst.value = await ongoingRepository.getQuestionIst(exams.value.id);
    if (questionIst.length < exams.value.number) {
      maxQuestion.value = questionIst.length;
    } else {
      maxQuestion.value = exams.value.number;
    }
  }

  Future<void> getQuestionsDisc() async {}

  Color getColorQuestion(int index) {
    if (indexQuestion.value == index) return Colors.black;

    if (answereds[index] != 99) return Colors.blue;

    return Colors.grey.shade400;
  }

  void onTapQuestion(int index) {
    indexQuestion.value = index;
    indexSelectedOption.value = answereds[indexQuestion.value];
  }

  void selectedOption(int? index) {
    if (index == null) {
      indexSelectedOption.value = 99;
    } else {
      indexSelectedOption.value = index;
    }
    answereds[indexQuestion.value] = index ?? 99;
  }

  void onNextSeri() {
    indexQuestion.value++;
    indexSelectedOption.value = answereds[indexQuestion.value];
  }

  void onBackSeri() {
    indexQuestion.value--;
    indexSelectedOption.value = answereds[indexQuestion.value];
  }
}
