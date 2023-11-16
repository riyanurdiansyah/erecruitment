import 'package:erecruitment/src/models/exam_m.dart';
import 'package:erecruitment/src/repositories/test_repository.dart';
import 'package:erecruitment/utils/app_constanta_empty.dart';
import 'package:get/get.dart';

class TestController extends GetxController {
  final Rx<ExamM> exam = examEmpty.obs;

  final Rx<String> examId = "".obs;

  final Rx<bool> isLoading = true.obs;

  final TestRepository testRepository = TestRepositoryImpl();

  @override
  void onInit() {
    Future.delayed(
      const Duration(seconds: 1),
      () async {
        await getExam();
        await changeLoading(false);
      },
    );
    super.onInit();
  }

  Future getExam() async {
    final response = await testRepository.getExam(examId.value);
    if (response != null) {
      exam.value = response;
    }
  }

  Future changeLoading(bool newValue) async {
    isLoading.value = newValue;
  }
}
