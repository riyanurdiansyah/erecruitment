import 'package:get/get.dart';

class ResultController extends GetxController {
  final Rx<bool> isShowUse = false.obs;

  Future changeIsShowUser(bool val) async {
    isShowUse.value = val;
  }
}
