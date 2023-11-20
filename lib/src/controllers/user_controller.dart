import 'package:erecruitment/src/models/role_m.dart';
import 'package:erecruitment/src/models/user_m.dart';
import 'package:erecruitment/src/repositories/dashboard_repository.dart';
import 'package:erecruitment/utils/app_constanta_empty.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class UserController extends GetxController {
  final DashboardRepository dashboardRepository = DashboardRepositoryImpl();

  final RxList<RoleM> roles = <RoleM>[].obs;

  final RxList<UserM> users = <UserM>[].obs;

  final RxList<UserM> usersSearch = <UserM>[].obs;

  final Rx<bool> isLoading = true.obs;

  final tcSearch = TextEditingController();

  final Rx<int> page = 1.obs;

  final formKey = GlobalKey<FormState>();

  final tcNama = TextEditingController();
  final tcEmail = TextEditingController();
  final tcPosisi = TextEditingController();
  final tcPassword = TextEditingController();
  final tcRole = TextEditingController();
  final tcStarted = TextEditingController();
  final tcEnded = TextEditingController();

  String startDate = "";
  String endDate = "";

  final Rx<RoleM> selectedRole = roleEmpty.obs;

  @override
  void onInit() async {
    Future.delayed(const Duration(seconds: 1), () async {
      await getAllRole();
      await getAllUser();
      await changeLoading(false);
    });
    super.onInit();
  }

  Future changeLoading(bool newValue) async {
    isLoading.value = newValue;
  }

  Future getAllRole() async {
    roles.value = await dashboardRepository.getAllRole();
  }

  Future getAllUser() async {
    double pageTemp = 0;
    users.value = await dashboardRepository.getAllUsers();
    for (int i = 0; i < users.length; i++) {
      pageTemp = (i + 1) ~/ 8 < 1 ? 1 : (i + 1) / 8;
      users[i] = users[i].copyWith(page: pageTemp.ceil());
    }
  }

  void onChangepage(int value) {
    page.value = value;
  }

  void onSearchUser(String query) {
    double pageTemp = 0;
    List<UserM> usersTemp = [];
    if (query.isEmpty) {
      usersTemp.clear();
      usersSearch.clear();
    } else {
      usersTemp = users
          .where((e) => e.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
      for (int i = 0; i < usersTemp.length; i++) {
        pageTemp = (i + 1) / 2;
        usersTemp[i] = usersTemp[i].copyWith(page: pageTemp.ceil());
      }
      usersSearch.value = usersTemp;
    }
  }

  void selectedDate({
    required DateTime date,
    required int type,
  }) async {
    if (type == 1) {
      tcStarted.text = "${DateFormat.yMMMMd('id').add_Hm().format(date)} WIB";
      startDate = date.toIso8601String();
    } else {
      tcEnded.text = "${DateFormat.yMMMMd('id').add_Hm().format(date)} WIB";
      endDate = date.toIso8601String();
    }
  }

  void createUser() async {
    final response =
        await dashboardRepository.createUser(tcEmail.text, tcPassword.text);
    if (response != null) {
      addUserToFirestore(response);
    }
  }

  void addUserToFirestore(User usr) async {
    final body = {
      "id": usr.uid,
      "email": tcEmail.text,
      "ended": endDate,
      "started": startDate,
      "name": tcNama.text,
      "position": tcPosisi.text,
      "quizes": [],
      "role": selectedRole.value.roleId,
    };
    final response = await dashboardRepository.addUserToFirestore(body);
    Fluttertoast.showToast(msg: response ?? "User berhasil ditambahkan");
    if (response == null) {
      getAllUser();
    }
  }
}
