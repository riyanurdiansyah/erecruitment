import 'package:erecruitment/src/controllers/dashboard_controller.dart';
import 'package:erecruitment/src/views/widgets/sidebar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardPage extends StatelessWidget {
  DashboardPage({
    super.key,
    required this.widget,
    required this.route,
  });

  final Widget widget;
  final String route;

  final _dC = Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Siderbar(
        route: route,
      ),
      body: Row(
        children: [
          Expanded(
            flex: 1,
            child: Siderbar(
              route: route,
            ),
          ),
          Expanded(
            flex: 5,
            child: widget,
          ),
        ],
      ),
    );
  }
}
