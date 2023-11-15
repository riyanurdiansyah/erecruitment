import 'package:flutter/material.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          GridView.count(
            crossAxisCount: 6,
            children: List.generate(
              25,
              (index) => Container(),
            ),
          ),
        ],
      ),
    );
  }
}
