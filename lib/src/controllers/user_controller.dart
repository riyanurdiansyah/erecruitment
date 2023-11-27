import 'package:erecruitment/src/models/exam_m.dart';
import 'package:erecruitment/src/models/role_m.dart';
import 'package:erecruitment/src/models/user_m.dart';
import 'package:erecruitment/src/repositories/dashboard_repository.dart';
import 'package:erecruitment/src/repositories/menu_repository.dart';
import 'package:erecruitment/utils/app_constanta_empty.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import '../../utils/app_route.dart';

class UserController extends GetxController {
  final DashboardRepository dashboardRepository = DashboardRepositoryImpl();

  final MenuRepository menuRepository = MenuRepositoryImpl();

  final RxList<RoleM> roles = <RoleM>[].obs;

  final RxList<RoleM> rolesSearch = <RoleM>[].obs;

  final RxList<UserM> users = <UserM>[].obs;

  final RxList<UserM> usersSearch = <UserM>[].obs;

  final RxList<ExamM> exams = <ExamM>[].obs;

  final RxList<String> listExamID = <String>[].obs;

  final Rx<bool> isLoading = true.obs;

  final tcSearch = TextEditingController();

  final Rx<int> page = 1.obs;

  final formKey = GlobalKey<FormState>();

  final formKeyRole = GlobalKey<FormState>();

  final tcNama = TextEditingController();
  final tcUsername = TextEditingController();
  final tcEmail = TextEditingController();
  final tcPosisi = TextEditingController();
  final tcPassword = TextEditingController();
  final tcRole = TextEditingController();
  final tcStarted = TextEditingController();
  final tcEnded = TextEditingController();
  final tcRoleName = TextEditingController();

  String startDate = "";
  String endDate = "";

  final Rx<RoleM> selectedRole = roleEmpty.obs;

  final Rx<ExamM> selectedExam = examEmpty.obs;

  @override
  void onInit() async {
    Future.delayed(const Duration(seconds: 1), () async {
      await getAllRole();
      await getAllUser();
      await getAllExam();
      await changeLoading(false);
    });
    super.onInit();
  }

  Future changeLoading(bool newValue) async {
    isLoading.value = newValue;
  }

  Future getAllExam() async {
    exams.value = await menuRepository.getExams();
  }

  Future getAllRole() async {
    double pageTemp = 0;
    roles.value = await dashboardRepository.getAllRole();
    for (int i = 0; i < roles.length; i++) {
      pageTemp = (i + 1) ~/ 8 < 1 ? 1 : (i + 1) / 8;
      roles[i] = roles[i].copyWith(page: pageTemp.ceil());
    }
    roles.sort((a, b) => a.roleId.compareTo(b.roleId));
  }

  Future getAllUser() async {
    double pageTemp = 0;
    users.value = await dashboardRepository.getAllUsers();
    for (int i = 0; i < users.length; i++) {
      pageTemp = (i + 1) ~/ 8 < 1 ? 1 : (i + 1) / 8;
      users[i] = users[i].copyWith(page: pageTemp.ceil());
    }
    users.value = users.where((e) => e.role != 0).toList();
    users.sort((a, b) => a.name.compareTo(b.name));
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
          .where((e) =>
              e.name.toLowerCase().contains(query.toLowerCase()) ||
              e.email.toLowerCase().contains(query.toLowerCase()) ||
              e.position.toLowerCase().contains(query.toLowerCase()) ||
              e.username.toLowerCase().contains(query.toLowerCase()))
          .toList();
      for (int i = 0; i < usersTemp.length; i++) {
        pageTemp = (i + 1) / 8;
        usersTemp[i] = usersTemp[i].copyWith(page: pageTemp.ceil());
      }
      usersSearch.value = usersTemp.where((e) => e.role != 0).toList();
      usersSearch.sort((a, b) => a.name.compareTo(b.name));
    }
  }

  void onSearchUserRole(String query) {
    double pageTemp = 0;
    List<RoleM> rolesTemp = [];
    if (query.isEmpty) {
      rolesTemp.clear();
      rolesSearch.clear();
    } else {
      rolesTemp = roles
          .where((e) => e.roleName.toLowerCase().contains(query.toLowerCase()))
          .toList();
      for (int i = 0; i < rolesTemp.length; i++) {
        pageTemp = (i + 1) / 8;
        rolesTemp[i] = rolesTemp[i].copyWith(page: pageTemp.ceil());
      }
      rolesSearch.value = rolesTemp;
    }
  }

  void setDataToDialogAddUser(UserM oldUser) {
    listExamID.value = List<String>.from(oldUser.quizes.map((e) => e));
    tcNama.text = oldUser.name;
    tcEmail.text = oldUser.email;
    tcPosisi.text = oldUser.position;
    tcRole.text = roles.firstWhere((e) => e.roleId == oldUser.role).roleName;
    selectedRole.value = roles.firstWhere((e) => e.roleId == oldUser.role);
    tcStarted.text =
        "${DateFormat.yMMMMd('id').add_Hm().format(DateTime.parse(oldUser.started))} WIB";
    tcEnded.text =
        "${DateFormat.yMMMMd('id').add_Hm().format(DateTime.parse(oldUser.ended))} WIB";
    startDate = oldUser.started;
    endDate = oldUser.ended;
    tcUsername.text = oldUser.username;
  }

  void setDataToDialogAddUserRole(RoleM oldRole) {
    tcRole.text = oldRole.roleId.toString();
    tcRoleName.text = oldRole.roleName;
  }

  void clearTempDataDialogAddUser() {
    tcNama.clear();
    tcEmail.clear();
    tcPosisi.clear();
    tcRole.clear();
    selectedRole.value = roleEmpty;
    tcStarted.clear();
    tcEnded.clear();
    startDate = "";
    endDate = "";
    tcUsername.clear();
    tcRoleName.clear();
    listExamID.clear();
    selectedRole.value = roleEmpty;
    selectedExam.value = examEmpty;
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
      sendEmail();
    }
  }

  void sendEmail() async {
    final body = {
      "password": tcPassword.text,
      "username": tcUsername.text,
      "receiver": tcEmail.text,
      "name": tcNama.text,
    };

    final response = await dashboardRepository.sendMail(body);
    if (response != null) {
      ///handle error send email
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
      "quizes": listExamID.map((e) => e).toList(),
      "role": selectedRole.value.roleId,
      "username": tcUsername.text,
      "status": true,
    };
    final response = await dashboardRepository.addUserToFirestore(body);
    Fluttertoast.showToast(
        msg: response ?? "User berhasil ditambahkan",
        gravity: ToastGravity.BOTTOM);
    if (response == null) {
      for (int i = 0; i < listExamID.length; i++) {
        addUserToExam(usr.uid, listExamID[i]);
      }
      clearTempDataDialogAddUser();
      getAllUser();
    }
  }

  void updateUserToFirestore(String id) async {
    final body = {
      "id": id,
      "email": tcEmail.text,
      "ended": endDate,
      "started": startDate,
      "name": tcNama.text,
      "position": tcPosisi.text,
      "quizes": listExamID.map((e) => e).toList(),
      "role": selectedRole.value.roleId,
      "username": tcUsername.text,
    };
    final response = await dashboardRepository.updateUserToFirestore(body);
    Fluttertoast.showToast(
        msg: response ?? "User berhasil diubah", gravity: ToastGravity.BOTTOM);
    if (response == null) {
      for (int i = 0; i < listExamID.length; i++) {
        addUserToExam(id, listExamID[i]);
      }
      clearTempDataDialogAddUser();
      getAllUser();
    }
  }

  void addRole() async {
    final cekRoles = roles.where((e) => e.roleId == int.parse(tcRole.text));
    if (cekRoles.isEmpty) {
      const Uuid uuid = Uuid();
      String randomUuid = uuid.v4();
      final body = {
        "id": randomUuid,
        "role_id": int.parse(tcRole.text),
        "created": DateTime.now().toIso8601String(),
        "updated": DateTime.now().toIso8601String(),
        "role_name": tcRoleName.text,
        "status": true,
      };
      await dashboardRepository.addRole(body).then((value) {
        Fluttertoast.showToast(
            msg: value ?? "User berhasil ditambahkan",
            gravity: ToastGravity.BOTTOM);
        if (value == null) {
          rootNavigatorKey.currentContext!.pop();
          getAllRole();
        }
      });
    } else {
      Fluttertoast.showToast(
          msg: "Role ID sudah terdaftar", gravity: ToastGravity.BOTTOM);
    }
  }

  void updateRole(String id) async {
    final body = {
      "id": id,
      "role_id": int.parse(tcRole.text),
      "updated": DateTime.now().toIso8601String(),
      "role_name": tcRoleName.text,
      "status": true,
    };
    await dashboardRepository.updateRole(body).then((value) {
      Fluttertoast.showToast(
          msg: value ?? "User berhasil diubah", gravity: ToastGravity.BOTTOM);
      if (value == null) {
        rootNavigatorKey.currentContext!.pop();
        getAllRole();
      }
    });
  }

  void addUserToExam(String userId, String examId) async {
    List<String> tempUserExam = [];
    final oldExam = await dashboardRepository.getExam(examId);
    if (oldExam != null) {
      tempUserExam = List<String>.from(oldExam.users.map((e) => e)).toList();
      if (!tempUserExam.contains(userId)) {
        tempUserExam.add(userId);
        final body = {
          "id": examId,
          "updated": DateTime.now().toIso8601String(),
          "users": tempUserExam.map((e) => e).toList(),
        };
        await dashboardRepository.updateExamAddedUSer(body);
      }
    }
  }
}
