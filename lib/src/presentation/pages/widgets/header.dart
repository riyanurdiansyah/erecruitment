import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../utils/app_text.dart';

class Header extends StatelessWidget {
  const Header({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 14),
      width: double.infinity,
      height: kToolbarHeight,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: TextField(
              onTap: () {},
              onEditingComplete: () {},
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderSide: const BorderSide(width: 0.2, color: Colors.grey),
                  borderRadius: BorderRadius.circular(5),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(width: 0.2, color: Colors.grey),
                  borderRadius: BorderRadius.circular(5),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(width: 0.2, color: Colors.white),
                  borderRadius: BorderRadius.circular(5),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
                hintText: 'Apa yang kamu mau cari hari ini?',
                hintStyle: GoogleFonts.poppins(
                  color: Colors.grey,
                  fontSize: 14,
                ),
                suffixIcon: IconButton(
                  icon: const Icon(
                    Icons.search_rounded,
                  ),
                  onPressed: () {},
                  color: Colors.grey,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(),
          ),
          Expanded(
            flex: 2,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Badge(
                    stackFit: StackFit.passthrough,
                    badgeContent: Padding(
                      padding: const EdgeInsets.only(top: 2),
                      child: AppText.labelW700(
                        "3",
                        12.5,
                        Colors.white,
                      ),
                    ),
                    child: PopupMenuButton(
                      tooltip: "Notif",
                      offset: const Offset(0, 40),
                      icon: const Icon(
                        Icons.notifications_rounded,
                        size: 28,
                      ),
                      itemBuilder: (_) => [
                        PopupMenuItem(
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  AppText.labelW600(
                                    "Notif",
                                    14,
                                    Colors.black,
                                  ),
                                  TextButton(
                                    onPressed: () {},
                                    child: AppText.labelW500(
                                      "Lihat Semua",
                                      12,
                                      Colors.blue,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                const VerticalDivider(),
                const SizedBox(
                  width: 12,
                ),
                Container(
                  width: 45,
                  height: 45,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage(
                        "assets/images/user.png",
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText.labelW600(
                      "Cyntia Bella",
                      12,
                      Colors.black,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    AppText.labelW400(
                      "HR Manager",
                      10,
                      Colors.black,
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
