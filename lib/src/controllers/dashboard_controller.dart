import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:erecruitment/src/models/exam_m.dart';
import 'package:erecruitment/src/models/sidebar_m.dart';
import 'package:erecruitment/src/models/user_m.dart';
import 'package:erecruitment/src/repositories/dashboard_repository.dart';
import 'package:erecruitment/src/repositories/menu_repository.dart';
import 'package:erecruitment/utils/app_constanta_empty.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quill_html_editor/quill_html_editor.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../repositories/auth_repository.dart';

class DashboardController extends GetxController {
  late SharedPreferences prefs;

  final MenuRepository menuRepository = MenuRepositoryImpl();

  final DashboardRepository dashboardRepository = DashboardRepositoryImpl();

  final AuthRepository authRepository = AuthRepositoryImpl();

  final RxList<SidebarM> sidebars = <SidebarM>[].obs;

  final RxList<ExamM> exams = <ExamM>[].obs;

  final Rx<UserM> user = userEmpty.obs;

  final Rx<bool> isStarting = false.obs;

  late QuillEditorController controller;

  final customToolBarList = [
    ToolBarStyle.bold,
    ToolBarStyle.italic,
    ToolBarStyle.align,
    ToolBarStyle.color,
    ToolBarStyle.background,
    ToolBarStyle.listBullet,
    ToolBarStyle.listOrdered,
    ToolBarStyle.addTable,
    ToolBarStyle.editTable,
    ToolBarStyle.link,
    ToolBarStyle.underline,
    ToolBarStyle.size,
  ];

  @override
  void onInit() async {
    prefs = await SharedPreferences.getInstance();
    controller = QuillEditorController();
    controller.onTextChanged((text) {
      debugPrint('listening to $text');
    });
    controller.onEditorLoaded(() {
      debugPrint('Editor Loaded :)');
    });
    await getUserDetail();
    getMenus();
    // getExams();
    super.onInit();
  }

  Future<void> getUserDetail() async {
    final data =
        await authRepository.getUser(prefs.getString("username") ?? "");
    if (data != null) {
      user.value = data;
    }
  }

  Stream<List<ExamM>> streamExamForAdmin() {
    Stream<QuerySnapshot<Map<String, dynamic>>> stream =
        FirebaseFirestore.instance.collection("exam").snapshots();
    return stream.map((e) => e.docs).map((ev) {
      exams.value =
          examsMFromJson(json.encode(ev.map((e) => e.data()).toList()));
      exams.sort(((a, b) => a.title.compareTo(b.title)));
      return exams;
    });
  }

  Stream<List<ExamM>> streamExam() {
    Stream<QuerySnapshot<Map<String, dynamic>>> stream =
        FirebaseFirestore.instance.collection("exam").snapshots();
    return stream.map((e) => e.docs).map((ev) {
      exams.value =
          examsMFromJson(json.encode(ev.map((e) => e.data()).toList()));

      exams.value =
          exams.where((e) => user.value.quizes.contains(e.id)).toList();
      exams.sort(((a, b) => a.title.compareTo(b.title)));
      return exams;
    });
  }

  void getMenus() async {
    sidebars.value = await menuRepository.getMenus(prefs.getInt("role") ?? 99);
  }

  void getExams() async {
    final data = await menuRepository.getExams();

    exams.value = data.where((e) => user.value.quizes.contains(e.id)).toList();
  }

  void addExams(Map<String, dynamic> body) async {
    await dashboardRepository.addTest(body);
  }
}
