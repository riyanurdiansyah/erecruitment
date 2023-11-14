import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  @override
  void onInit() async {
    print("ON INIT");
    await onCheckCloud();
    super.onInit();
  }

  @override
  void dispose() {
    print("ON DISPOSE");
    super.dispose();
  }

  Future onCheckCloud() async {
    try {
      final response =
          await FirebaseFirestore.instance.collection("sidebar").get();
      print("CEK RES : ${response.docs}");
    } catch (e) {
      print("CEK RES ERROR : ${e.toString()}");
    }
  }
}
