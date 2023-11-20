import 'package:erecruitment/utils/app_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../utils/app_color.dart';
import '../../utils/app_text_normal.dart';
import '../controllers/user_controller.dart';
import '../models/user_m.dart';
import 'widgets/custom_pagination.dart';

class KelolaUserPage extends StatelessWidget {
  KelolaUserPage({super.key});

  final _uC = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
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
                    flex: 2,
                    child: AppTextNormal.labelBold(
                      "Nama",
                      16,
                      Colors.white,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    child: AppTextNormal.labelBold(
                      "Email",
                      16,
                      Colors.white,
                      textAlign: TextAlign.center,
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
                  Expanded(
                    child: AppTextNormal.labelBold(
                      "Role",
                      16,
                      Colors.white,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    child: AppTextNormal.labelBold(
                      "Mulai",
                      16,
                      Colors.white,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    child: AppTextNormal.labelBold(
                      "Berakhir",
                      16,
                      Colors.white,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(
                    width: 30,
                    height: 30,
                  ),
                ],
              ),
            ),
            Obx(
              () {
                List<UserM> users = [];
                if (_uC.usersSearch.isNotEmpty ||
                    _uC.tcSearch.text.isNotEmpty) {
                  users = _uC.usersSearch
                      .where((e) => e.page == _uC.page.value)
                      .toList();
                } else {
                  users =
                      _uC.users.where((e) => e.page == _uC.page.value).toList();
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
                                flex: 2,
                                child: AppTextNormal.labelW500(
                                  users[i].name,
                                  16,
                                  colorPrimaryDark,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Expanded(
                                child: AppTextNormal.labelW500(
                                  users[i].email,
                                  16,
                                  colorPrimaryDark,
                                  textAlign: TextAlign.center,
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
                              Expanded(
                                child: AppTextNormal.labelW500(
                                  _uC.roles
                                      .firstWhere(
                                          (e) => e.roleId == users[i].role)
                                      .roleName,
                                  16,
                                  colorPrimaryDark,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Expanded(
                                child: AppTextNormal.labelW500(
                                  "${DateFormat.yMMMd('id').add_jm().format(DateTime.parse(users[i].started))} WIB",
                                  16,
                                  colorPrimaryDark,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Expanded(
                                child: AppTextNormal.labelW500(
                                  "${DateFormat.yMMMd('id').add_jm().format(DateTime.parse(users[i].ended))} WIB",
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
                                    _uC.users.removeAt(i);
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
              },
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
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
                      controller: _uC.tcSearch,
                      onChanged: _uC.onSearchUser,
                      style: GoogleFonts.poppins(
                        height: 1.4,
                      ),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
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
                          borderSide: BorderSide(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  Obx(() {
                    List<UserM> users = [];
                    if (_uC.usersSearch.isNotEmpty ||
                        _uC.tcSearch.text.isNotEmpty) {
                      users = _uC.usersSearch;
                    } else {
                      users = _uC.users;
                    }
                    return CustomPagination(
                      currentPage: _uC.page.value,
                      totalPage: (users.length / 3).ceil() == 0
                          ? 1
                          : (users.length / 3).ceil(),
                      onPageChanged: _uC.onChangepage,
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
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.small(
        onPressed: () => AppDialog.dialogAddUser(),
        backgroundColor: Colors.blue,
        child: AppTextNormal.labelW600(
          "+",
          30,
          Colors.white,
        ),
      ),
    );
  }
}
