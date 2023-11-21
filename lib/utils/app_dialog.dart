import 'package:dropdown_search/dropdown_search.dart';
import 'package:erecruitment/src/controllers/dashboard_controller.dart';
import 'package:erecruitment/src/controllers/user_controller.dart';
import 'package:erecruitment/src/models/exam_m.dart';
import 'package:erecruitment/src/models/role_m.dart';
import 'package:erecruitment/src/models/user_m.dart';
import 'package:erecruitment/utils/app_constanta_empty.dart';
import 'package:erecruitment/utils/app_route.dart';
import 'package:erecruitment/utils/app_text_normal.dart';
import 'package:erecruitment/utils/app_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uuid/uuid.dart';

import 'app_color.dart';

class AppDialog {
  static dialogLogout({
    required String title,
    required String subtitle,
    required Function() ontap,
  }) {
    return showDialog(
      context: rootNavigatorKey.currentContext!,
      builder: (context) => AlertDialog(
        title: AppTextNormal.labelW600(
          title,
          16,
          Colors.black,
        ),
        content: AppTextNormal.labelW500(
          subtitle,
          16,
          Colors.grey.shade500,
        ),
        actions: [
          ElevatedButton(
            onPressed: ontap,
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                Colors.red,
              ),
            ),
            child: AppTextNormal.labelBold(
              "Ya",
              16,
              Colors.white,
            ),
          ),
          ElevatedButton(
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(Colors.grey.shade400)),
            onPressed: () => rootNavigatorKey.currentContext!.pop(),
            child: AppTextNormal.labelBold(
              "Batal",
              16,
              Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  static dialogEndQuiz({
    required String title,
    required String subtitle,
    required Function() ontap,
    bool? isFinished,
  }) {
    return showDialog(
      context: rootNavigatorKey.currentContext!,
      builder: (context) => AlertDialog(
        title: AppTextNormal.labelW600(
          title,
          16,
          Colors.black,
        ),
        content: AppTextNormal.labelW500(
          subtitle,
          16,
          Colors.grey.shade500,
        ),
        actions: [
          ElevatedButton(
            onPressed: ontap,
            child: AppTextNormal.labelBold(
              "Kumpulkan",
              16,
              Colors.white,
            ),
          ),
          if (isFinished == true)
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Colors.grey.shade400)),
              onPressed: () => rootNavigatorKey.currentContext!.pop(),
              child: AppTextNormal.labelBold(
                "Batal",
                16,
                Colors.white,
              ),
            ),
        ],
      ),
    );
  }

  static dialogAddTes({
    required DashboardController dC,
  }) {
    final size = MediaQuery.of(rootNavigatorKey.currentContext!).size;
    final formKey = GlobalKey<FormState>();
    final tcNama = TextEditingController();
    final tcTipe = TextEditingController();
    final tcSoal = TextEditingController();
    final tcTime = TextEditingController();

    return showDialog(
      context: rootNavigatorKey.currentContext!,
      builder: (context) => AlertDialog(
        title: AppTextNormal.labelBold(
          "Tambah Tes",
          16,
          Colors.black,
        ),
        content: SizedBox(
          width: size.width / 4,
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                AppTextNormal.labelW600(
                  "Judul",
                  14,
                  Colors.black,
                ),
                const SizedBox(
                  height: 12,
                ),
                TextFormField(
                  controller: tcNama,
                  validator: (val) => AppValidator.requiredField(val!),
                  style: GoogleFonts.poppins(
                    height: 1.4,
                  ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    hintStyle: GoogleFonts.poppins(
                      fontSize: 14,
                      wordSpacing: 4,
                    ),
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                AppTextNormal.labelW600(
                  "Tipe",
                  14,
                  Colors.black,
                ),
                const SizedBox(
                  height: 12,
                ),
                TextFormField(
                  controller: tcTipe,
                  validator: (val) => AppValidator.requiredField(val!),
                  style: GoogleFonts.poppins(
                    height: 1.4,
                  ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    hintStyle: GoogleFonts.poppins(
                      fontSize: 14,
                      wordSpacing: 4,
                    ),
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                AppTextNormal.labelW600(
                  "Jumlah Soal",
                  14,
                  Colors.black,
                ),
                const SizedBox(
                  height: 12,
                ),
                TextFormField(
                  controller: tcSoal,
                  validator: (val) => AppValidator.requiredField(val!),
                  style: GoogleFonts.poppins(
                    height: 1.4,
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    hintStyle: GoogleFonts.poppins(
                      fontSize: 14,
                      wordSpacing: 4,
                    ),
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                AppTextNormal.labelW600(
                  "Waktu",
                  14,
                  Colors.black,
                ),
                const SizedBox(
                  height: 12,
                ),
                TextFormField(
                  controller: tcTime,
                  validator: (val) => AppValidator.requiredField(val!),
                  style: GoogleFonts.poppins(
                    height: 1.4,
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    hintStyle: GoogleFonts.poppins(
                      fontSize: 14,
                      wordSpacing: 4,
                    ),
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 40,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorPrimaryDark,
                    ),
                    onPressed: () {
                      rootNavigatorKey.currentContext!.pop();
                      const Uuid uuid = Uuid();
                      String randomUuid = uuid.v4();

                      final body = {
                        "id": randomUuid,
                        "users": [],
                        "type": tcTipe.text,
                        "title": tcNama.text,
                        "time": int.parse(tcTime.text),
                        "number": int.parse(tcSoal.text),
                        "created": DateTime.now().toIso8601String(),
                        "updated": DateTime.now().toIso8601String(),
                      };
                      dC.addExams(body);
                    },
                    child: AppTextNormal.labelW600(
                      "Simpan",
                      16,
                      Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static dialogAddUser({
    UserM? oldUser,
    bool? isUpdate,
  }) {
    final uC = Get.find<UserController>();
    final size = MediaQuery.of(rootNavigatorKey.currentContext!).size;
    if (oldUser != null) {
      uC.setDataToDialogAddUser(oldUser);
    }

    return showDialog(
      context: rootNavigatorKey.currentContext!,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: AppTextNormal.labelBold(
          "Tambah User",
          16,
          Colors.black,
        ),
        content: SizedBox(
          width: size.width / 1.8,
          child: Form(
            key: uC.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppTextNormal.labelW600(
                            "Nama",
                            14,
                            Colors.black,
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          TextFormField(
                            controller: uC.tcNama,
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
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppTextNormal.labelW600(
                            "Email",
                            14,
                            Colors.black,
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          TextFormField(
                            readOnly: isUpdate ?? false,
                            controller: uC.tcEmail,
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
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppTextNormal.labelW600(
                            "Username",
                            14,
                            Colors.black,
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          TextFormField(
                            controller: uC.tcUsername,
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
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppTextNormal.labelW600(
                            "Posisi",
                            14,
                            Colors.black,
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          TextFormField(
                            controller: uC.tcPosisi,
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
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppTextNormal.labelW600(
                            "Password",
                            14,
                            Colors.black,
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          TextFormField(
                            readOnly: isUpdate ?? false,
                            controller: uC.tcPassword,
                            validator: (val) =>
                                AppValidator.requiredField(val!),
                            style: GoogleFonts.poppins(
                              height: 1.4,
                            ),
                            obscureText: true,
                            decoration: InputDecoration(
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
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppTextNormal.labelW600(
                            "Role",
                            14,
                            Colors.black,
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Obx(
                            () => DropdownSearch<RoleM>(
                              clearButtonProps: ClearButtonProps(
                                  isVisible:
                                      uC.selectedRole.value != roleEmpty),
                              popupProps: PopupProps.menu(
                                showSearchBox: true,
                                searchFieldProps: TextFieldProps(
                                  decoration: InputDecoration(
                                    fillColor: Colors.white,
                                    filled: true,
                                    hintText: "Pilih role...",
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
                                      borderSide: BorderSide(
                                          color: Colors.grey.shade300),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                ),
                              ),
                              asyncItems: (String filter) =>
                                  uC.dashboardRepository.getAllRole(),
                              itemAsString: (RoleM u) => u.roleName,
                              selectedItem: uC.selectedRole.value,
                              onChanged: (RoleM? data) {
                                if (data != null) {
                                  uC.selectedRole.value = data;
                                } else {
                                  uC.selectedRole.value = roleEmpty;
                                }
                              },
                              dropdownDecoratorProps: DropDownDecoratorProps(
                                dropdownSearchDecoration: InputDecoration(
                                  hintText: "Masukkan nama user disini",
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
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppTextNormal.labelW600(
                            "Tanggal Mulai",
                            14,
                            Colors.black,
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          TextFormField(
                            controller: uC.tcStarted,
                            validator: (val) =>
                                AppValidator.requiredField(val!),
                            style: GoogleFonts.poppins(
                              height: 1.4,
                            ),
                            readOnly: true,
                            onTap: () async {
                              final date = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now()
                                      .add(const Duration(days: -365)),
                                  lastDate: DateTime.now()
                                      .add(const Duration(days: 365)));
                              if (date != null) {
                                uC.selectedDate(date: date, type: 1);
                              }
                            },
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            decoration: InputDecoration(
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
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppTextNormal.labelW600(
                            "Tanggal Selesai",
                            14,
                            Colors.black,
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          TextFormField(
                            controller: uC.tcEnded,
                            readOnly: true,
                            validator: (val) =>
                                AppValidator.requiredField(val!),
                            style: GoogleFonts.poppins(
                              height: 1.4,
                            ),
                            onTap: () async {
                              final date = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now()
                                      .add(const Duration(days: -365)),
                                  lastDate: DateTime.now()
                                      .add(const Duration(days: 365)));
                              if (date != null) {
                                uC.selectedDate(date: date, type: 2);
                              }
                            },
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            decoration: InputDecoration(
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
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                AppTextNormal.labelW600(
                  "Pilih Test",
                  14,
                  Colors.black,
                ),
                const SizedBox(
                  height: 12,
                ),
                Obx(
                  () => Row(
                    children: List.generate(
                      uC.listExamID.length,
                      (index) => Chip(
                        backgroundColor: colorPrimaryDark,
                        deleteIconColor: Colors.white,
                        label: AppTextNormal.labelW600(
                          uC.exams
                              .firstWhere((e) => e.id == uC.listExamID[index])
                              .title,
                          12,
                          Colors.white,
                        ),
                        onDeleted: () {
                          uC.listExamID.removeAt(index);
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                SizedBox(
                  height: 40,
                  child: Obx(
                    () => DropdownSearch<ExamM>(
                      clearButtonProps: ClearButtonProps(
                          isVisible: uC.selectedExam.value != examEmpty),
                      popupProps: PopupProps.menu(
                        showSearchBox: true,
                        searchFieldProps: TextFieldProps(
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            hintText: "Pilih test...",
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
                      asyncItems: (String filter) =>
                          uC.menuRepository.getExams(),
                      itemAsString: (ExamM u) => u.title,
                      selectedItem: uC.selectedExam.value,
                      onChanged: (ExamM? data) {
                        if (data != null) {
                          if (!uC.listExamID.contains(data.id)) {
                            uC.listExamID.add(data.id);
                            uC.selectedExam.value = data;
                          }
                        } else {
                          uC.selectedExam.value = examEmpty;
                        }
                      },
                      dropdownDecoratorProps: DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                          hintText: "Masukkan quiz disini",
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
                            borderSide: BorderSide(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 35,
                ),
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        width: double.infinity,
                        height: 40,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey.shade500,
                          ),
                          onPressed: () {
                            rootNavigatorKey.currentContext!.pop();
                            uC.clearTempDataDialogAddUser();
                          },
                          child: AppTextNormal.labelW600(
                            "Batal",
                            16,
                            Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 14,
                    ),
                    Expanded(
                      child: SizedBox(
                        width: double.infinity,
                        height: 40,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: colorPrimaryDark,
                          ),
                          onPressed: () {
                            rootNavigatorKey.currentContext!.pop();
                            if (isUpdate == true) {
                              uC.updateUserToFirestore(oldUser!.id);
                            } else {
                              uC.createUser();
                            }
                          },
                          child: AppTextNormal.labelW600(
                            "Simpan",
                            16,
                            Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static dialogAddUserRole({
    RoleM? oldRole,
    bool? isUpdated,
  }) {
    final uC = Get.find<UserController>();
    final size = MediaQuery.of(rootNavigatorKey.currentContext!).size;
    if (oldRole != null) {
      uC.setDataToDialogAddUserRole(oldRole);
    }

    return showDialog(
      context: rootNavigatorKey.currentContext!,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: AppTextNormal.labelBold(
          "Tambah Role",
          16,
          Colors.black,
        ),
        content: SizedBox(
          width: size.width / 4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              AppTextNormal.labelW600(
                "Role ID",
                14,
                Colors.black,
              ),
              const SizedBox(
                height: 12,
              ),
              TextFormField(
                controller: uC.tcRole,
                validator: (val) => AppValidator.requiredField(val!),
                style: GoogleFonts.poppins(
                  height: 1.4,
                ),
                readOnly: isUpdated ?? false,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: InputDecoration(
                  hintStyle: GoogleFonts.poppins(
                    fontSize: 14,
                    wordSpacing: 4,
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              AppTextNormal.labelW600(
                "Role Name",
                14,
                Colors.black,
              ),
              const SizedBox(
                height: 12,
              ),
              TextFormField(
                controller: uC.tcRoleName,
                validator: (val) => AppValidator.requiredField(val!),
                style: GoogleFonts.poppins(
                  height: 1.4,
                ),
                decoration: InputDecoration(
                  hintStyle: GoogleFonts.poppins(
                    fontSize: 14,
                    wordSpacing: 4,
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(
                height: 35,
              ),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      width: double.infinity,
                      height: 40,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey.shade500,
                        ),
                        onPressed: () {
                          rootNavigatorKey.currentContext!.pop();
                          uC.clearTempDataDialogAddUser();
                        },
                        child: AppTextNormal.labelW600(
                          "Batal",
                          16,
                          Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 14,
                  ),
                  Expanded(
                    child: SizedBox(
                      width: double.infinity,
                      height: 40,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: colorPrimaryDark,
                        ),
                        onPressed: () {
                          if (isUpdated == true) {
                            uC.updateRole(oldRole!.id);
                          } else {
                            uC.addRole();
                          }
                        },
                        child: AppTextNormal.labelW600(
                          "Simpan",
                          16,
                          Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
