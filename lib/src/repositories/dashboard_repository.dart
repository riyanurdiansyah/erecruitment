import 'package:cloud_firestore/cloud_firestore.dart';

abstract class DashboardRepository {
  Future<String?> addTest(Map<String, dynamic> body);
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
}
