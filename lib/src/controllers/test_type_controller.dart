import 'package:erecruitment/src/models/exam_type_m.dart';
import 'package:erecruitment/src/repositories/test_repository.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class TestTypeController extends GetxController {
  final RxList<ExamTypeM> types = <ExamTypeM>[].obs;

  final RxList<ExamTypeM> typesSearch = <ExamTypeM>[].obs;

  final tcSearch = TextEditingController();

  final Rx<int> page = 1.obs;

  final TestRepository testRepository = TestRepositoryImpl();

  final tcType = TextEditingController();

  @override
  void onInit() {
    Future.delayed(const Duration(seconds: 1), () async {
      await getAllExamType();
    });
    super.onInit();
  }

  Future getAllExamType() async {
    double pageTemp = 0;
    types.value = await testRepository.getExamTypes();
    for (int i = 0; i < types.length; i++) {
      pageTemp = (i + 1) ~/ 8 < 1 ? 1 : (i + 1) / 8;
      types[i] = types[i].copyWith(page: pageTemp.ceil());
    }
    types.sort((a, b) => a.type.compareTo(b.type));
  }

  void onChangepage(int value) {
    page.value = value;
  }

  void onSearch(String query) {
    double pageTemp = 0;
    List<ExamTypeM> typesTemp = [];
    if (query.isEmpty) {
      typesTemp.clear();
      typesSearch.clear();
    } else {
      typesTemp = types
          .where((e) => e.type.toLowerCase().contains(query.toLowerCase()))
          .toList();
      for (int i = 0; i < typesTemp.length; i++) {
        pageTemp = (i + 1) ~/ 8 < 1 ? 1 : (i + 1) / 8;
        typesTemp[i] = typesTemp[i].copyWith(page: pageTemp.ceil());
      }
      typesTemp.sort((a, b) => a.type.compareTo(b.type));
      typesSearch.value = typesTemp;
    }
  }

  void addExamType() async {
    const Uuid uuid = Uuid();
    String randomUuid = uuid.v4();

    final body = {
      "id": randomUuid,
      "type": tcType.text,
      "created": DateTime.now().toIso8601String(),
      "updated": DateTime.now().toIso8601String(),
    };

    final response = await testRepository.addExamType(body);
    Fluttertoast.showToast(msg: response ?? "Berhasil menampahkan data");
    if (response == null) {
      getAllExamType();
    }
  }
}
