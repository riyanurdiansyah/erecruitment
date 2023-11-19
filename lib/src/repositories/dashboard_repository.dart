import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user_m.dart';

abstract class DashboardRepository {
  Future<String?> addTest(Map<String, dynamic> body);

  Future<String?> deleteTest(String id);

  Future<List<UserM>> getAllUsers();
}

class DashboardRepositoryImpl implements DashboardRepository {
  @override
  Future<String?> addTest(Map<String, dynamic> body) async {
    try {
      await FirebaseFirestore.instance
          .collection("exam")
          .doc(body["id"])
          .set(body);
      return null;
    } catch (e) {
      return e.toString();
    }
  }

  @override
  Future<String?> deleteTest(String id) async {
    try {
      await FirebaseFirestore.instance.collection("exam").doc(id).delete();
      return null;
    } catch (e) {
      return e.toString();
    }
  }

  @override
  Future<List<UserM>> getAllUsers() async {
    List<UserM> users = [];
    try {
      final response =
          await FirebaseFirestore.instance.collection("user").get();
      if (response.docs.isEmpty) {
        return [];
      }
      for (var data in response.docs) {
        users.add(UserM.fromJson(data.data()));
      }
      return users;
    } catch (e) {
      return [];
    }
  }
}
