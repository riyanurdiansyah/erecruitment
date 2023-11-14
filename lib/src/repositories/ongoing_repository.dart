import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:erecruitment/src/models/question_ist_m.dart';

abstract class OngoingRepository {
  Future<List<QuestionIstM>> getQuestionIst(String id);
}

class OngoingRepositoryImpl implements OngoingRepository {
  @override
  Future<List<QuestionIstM>> getQuestionIst(String id) async {
    List<QuestionIstM> questions = [];
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
        questions.add(QuestionIstM.fromJson(data.data()));
      }
      return questions.where((e) => e.status == true).toList()..shuffle();
    } catch (e) {
      return [];
    }
  }
}
