import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:erecruitment/src/models/exam_m.dart';
import 'package:erecruitment/src/models/sidebar_m.dart';
import 'package:erecruitment/src/models/user_m.dart';
import 'package:erecruitment/src/repositories/dashboard_repository.dart';
import 'package:erecruitment/src/repositories/menu_repository.dart';
import 'package:erecruitment/utils/app_constanta_empty.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../repositories/auth_repository.dart';

class DashboardController extends GetxController {
  late SharedPreferences prefs;

  final MenuRepository menuRepository = MenuRepositoryImpl();

  final DashboardRepository dashboardRepository = DashboardRepositoryImpl();

  final AuthRepository authRepository = AuthRepositoryImpl();

  final RxList<SidebarM> sidebars = <SidebarM>[].obs;

  final RxList<ExamM> exams = <ExamM>[].obs;

  final RxList<ExamM> subexams = <ExamM>[].obs;

  final Rx<UserM> user = userEmpty.obs;

  final Rx<int> role = 99.obs;

  final Rx<bool> isStarting = false.obs;

  @override
  void onInit() async {
    prefs = await SharedPreferences.getInstance();
    role.value = prefs.getInt("role") ?? 99;
    await getUserDetail();
    getMenus();
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
    return dashboardRepository.streamExamForAdmin().map((event) {
      exams.value = event;
      return exams;
    });
  }

  Stream<List<ExamM>> streamSubExamForAdmin(String id) {
    return dashboardRepository.streamSubExamForAdmin(id).map((event) {
      subexams.value = event;
      return subexams;
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

  Future getMenus() async {
    sidebars.clear();
    sidebars.value = await menuRepository.getMenus(role.value);
  }

  Future getExams() async {
    final data = await menuRepository.getExams();

    exams.value = data.where((e) => user.value.quizes.contains(e.id)).toList();
  }

  void addExams(Map<String, dynamic> body) async {
    final response = await dashboardRepository.addTest(body);
    if (response != null) {
      Fluttertoast.showToast(
          msg: "Gagal menambahkan data", gravity: ToastGravity.BOTTOM);
    }
  }

  void deleteExams(String id) async {
    final response = await dashboardRepository.deleteTest(id);
    if (response != null) {
      Fluttertoast.showToast(
          msg: "Gagal menghapus data", gravity: ToastGravity.BOTTOM);
    }
  }

  Future signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
