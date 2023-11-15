import 'package:flutter/material.dart';

import '../../utils/app_text_normal.dart';

class PermissionPage extends StatelessWidget {
  const PermissionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Row(
        children: [
          SizedBox(
            width: size.width / 4,
            child: Image.asset("images/permission.png"),
          ),
          const SizedBox(
            width: 35,
          ),
          Column(
            children: [
              ElevatedButton(
                onPressed: () {},
                child: AppTextNormal.labelW600(
                  "Lanjutkan",
                  16,
                  Colors.white,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
