import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:erecruitment/src/models/exam_m.dart';
import 'package:erecruitment/src/models/question_m.dart';

import '../models/user_m.dart';

abstract class TestRepository {
  Future<ExamM?> getExam(String id);

  Future<UserM?> getUserDetail(String id);

  Future<List<QuestionsM>> getQuestionIST(String id);

  Future<String?> updateExam(Map<String, dynamic> body);

  Future<String?> addQuestionIST(Map<String, dynamic> body);

  Future<String?> updateQuestionIST(Map<String, dynamic> body);

  Future<String?> deleteQuestionIST(Map<String, dynamic> body);
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

  @override
  Future<List<QuestionsM>> getQuestionIST(String id) async {
    List<QuestionsM> questions = [];
    try {
      final response = await FirebaseFirestore.instance
          .collection("exam")
          .doc(id)
          .collection("question")
          .get();
      if (response.docs.isEmpty) {
        return [];
      }
      for (var data in response.docs) {
        questions.add(QuestionsM.fromJson(data.data()));
      }
      return questions;
    } catch (e) {
      return [];
    }
  }

  @override
  Future<String?> addQuestionIST(Map<String, dynamic> body) async {
    try {
      await FirebaseFirestore.instance
          .collection("exam")
          .doc(body["exam_id"])
          .collection("question")
          .doc(body["id"])
          .set(body);
      return null;
    } catch (e) {
      return e.toString();
    }
  }

  @override
  Future<String?> updateQuestionIST(Map<String, dynamic> body) async {
    try {
      await FirebaseFirestore.instance
          .collection("exam")
          .doc(body["exam_id"])
          .collection("question")
          .doc(body["id"])
          .update(body);
      return null;
    } catch (e) {
      return e.toString();
    }
  }

  @override
  Future<String?> deleteQuestionIST(Map<String, dynamic> body) async {
    try {
      await FirebaseFirestore.instance
          .collection("exam")
          .doc(body["exam_id"])
          .collection("question")
          .doc(body["id"])
          .delete();
      return null;
    } catch (e) {
      return e.toString();
    }
  }

  @override
  Future<String?> updateExam(Map<String, dynamic> body) async {
    try {
      await FirebaseFirestore.instance
          .collection("exam")
          .doc(body["id"])
          .update(body);
      return null;
    } catch (e) {
      return e.toString();
    }
  }

  @override
  Future<UserM?> getUserDetail(String id) async {
    try {
      final response =
          await FirebaseFirestore.instance.collection("user").doc(id).get();

      return UserM.fromJson(response.data()!);
    } catch (e) {
      return null;
    }
  }
}
