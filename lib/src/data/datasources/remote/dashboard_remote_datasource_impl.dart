import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:recruitment/src/data/datasources/remote/dashbord_remote_datasource.dart';
import 'package:recruitment/src/domain/entities/disc_entity.dart';

class DashboardRemoteDataSourceImpl implements DashboardRemoteDataSource {
  @override
  Stream<List<DiscEntity>> streamDisc() {
    final stream = FirebaseFirestore.instance
        .collection("ujian")
        .doc("0F0TXZd3A7cX6O9BczPb")
        .collection("soal")
        .snapshots();
    return stream.map((e) => e.docs).map((ev) {
      return discSoalFromJson(
          json.encode(ev.map((data) => data.data()).toList()));
    });
  }
}
