import 'package:erecruitment/src/models/role_m.dart';
import 'package:erecruitment/utils/app_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../utils/app_color.dart';
import '../../utils/app_text_normal.dart';
import '../controllers/user_controller.dart';
import 'widgets/custom_pagination.dart';

class KelolaUserRolePage extends StatelessWidget {
  KelolaUserRolePage({super.key});

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
                    child: AppTextNormal.labelBold(
                      "Role ID",
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
                      "Created",
                      16,
                      Colors.white,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    child: AppTextNormal.labelBold(
                      "Updated",
                      16,
                      Colors.white,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(
                    width: 12,
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
                List<RoleM> roles = [];
                if (_uC.rolesSearch.isNotEmpty ||
                    _uC.tcSearch.text.isNotEmpty) {
                  roles = _uC.rolesSearch
                      .where((e) => e.page == _uC.page.value)
                      .toList();
                } else {
                  roles =
                      _uC.roles.where((e) => e.page == _uC.page.value).toList();
                }

                return Column(
                  children: List.generate(
                    roles.length,
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
                                  roles[i].roleId.toString(),
                                  16,
                                  colorPrimaryDark,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Expanded(
                                child: AppTextNormal.labelW500(
                                  roles[i].roleName,
                                  16,
                                  colorPrimaryDark,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Expanded(
                                child: AppTextNormal.labelW500(
                                  "${DateFormat.yMMMd('id').add_jm().format(DateTime.parse(roles[i].created))} WIB",
                                  16,
                                  colorPrimaryDark,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Expanded(
                                child: AppTextNormal.labelW500(
                                  "${DateFormat.yMMMd('id').add_jm().format(DateTime.parse(roles[i].updated))} WIB",
                                  16,
                                  colorPrimaryDark,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              const SizedBox(
                                width: 12,
                              ),
                              SizedBox(
                                width: 30,
                                height: 30,
                                child: InkWell(
                                  onTap: () => AppDialog.dialogAddUserRole(
                                      oldRole: roles[i], isUpdated: true),
                                  child: const Icon(
                                    Icons.double_arrow_rounded,
                                    color: colorPrimaryDark,
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
                      onChanged: _uC.onSearchUserRole,
                      style: GoogleFonts.poppins(
                        height: 1.4,
                      ),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                        hintText: "Cari role user disini..",
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
                    List<RoleM> roles = [];
                    if (_uC.rolesSearch.isNotEmpty ||
                        _uC.tcSearch.text.isNotEmpty) {
                      roles = _uC.rolesSearch;
                    } else {
                      roles = _uC.roles;
                    }
                    return CustomPagination(
                      currentPage: _uC.page.value,
                      totalPage: (roles.length / 8).ceil() == 0
                          ? 1
                          : (roles.length / 8).ceil(),
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
        onPressed: () => AppDialog.dialogAddUserRole(),
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
