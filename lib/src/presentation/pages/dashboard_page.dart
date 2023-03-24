import 'package:flutter/material.dart';

import '../../../utils/app_color.dart';
import '../../../utils/app_constanta_list.dart';
import 'widgets/side_navbar.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({
    super.key,
    required this.widget,
    required this.route,
  });

  final Widget widget;
  final String route;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundGrey.withOpacity(0.4),
      drawer: SideNavbar(
        listMenu: listSidebar,
        route: route,
      ),
      body: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              color: backgroundGrey,
              child: SideNavbar(
                listMenu: listSidebar,
                route: route,
              ),
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
