import 'dart:async';

import 'package:camera/camera.dart';
import 'package:erecruitment/src/controllers/dashboard_controller.dart';
import 'package:erecruitment/src/models/question_m.dart';
import 'package:erecruitment/src/repositories/ongoing_repository.dart';
import 'package:erecruitment/utils/app_constanta_empty.dart';
import 'package:erecruitment/utils/app_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../utils/app_route.dart';
import '../../utils/app_route_name.dart';
import '../models/exam_m.dart';

class OngoingController extends GetxController {
  final OngoingRepository ongoingRepository = OngoingRepositoryImpl();

  final Rx<bool> isLoading = true.obs;

  final Rx<bool> isRecording = false.obs;

  Rx<Duration> durations = const Duration().obs;

  final _dC = Get.put(DashboardController());

  final Rx<int> time = 10.obs;

  final Rx<int> maxQuestion = 0.obs;

  final Rx<int> indexQuestion = 0.obs;

  final Rx<int> indexSelectedOption = 99.obs;

  final Rx<ExamM> exams = examEmpty.obs;

  final RxList<QuestionsM> questionIst = <QuestionsM>[].obs;

  final RxList<int> answereds = <int>[].obs;

  final Rx<String> msgLoading = "".obs;

  Timer? timer;

  Timer? timerPermission;

  late CameraController cameraController;

  final Rx<bool> grantedPermission = false.obs;

  @override
  void onInit() async {
    await Future.delayed(const Duration(seconds: 1), () async {
      await setup();
      await changeLoading(false);
    });
    super.onInit();
  }

  Future addTempQuestion() async {}

  Future setup() async {
    await initCamera();
    await getQuestion();
    startTimer();
    generateAnswereds();
    recordVideo();
  }

  // void streamPermission() {
  //   timerPermission =
  //       Timer.periodic(const Duration(seconds: 1), (_) => checkPermission());
  // }

  Future addTempDataSubmit() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final body = {
      "uid": uid,
      "exam_type": exams.value.type,
      "exam_id": exams.value.id,
      "is_finished": false,
      "time": time.value,
      "created": DateTime.now().toIso8601String(),
      "updated": DateTime.now().toIso8601String(),
    };
    await ongoingRepository.addDataSubmit(body);
  }

  // Future<bool> checkPermission() async {
  // final permCamera = await window.navigator.permissions!.query(
  //   {
  //     "name": "camera",
  //   },
  // );
  // final perMic = await window.navigator.permissions!.query(
  //   {
  //     "name": "microphone",
  //   },
  // );

  // if (permCamera.state == "denied" || perMic.state == "denied") {
  //   grantedPermission.value = false;
  //   return false;
  // } else {
  //   timerPermission?.cancel();
  //   grantedPermission.value = true;
  //   return true;
  // }
  // }

  Future initCamera() async {
    try {
      final cameras = await availableCameras();
      // final front = cameras.firstWhere(
      //     (camera) => camera.lensDirection == CameraLensDirection.front);
      cameraController = CameraController(cameras[0], ResolutionPreset.max,
          enableAudio: false);
      await cameraController.initialize();
    } catch (e) {
      print("ERROR Q ${e.toString()}");
    }
  }

  Future recordVideo() async {
    try {
      if (isRecording.value) {
        if (kDebugMode) {
          print("ON STOPPED");
        }
        changeLoading(true);
        final file = await cameraController.stopVideoRecording();
        await uploadVideoRecorded(file);
        isRecording.value = false;
      } else {
        if (kDebugMode) {
          print("ON RECORDED");
        }
        await cameraController.prepareForVideoRecording();
        await cameraController.startVideoRecording();
        isRecording.value = true;
      }
    } catch (e) {
      print("ERROR RECORD : ${e.toString()}");
    }
  }

  Future uploadVideoRecorded(XFile file) async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final response =
        await ongoingRepository.uploadVideo(file, exams.value.type);
    if (response != null) {
      final body = {
        "uid": uid,
        "video": response,
        "exam_type": exams.value.type,
        "exam_id": exams.value.id,
        "is_finished": true,
        "created": DateTime.now().toIso8601String(),
        "updated": DateTime.now().toIso8601String(),
      };
      final responseAddData = await ongoingRepository.addDataSubmit(body);
      if (responseAddData != null) {
        await ongoingRepository
            .deleteVideo("video/${exams.value.type}/$uid.mp4");
      } else {
        final bodyQuiz = {
          "exam_id": exams.value.id,
          "uid": uid,
        };
        await ongoingRepository.changeStatusQuizUser(bodyQuiz);
        Future.delayed(Duration.zero, () {
          rootNavigatorKey.currentContext!.goNamed(AppRouteName.test);
        });
      }
    } else {
      changeLoading(false);
    }
  }

  Future<void> generateAnswereds() async {
    answereds.value = List.filled(maxQuestion.value, 99);
  }

  Future<void> changeLoading(bool val) async {
    isLoading.value = val;
  }

  Future<void> finishedQuiz({bool? isFinished}) async {
    changeLoadingIsStarting(false);
    timer?.cancel();
    AppDialog.dialogEndQuiz(
      title: isFinished == null
          ? "Waktu pengerjaan habis..!"
          : "Yakin ingin mengumpulkan sekarang?",
      subtitle: "Silahkan klik kumpulkan",
      ontap: () async {
        rootNavigatorKey.currentContext!.pop();
        msgLoading.value = "Sedang mengunggah data...";
        changeLoading(true);
        await recordVideo();
      },
      isFinished: isFinished,
    );
  }

  void changeLoadingIsStarting(bool val) {
    _dC.isStarting.value = val;
  }

  void reduceTime() {
    time.value = time.value - 1;
    if (time.value < 0) {
      finishedQuiz();
    } else {
      durations.value = Duration(seconds: time.value);
    }
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) => reduceTime());
  }

  Future<void> getQuestion() async {
    if (exams.value.type == "multiple_choice") {
      await getQuestionIst();
    }

    if (exams.value.type == "disc") {
      await getQuestionsDisc();
    }

    await addTempQuestion();
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

    // if (answereds[index] != 99) return Colors.blue;

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
    addTempDataSubmit();
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
