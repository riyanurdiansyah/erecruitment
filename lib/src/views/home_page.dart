import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final _ = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
