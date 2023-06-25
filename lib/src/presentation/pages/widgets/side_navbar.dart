import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../utils/app_text.dart';
import '../../../../utils/app_color.dart';
import '../../../domain/entities/side_navbar_entity.dart';

class SideNavbar extends StatelessWidget {
  const SideNavbar({
    super.key,
    required this.listMenu,
    required this.route,
  });

  final List<SideNavbarEntity> listMenu;
  final String route;

  @override
  Widget build(BuildContext context) {
    final router = GoRouter.of(context);
    return Drawer(
      elevation: 0,
      child: Material(
        color: backgroundGrey,
        child: Column(
          children: [
            const SizedBox(
              height: 25,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  "assets/images/logo-no-text.webp",
                  width: 60,
                ),
                const SizedBox(
                  width: 12,
                ),
                AppText.labelW600(
                  "e-Recruiment v1.0",
                  16,
                  colorPrimaryDark,
                ),
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            Column(
              children: List.generate(
                listMenu.length,
                (index) => SizedBox(
                  width: double.infinity,
                  child: AnimatedContainer(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 3),
                    padding: const EdgeInsets.only(
                      left: 20,
                    ),
                    duration: const Duration(
                      seconds: 1,
                    ),
                    decoration: BoxDecoration(
                      color: route.contains(listMenu[index].route)
                          ? colorPrimaryDark
                          : backgroundGrey,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    height: 50.0,
                    child: InkWell(
                      onHover: (val) {},
                      overlayColor:
                          MaterialStateProperty.all(Colors.grey.shade200),
                      onTap: () {
                        router.goNamed(listMenu[index].route);
                      },
                      child: Row(
                        children: [
                          Image.asset(
                            listMenu[index].image,
                            width:
                                route.contains(listMenu[index].route) ? 18 : 15,
                            color: route.contains(listMenu[index].route)
                                ? Colors.white
                                : Colors.black54,
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Text(
                            listMenu[index].title,
                            style: GoogleFonts.poppins(
                              fontSize: route.contains(listMenu[index].route)
                                  ? 14.5
                                  : 13.5,
                              color: route.contains(listMenu[index].route)
                                  ? Colors.white
                                  : Colors.black54,
                              letterSpacing: 1.2,
                              fontWeight: route.contains(listMenu[index].route)
                                  ? FontWeight.w600
                                  : FontWeight.w500,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
