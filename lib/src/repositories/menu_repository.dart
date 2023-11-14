import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:erecruitment/src/models/exam_m.dart';
import 'package:erecruitment/src/models/sidebar_m.dart';

abstract class MenuRepository {
  Future<List<SidebarM>> getMenus(int role);

  Future<List<ExamM>> getExams();
}

class MenuRepositoryImpl implements MenuRepository {
  @override
  Future<List<SidebarM>> getMenus(int role) async {
    List<SidebarM> sidebars = [];
    try {
      final response =
          await FirebaseFirestore.instance.collection("sidebar").get();
      if (response.docs.isEmpty) {
        return [];
      } else {
        for (var data in response.docs) {
          sidebars.add(SidebarM.fromJson(data.data()));
        }
        sidebars.sort((a, b) => a.title.compareTo(b.title));
        return sidebars.where((e) => e.role.contains(role)).toList();
      }
    } catch (e) {
      return [];
    }
  }

  @override
  Future<List<ExamM>> getExams() async {
    List<ExamM> exams = [];
    try {
      final response =
          await FirebaseFirestore.instance.collection("exam").get();
      if (response.docs.isEmpty) {
        return [];
      } else {
        for (var data in response.docs) {
          exams.add(ExamM.fromJson(data.data()));
        }
        exams.sort((a, b) => a.title.compareTo(b.title));
        return exams;
      }
    } catch (e) {
      return [];
    }
  }
}
