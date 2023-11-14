import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

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
                color: Colors.amber,
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.amber,
            ),
          ),
        ],
      ),
    );
  }
}
