import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:erecruitment/src/models/exam_m.dart';

abstract class TestRepository {
  Future<ExamM?> getExam(String id);
}

class TestRepositoryImpl implements TestRepository {
  @override
  Future<ExamM?> getExam(String id) async {
    try {
      final response =
          await FirebaseFirestore.instance.collection("exam").doc(id).get();
      if (!response.exists) {
        return null;
      }
      return ExamM.fromJson(response.data()!);
    } catch (e) {
      return null;
    }
  }
}
