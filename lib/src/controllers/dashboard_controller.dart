import 'package:erecruitment/src/models/exam_m.dart';
import 'package:erecruitment/src/models/sidebar_m.dart';
import 'package:erecruitment/src/models/user_m.dart';
import 'package:erecruitment/src/repositories/menu_repository.dart';
import 'package:erecruitment/utils/app_constanta_empty.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../repositories/auth_repository.dart';

class DashboardController extends GetxController {
  late SharedPreferences prefs;

  final MenuRepository menuRepository = MenuRepositoryImpl();

  final AuthRepository authRepository = AuthRepositoryImpl();

  final RxList<SidebarM> sidebars = <SidebarM>[].obs;

  final RxList<ExamM> exams = <ExamM>[].obs;

  final Rx<UserM> user = userEmpty.obs;

  final Rx<bool> isStarting = false.obs;
  @override
  void onInit() async {
    prefs = await SharedPreferences.getInstance();
    await getUserDetail();
    getMenus();
    getExams();
    super.onInit();
  }

  Future<void> getUserDetail() async {
    final data =
        await authRepository.getUser(prefs.getString("username") ?? "");
    if (data != null) {
      user.value = data;
    }
  }

  void getMenus() async {
    sidebars.value = await menuRepository.getMenus(prefs.getInt("role") ?? 99);
  }

  void getExams() async {
    final data = await menuRepository.getExams();

    exams.value = data.where((e) => user.value.quizes.contains(e.id)).toList();
  }
}
