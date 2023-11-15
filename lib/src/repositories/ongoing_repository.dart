import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:erecruitment/src/models/question_ist_m.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

abstract class OngoingRepository {
  Future<List<QuestionIstM>> getQuestionIst(String id);

  Future<String?> uploadVideo(XFile file, String path);

  Future<String?> addDataSubmit(Map<String, dynamic> body);

  Future<void> deleteVideo(String path);

  Future<void> changeStatusQuizUser(Map<String, dynamic> body);
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

  @override
  Future<String?> uploadVideo(XFile file, String path) async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      final storageRef =
          FirebaseStorage.instance.ref().child("video/$path/${user.uid}.mp4");

      UploadTask uploadTask = storageRef.putData(
        await file.readAsBytes(),
        SettableMetadata(
          contentType: file.mimeType,
        ),
      );
      return await ((await uploadTask).ref.getDownloadURL());
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return null;
    }
  }

  @override
  Future<String?> addDataSubmit(Map<String, dynamic> body) async {
    try {
      final response = await FirebaseFirestore.instance
          .collection("submit")
          .where("uid", isEqualTo: body["uid"])
          .get();
      if (response.docs
          .where((e) => e.data()["exam_id"] == body["exam_id"])
          .toList()
          .isNotEmpty) {
        body.remove("created");
        await FirebaseFirestore.instance
            .collection("submit")
            .doc(response.docs[0].id)
            .update(body);
      } else {
        const Uuid uuid = Uuid();
        String randomUuid = uuid.v4();
        body["submit_id"] = randomUuid;
        await FirebaseFirestore.instance
            .collection("submit")
            .doc(randomUuid)
            .set(body);
      }

      return null;
    } catch (e) {
      return e.toString();
    }
  }

  @override
  Future<void> deleteVideo(String path) async {
    final storageRef = FirebaseStorage.instance.ref().child(path);

    await storageRef.delete();
  }

  @override
  Future<void> changeStatusQuizUser(Map<String, dynamic> body) async {
    try {
      final response = await FirebaseFirestore.instance
          .collection("exam")
          .doc(body["exam_id"])
          .get();
      if (response.exists) {
        final data = response.data() ?? {};
        List<String> users =
            List<String>.from(data["users"].map((item) => item.toString()));
        users.add(body["uid"]);
        await FirebaseFirestore.instance
            .collection("exam")
            .doc(body["exam_id"])
            .update({
          "users": users,
        });
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }
}
