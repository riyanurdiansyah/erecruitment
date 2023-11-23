import 'package:erecruitment/src/controllers/dashboard_controller.dart';
import 'package:erecruitment/src/models/sidebar_m.dart';
import 'package:erecruitment/utils/app_color.dart';
import 'package:erecruitment/utils/app_route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uuid/uuid.dart';

import '../../../utils/app_dialog.dart';
import '../../../utils/app_route_name.dart';
import '../../../utils/app_text_normal.dart';

class Siderbar extends StatelessWidget {
  Siderbar({
    super.key,
    required this.route,
  });

  final String route;

  final _dC = Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Drawer(
        elevation: 0,
        child: Material(
          color: colorPrimaryDark,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  "images/logo.webp",
                ),
                Center(
                  child: SizedBox(
                    width: 80,
                    height: 80,
                    child: Image.asset(
                      "images/man.png",
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Obx(
                  () => Center(
                    child: Text(
                      _dC.user.value.name,
                      style: GoogleFonts.caveat(
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Obx(
                  () => Center(
                    child: Text(
                      _dC.user.value.position,
                      style: GoogleFonts.sourceCodePro(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 45,
                ),
                Obx(
                  () {
                    if (_dC.role.value != 0) {
                      return Column(
                        children: List.generate(
                          _dC.sidebars.length,
                          (index) => SizedBox(
                            width: double.infinity,
                            child: AnimatedContainer(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 3),
                              duration: const Duration(
                                seconds: 1,
                              ),
                              decoration: BoxDecoration(
                                color: route.split("/")[1] ==
                                        _dC.sidebars[index].route
                                    ? colorPrimary
                                    : null,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              height: 40.0,
                              child: InkWell(
                                overlayColor: route.split("/")[1] ==
                                        _dC.sidebars[index].route
                                    ? null
                                    : MaterialStateProperty.all(
                                        Colors.grey.shade400),
                                onTap: () {
                                  const Uuid uuid = Uuid();

                                  // Generate a random UUID (Version 4)
                                  String randomUuid = uuid.v4();

                                  print("Random UUID: $randomUuid");
                                  print(
                                      "Random DATE: ${DateTime.now().toIso8601String()}");
                                  context.goNamed(_dC.sidebars[index].route);
                                },
                                child: Center(
                                  child: Text(
                                    _dC.sidebars[index].title,
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins(
                                      fontSize: route.split("/")[1] ==
                                              _dC.sidebars[index].route
                                          ? 14.5
                                          : 13.5,
                                      color: route.split("/")[1] ==
                                              _dC.sidebars[index].route
                                          ? colorPrimaryDark
                                          : Colors.white,
                                      letterSpacing: 1.2,
                                      fontWeight: route.split("/")[1] ==
                                              _dC.sidebars[index].route
                                          ? FontWeight.w600
                                          : FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                    return Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: List.generate(
                            _dC.sidebars.length,
                            (index) => _buildMenu(_dC.sidebars[index]),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: ListTile(
        tileColor: colorPrimaryDark,
        onTap: () {
          AppDialog.dialogLogout(
            title: "Keluar",
            subtitle: "Yakin ingin keluar?",
            ontap: () async => await _dC
                .signOut()
                .then((value) => context.goNamed(AppRouteName.signin)),
          );
        },
        leading: const Icon(
          Icons.logout_rounded,
          color: Colors.red,
        ),
        title: AppTextNormal.labelW600(
          "Keluar",
          16,
          Colors.red,
        ),
      ),
    );
  }

  Widget _buildSubMenu(List<SidebarM> submenus) {
    return Column(
      children: submenus.map((submenu) {
        return ListTile(
          onTap: () {
            const Uuid uuid = Uuid();

            String randomUuid = uuid.v4();

            debugPrint("Random UUID: $randomUuid");
            debugPrint("Random DATE: ${DateTime.now().toIso8601String()}");
            rootNavigatorKey.currentContext?.goNamed(submenu.route);
          },
          title: AppTextNormal.labelW600(
            submenu.title,
            16,
            Colors.white,
          ),
        );
      }).toList(),
    );
  }

  Widget _buildMenu(SidebarM sidebar) {
    if (sidebar.submenus.isEmpty) {
      return ListTile(
        selectedColor: Colors.amber,
        focusColor: Colors.red,
        selectedTileColor: Colors.black,
        onTap: () {
          const Uuid uuid = Uuid();

          String randomUuid = uuid.v4();

          debugPrint("Random UUID: $randomUuid");
          debugPrint("Random DATE: ${DateTime.now().toIso8601String()}");
          rootNavigatorKey.currentContext?.goNamed(sidebar.route);
        },
        title: AppTextNormal.labelW600(
          sidebar.title,
          16,
          Colors.white,
        ),
      );
    }
    sidebar.submenus.sort((a, b) => a.title.compareTo(b.title));
    return ExpansionTile(
      childrenPadding: const EdgeInsets.only(left: 6),
      title: AppTextNormal.labelW600(
        sidebar.title,
        16,
        Colors.white,
      ),
      iconColor: Colors.white,
      collapsedIconColor: Colors.white,
      children: List.generate(sidebar.submenus.length, (index) {
        if (sidebar.submenus[index].submenus.isEmpty) {
          return _buildMenu(sidebar.submenus[index]);
        }
        return _buildSubMenu(sidebar.submenus[index].submenus);
      }),
    );
  }
}
