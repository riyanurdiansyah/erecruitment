import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  @override
  void onInit() async {
    debugPrint("ON INIT");
    await onCheckCloud();
    super.onInit();
  }

  @override
  void dispose() {
    debugPrint("ON DISPOSE");
    super.dispose();
  }

  Future onCheckCloud() async {
    try {
      final response =
          await FirebaseFirestore.instance.collection("sidebar").get();
      debugPrint("CEK RES : ${response.docs}");
    } catch (e) {
      debugPrint("CEK RES ERROR : ${e.toString()}");
    }
  }
}
