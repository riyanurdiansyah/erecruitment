import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:recruitment/src/core/exception_handling.dart';
import 'package:recruitment/src/data/datasources/remote/dashbord_remote_datasource.dart';
import 'package:recruitment/src/domain/entities/disc_entity.dart';
import 'package:recruitment/src/domain/entities/ujian_entity.dart';
import 'package:recruitment/src/domain/entities/user_entity.dart';

class DashboardRemoteDataSourceImpl implements DashboardRemoteDataSource {
  @override
  Stream<List<DiscEntity>> streamDisc() {
    final stream = FirebaseFirestore.instance
        .collection("ujian")
        .doc("disc")
        .collection("soal")
        .snapshots();
    return stream.map((e) => e.docs).map((ev) {
      return discSoalFromJson(
          json.encode(ev.map((data) => data.data()).toList()));
    });
  }

  @override
  Future<bool> createSoalDisc(Map<String, dynamic> data) async {
    return await FirebaseFirestore.instance
        .collection("ujian")
        .doc("disc")
        .collection("soal")
        .doc(data["id"])
        .set(data)
        .then((value) => true)
        .onError((error, stackTrace) =>
            ExceptionHandleDataSource.execute(500, "Failed connect to server"));
  }

  @override
  Stream<List<UserEntity>> streamUsers() {
    final stream = FirebaseFirestore.instance
        .collection("users")
        .where("role", isEqualTo: 2)
        .snapshots();
    return stream.map((e) => e.docs).map((ev) {
      final data =
          usersFromJson(json.encode(ev.map((data) => data.data()).toList()));
      return data;
    });
  }

  @override
  Future<bool> deleteSoalDisc(String id) async {
    return await FirebaseFirestore.instance
        .collection("ujian")
        .doc("disc")
        .collection("soal")
        .doc(id)
        .delete()
        .then((value) => true)
        .onError((error, stackTrace) =>
            ExceptionHandleDataSource.execute(500, "Failed connect to server"));
  }

  @override
  Future<bool> updateSoalDisc(Map<String, dynamic> data) async {
    return await FirebaseFirestore.instance
        .collection("ujian")
        .doc("disc")
        .collection("soal")
        .doc(data["id"])
        .update(data)
        .then((value) => true)
        .onError((error, stackTrace) =>
            ExceptionHandleDataSource.execute(500, "Failed connect to server"));
  }

  @override
  Future<UjianEntity> getUjianDetail(String id) async {
    final response =
        await FirebaseFirestore.instance.collection("ujian").doc(id).get();
    if (response.data() != null) {
      return UjianEntity.fromJson(response.data()!);
    }

    return ExceptionHandleDataSource.execute(404, "Data is not found");
  }

  @override
  Future<bool> updateInstruksi(Map<String, dynamic> data) async {
    final response = await FirebaseFirestore.instance
        .collection("ujian")
        .doc(data["id"])
        .get();

    if (response.exists) {
      return await FirebaseFirestore.instance
          .collection("ujian")
          .doc(data["id"])
          .update(data)
          .then((value) => true)
          .onError((error, stackTrace) => ExceptionHandleDataSource.execute(
              500, "Failed connect to server"));
    } else {
      return await FirebaseFirestore.instance
          .collection("ujian")
          .doc(data["id"])
          .set(data)
          .then((value) => true)
          .onError((error, stackTrace) => ExceptionHandleDataSource.execute(
              500, "Failed connect to server"));
    }
  }

  @override
  Future<bool> addNewUser(UserEntity user) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(user.username)
        .set(user.toJson())
        .then((value) => true)
        .onError((error, stackTrace) =>
            ExceptionHandleDataSource.execute(500, "Failed connect to server"));
  }

  @override
  Future<bool> updateUser(UserEntity user) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(user.username)
        .update(user.toJson())
        .then((value) => true)
        .onError((error, stackTrace) {
      debugPrint("ERR : ${error.toString()}");
      return ExceptionHandleDataSource.execute(500, "Failed connect to server");
    });
  }

  @override
  Future<bool> deleteUser(String username) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(username)
        .delete()
        .then((value) => true)
        .onError((error, stackTrace) =>
            ExceptionHandleDataSource.execute(500, "Failed connect to server"));
  }
}
