import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quill_html_editor/quill_html_editor.dart';

import '../../../utils/app_color.dart';
import '../../../utils/app_constanta.dart';
import '../../../utils/app_constanta_empty.dart';
import '../../../utils/app_text_normal.dart';
import '../../../utils/app_validator.dart';
import '../../controllers/test_controller.dart';
import '../../models/user_m.dart';
import 'custom_pagination.dart';

class InfoDetailExamPage extends StatelessWidget {
  InfoDetailExamPage({super.key});

  final _tC = Get.find<TestController>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppTextNormal.labelW600(
                        "Nama Test",
                        18,
                        Colors.black,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      SizedBox(
                        height: 40,
                        child: TextFormField(
                          controller: _tC.tcNama,
                          validator: (val) => AppValidator.requiredField(val!),
                          style: GoogleFonts.poppins(
                            height: 1.4,
                          ),
                          decoration: InputDecoration(
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
                      const SizedBox(
                        height: 20,
                      ),
                      AppTextNormal.labelW600(
                        "Nama Samar Test",
                        18,
                        Colors.black,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      SizedBox(
                        height: 40,
                        child: TextFormField(
                          controller: _tC.tcNamaSamaran,
                          validator: (val) => AppValidator.requiredField(val!),
                          style: GoogleFonts.poppins(
                            height: 1.4,
                          ),
                          decoration: InputDecoration(
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
                      const SizedBox(
                        height: 20,
                      ),
                      AppTextNormal.labelW600(
                        "Tipe Test",
                        18,
                        Colors.black,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      SizedBox(
                        height: 40,
                        child: TextFormField(
                          controller: _tC.tcTipe,
                          validator: (val) => AppValidator.requiredField(val!),
                          style: GoogleFonts.poppins(
                            height: 1.4,
                          ),
                          decoration: InputDecoration(
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
                                  "Jumlah Soal",
                                  18,
                                  Colors.black,
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                SizedBox(
                                  height: 40,
                                  child: TextFormField(
                                    controller: _tC.tcJumlahSoal,
                                    validator: (val) =>
                                        AppValidator.requiredField(val!),
                                    style: GoogleFonts.poppins(
                                      height: 1.4,
                                    ),
                                    decoration: InputDecoration(
                                      fillColor: Colors.white,
                                      filled: true,
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
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppTextNormal.labelW600(
                                  "Waktu",
                                  18,
                                  Colors.black,
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                SizedBox(
                                  height: 40,
                                  child: TextFormField(
                                    controller: _tC.tcWaktu,
                                    validator: (val) =>
                                        AppValidator.requiredField(val!),
                                    style: GoogleFonts.poppins(
                                      height: 1.4,
                                    ),
                                    decoration: InputDecoration(
                                      fillColor: Colors.white,
                                      filled: true,
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
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      AppTextNormal.labelW600(
                        "Peserta",
                        18,
                        Colors.black,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: 40,
                              child: Obx(
                                () => DropdownSearch<UserM>(
                                  clearButtonProps: ClearButtonProps(
                                      isVisible:
                                          _tC.selectedUser.value != userEmpty),
                                  popupProps: PopupProps.menu(
                                    disabledItemFn: (item) => _tC.users
                                        .contains(_tC.selectedUser.value),
                                    showSearchBox: true,
                                    searchFieldProps: TextFieldProps(
                                      decoration: InputDecoration(
                                        fillColor: Colors.white,
                                        filled: true,
                                        hintText: "Pilih user...",
                                        hintStyle: GoogleFonts.poppins(
                                          fontSize: 14,
                                          wordSpacing: 4,
                                        ),
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                vertical: 0, horizontal: 12),
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
                                  asyncItems: (String filter) =>
                                      _tC.dashboardRepository.getAllUsers(),
                                  itemAsString: (UserM u) => u.name,
                                  selectedItem: _tC.selectedUser.value,
                                  onChanged: (UserM? data) {
                                    if (data != null) {
                                      _tC.selectedUser.value = data;
                                    } else {
                                      _tC.selectedUser.value = userEmpty;
                                    }
                                  },
                                  dropdownDecoratorProps:
                                      DropDownDecoratorProps(
                                    dropdownSearchDecoration: InputDecoration(
                                      hintText: "Masukkan nama user disini",
                                      fillColor: Colors.white,
                                      filled: true,
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
                                    MaterialStateProperty.all(colorPrimaryDark),
                              ),
                              onPressed: () => _tC.addUsersToTemp(),
                              child: AppTextNormal.labelBold(
                                "Tambah",
                                16,
                                Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 12),
                        decoration: BoxDecoration(
                          color: colorPrimaryDark.withOpacity(0.6),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(8),
                            topRight: Radius.circular(8),
                          ),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: AppTextNormal.labelBold(
                                "Nama",
                                16,
                                Colors.white,
                              ),
                            ),
                            Expanded(
                              child: AppTextNormal.labelBold(
                                "Posisi",
                                16,
                                Colors.white,
                                textAlign: TextAlign.center,
                              ),
                            ),
                            const SizedBox(width: 30),
                          ],
                        ),
                      ),
                      Obx(() {
                        List<UserM> users = [];
                        if (_tC.usersSearch.isNotEmpty ||
                            _tC.tcSearch.text.isNotEmpty) {
                          users = _tC.usersSearch
                              .where((e) => e.page == _tC.pageUser.value)
                              .toList();
                        } else {
                          users = _tC.users
                              .where((e) => e.page == _tC.pageUser.value)
                              .toList();
                        }

                        return Column(
                          children: List.generate(
                            users.length,
                            (i) => Column(
                              children: [
                                Container(
                                  color: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 14, vertical: 16),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: AppTextNormal.labelW500(
                                          users[i].name,
                                          16,
                                          colorPrimaryDark,
                                        ),
                                      ),
                                      Expanded(
                                        child: AppTextNormal.labelW500(
                                          users[i].position,
                                          16,
                                          colorPrimaryDark,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 30,
                                        height: 30,
                                        child: InkWell(
                                          onTap: () {
                                            _tC.users.removeAt(i);
                                          },
                                          child: const Icon(
                                            Icons.close_rounded,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  height: 0.6,
                                  width: double.infinity,
                                  color: Colors.grey.shade400,
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 8),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(8),
                            bottomRight: Radius.circular(8),
                          ),
                        ),
                        child: Row(
                          children: [
                            SizedBox(
                              height: 45,
                              width: size.width / 6,
                              child: TextFormField(
                                controller: _tC.tcSearch,
                                onChanged: _tC.onSearchUser,
                                style: GoogleFonts.poppins(
                                  height: 1.4,
                                ),
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                decoration: InputDecoration(
                                  hintText: "Cari user disini..",
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
                              List<UserM> users = [];
                              if (_tC.usersSearch.isNotEmpty ||
                                  _tC.tcSearch.text.isNotEmpty) {
                                users = _tC.usersSearch;
                              } else {
                                users = _tC.users;
                              }
                              return CustomPagination(
                                currentPage: _tC.pageUser.value,
                                totalPage: (users.length / 3).ceil() == 0
                                    ? 1
                                    : (users.length / 3).ceil(),
                                onPageChanged: _tC.onChangePageUser,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                    color: Colors.grey.shade300,
                                  ),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                              );
                            }),
                            const SizedBox(
                              width: 10,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 35,
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 40,
                        child: ElevatedButton(
                          onPressed: () => _tC.updateExam(),
                          child: AppTextNormal.labelBold(
                            "Simpan",
                            16,
                            Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppTextNormal.labelW600(
                        "Informasi Test",
                        18,
                        Colors.black,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      ToolBar(
                        toolBarConfig: customToolBarList,
                        // toolBarColor: _toolbarColor,
                        padding: const EdgeInsets.all(8),
                        iconSize: 25,
                        // iconColor: _toolbarIconColor,
                        activeIconColor: Colors.greenAccent.shade400,
                        controller: _tC.controller,
                        direction: Axis.horizontal,
                      ),
                      Container(
                        width: double.infinity,
                        height: 2,
                        color: Colors.grey.shade200,
                      ),
                      Expanded(
                        child: QuillHtmlEditor(
                          hintText: 'Hint text goes here',
                          text: _tC.informasiTest.value,
                          controller: _tC.controller,
                          isEnabled: true,
                          ensureVisible: false,
                          minHeight: size.height / 1.4,
                          autoFocus: false,
                          // textStyle: editorTextStyle,
                          // hintTextStyle: _hintTextStyle,
                          hintTextAlign: TextAlign.start,
                          padding: const EdgeInsets.only(left: 10, top: 10),
                          hintTextPadding: const EdgeInsets.only(left: 20),
                          // backgroundColor: _backgroundColor,
                          inputAction: InputAction.newline,
                          loadingBuilder: (context) {
                            return const Center(
                              child: CircularProgressIndicator(
                                strokeWidth: 1,
                                color: colorPrimaryDark,
                              ),
                            );
                          },
                          onEditorResized: (height) =>
                              debugPrint('Editor resized $height'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
