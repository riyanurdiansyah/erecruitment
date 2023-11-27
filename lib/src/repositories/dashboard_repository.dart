import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:erecruitment/utils/app_constanta.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/exam_m.dart';
import '../models/role_m.dart';
import '../models/user_m.dart';

abstract class DashboardRepository {
  Future<String?> addTest(Map<String, dynamic> body);

  Future<String?> deleteTest(String id);

  Future<List<UserM>> getAllUsers();

  Future<List<RoleM>> getAllRole();

  Future<User?> createUser(String email, String password);

  Future<String?> addUserToFirestore(Map<String, dynamic> body);

  Future<String?> updateUserToFirestore(Map<String, dynamic> body);

  Future<String?> addRole(Map<String, dynamic> body);

  Future<String?> updateRole(Map<String, dynamic> body);

  Future<String?> updateExamAddedUSer(Map<String, dynamic> body);

  Future<ExamM?> getExam(String id);

  Future<UserM?> getUser(String id);

  Future<String?> sendMail(Map<String, dynamic> body);

  Future<String?> addErrorMailer(Map<String, dynamic> body);

  Stream<List<ExamM>> streamExamForAdmin();

  Stream<List<ExamM>> streamSubExamForAdmin(String id);
}

class DashboardRepositoryImpl implements DashboardRepository {
  final Dio _dio = Dio();

  @override
  Stream<List<ExamM>> streamSubExamForAdmin(String id) {
    List<ExamM> exams = [];
    Stream<QuerySnapshot<Map<String, dynamic>>> stream = FirebaseFirestore
        .instance
        .collection("exam")
        .doc(id)
        .collection("subtest")
        .snapshots();
    return stream.map((e) => e.docs).map((ev) {
      print("CEK SUB : $ev");
      exams = examsMFromJson(json.encode(ev.map((e) => e.data()).toList()));
      exams.sort(((a, b) => a.title.compareTo(b.title)));
      return exams;
    });
  }

  @override
  Stream<List<ExamM>> streamExamForAdmin() {
    List<ExamM> exams = [];
    Stream<QuerySnapshot<Map<String, dynamic>>> stream =
        FirebaseFirestore.instance.collection("exam").snapshots();
    return stream.map((e) => e.docs).map((ev) {
      exams = examsMFromJson(json.encode(ev.map((e) => e.data()).toList()));
      exams.sort(((a, b) => a.title.compareTo(b.title)));
      return exams;
    });
  }

  @override
  Future<String?> addTest(Map<String, dynamic> body) async {
    try {
      await FirebaseFirestore.instance
          .collection("exam")
          .doc(body["id"])
          .set(body);
      return null;
    } catch (e) {
      debugPrint(e.toString());
      return e.toString();
    }
  }

  @override
  Future<String?> deleteTest(String id) async {
    try {
      await FirebaseFirestore.instance.collection("exam").doc(id).delete();
      return null;
    } catch (e) {
      debugPrint(e.toString());
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
      debugPrint(e.toString());
      return [];
    }
  }

  @override
  Future<List<RoleM>> getAllRole() async {
    List<RoleM> roles = [];
    try {
      final response =
          await FirebaseFirestore.instance.collection("role").get();
      if (response.docs.isEmpty) {
        return [];
      }
      for (var data in response.docs) {
        roles.add(RoleM.fromJson(data.data()));
      }
      return roles;
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }

  @override
  Future<User?> createUser(String email, String password) async {
    try {
      final response = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      if (response.user != null) {
        return response.user!;
      }
      return null;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  @override
  Future<String?> addUserToFirestore(Map<String, dynamic> body) async {
    try {
      await FirebaseFirestore.instance
          .collection("user")
          .doc(body["id"])
          .set(body);
      return null;
    } catch (e) {
      debugPrint(e.toString());
      return e.toString();
    }
  }

  @override
  Future<String?> updateUserToFirestore(Map<String, dynamic> body) async {
    try {
      await FirebaseFirestore.instance
          .collection("user")
          .doc(body["id"])
          .update(body);
      return null;
    } catch (e) {
      debugPrint(e.toString());
      return e.toString();
    }
  }

  @override
  Future<String?> addRole(Map<String, dynamic> body) async {
    try {
      await FirebaseFirestore.instance
          .collection("role")
          .doc(body["id"])
          .set(body);
      return null;
    } catch (e) {
      debugPrint(e.toString());
      return e.toString();
    }
  }

  @override
  Future<String?> updateRole(Map<String, dynamic> body) async {
    try {
      await FirebaseFirestore.instance
          .collection("role")
          .doc(body["id"])
          .update(body);
      return null;
    } catch (e) {
      debugPrint(e.toString());
      return e.toString();
    }
  }

  @override
  Future<String?> updateExamAddedUSer(Map<String, dynamic> body) async {
    try {
      await FirebaseFirestore.instance
          .collection("exam")
          .doc(body["id"])
          .update(body);
      return null;
    } catch (e) {
      debugPrint(e.toString());
      return e.toString();
    }
  }

  @override
  Future<ExamM?> getExam(String id) async {
    try {
      final response =
          await FirebaseFirestore.instance.collection("exam").doc(id).get();
      if (response.exists) {
        return ExamM.fromJson(response.data()!);
      }
      return null;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  @override
  Future<UserM?> getUser(String id) async {
    try {
      final response =
          await FirebaseFirestore.instance.collection("user").doc(id).get();
      if (response.exists) {
        return UserM.fromJson(response.data()!);
      }
      return null;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  @override
  Future<String?> sendMail(Map<String, dynamic> body) async {
    try {
      final response = await _dio.post(sendmailUrl, data: body);
      if (response.statusCode == 200) {
        return null;
      }

      return "Failed send email";
    } catch (e) {
      debugPrint(e.toString());
      return e.toString();
    }
  }

  @override
  Future<String?> addErrorMailer(Map<String, dynamic> body) async {
    try {
      await FirebaseFirestore.instance
          .collection("mailer")
          .doc(body["id"])
          .set(body);
      return null;
    } catch (e) {
      return e.toString();
    }
  }
}
