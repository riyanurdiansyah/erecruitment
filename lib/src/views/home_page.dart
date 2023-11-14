import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../controllers/home_controller.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final _ = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: () {
                context.pop();
              },
              child: Container(
                color: Colors.blue,
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.cyan,
            ),
          ),
        ],
      ),
    );
  }
}
