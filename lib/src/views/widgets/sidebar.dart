import 'package:erecruitment/src/controllers/dashboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uuid/uuid.dart';
import '../../../utils/app_responsive.dart';
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
    return Drawer(
      elevation: 0,
      child: Material(
        color: Colors.brown,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              AppTextNormal.labelW600(
                "Welcome...",
                16,
                Colors.white,
              ),
              const SizedBox(
                height: 12,
              ),
              AppTextNormal.labelW600(
                "E-Recruitment",
                25,
                Colors.white,
              ),
              const SizedBox(
                height: 45,
              ),
              Obx(
                () => Column(
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
                          color: route.contains(_dC.sidebars[index].route)
                              ? Colors.green
                              : null,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        height: 50.0,
                        child: InkWell(
                          overlayColor:
                              route.contains(_dC.sidebars[index].route)
                                  ? null
                                  : MaterialStateProperty.all(
                                      Colors.green.withOpacity(0.5)),
                          onTap: () {
                            const Uuid uuid = Uuid();

                            // Generate a random UUID (Version 4)
                            String randomUuid = uuid.v4();

                            print("Random UUID: $randomUuid");
                            print(
                                "Random DATE: ${DateTime.now().toIso8601String()}");
                            context.goNamed(_dC.sidebars[index].route);
                          },
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Row(
                              children: [
                                // Image.asset(
                                //   _dC.sidebars[index].image,
                                //   width: route.contains(_dC.sidebars[index].route)
                                //       ? 18
                                //       : 15,
                                //   color: route.contains(_dC.sidebars[index].route)
                                //       ? Colors.white
                                //       : Colors.green,
                                // ),
                                if (!AppResponsive.isTablet(context) &&
                                    !AppResponsive.isMobileWeb(context))
                                  const SizedBox(
                                    width: 15,
                                  ),
                                if (!AppResponsive.isTablet(context) &&
                                    !AppResponsive.isMobileWeb(context))
                                  Text(
                                    _dC.sidebars[index].title,
                                    style: GoogleFonts.poppins(
                                      fontSize: route.contains(
                                              _dC.sidebars[index].route)
                                          ? 14.5
                                          : 13.5,
                                      color: route.contains(
                                              _dC.sidebars[index].route)
                                          ? Colors.white
                                          : Colors.green,
                                      letterSpacing: 1.2,
                                      fontWeight: route.contains(
                                              _dC.sidebars[index].route)
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
