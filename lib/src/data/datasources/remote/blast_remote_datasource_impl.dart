import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:recruitment/src/core/exception_handling.dart';

import '../../../../utils/app_url.dart';
import '../../../core/dio_option.dart';
import '../../../core/interceptor.dart';
import 'blast_remote_datasource.dart';

class BlastRemoteDataSourceImpl implements BlastRemoteDataSource {
  late Dio dio;
  BlastRemoteDataSourceImpl({Dio? dio}) {
    this.dio = dio ?? Dio();
  }
  @override
  Future<bool> sendMessage(String token, Map<String, dynamic> body) async {
    await dioInterceptorWA(dio, token);
    final response = await dio.post(
      messageWaUrl,
      data: body,
      options: dioOption(),
    );
    debugPrint("BODY SEND MESSAGE : $body");
    debugPrint("RESPONSE SEND MESSAGE : ${response.data}");
    return true;
  }

  @override
  Future<String> getTokenWA() async {
    final response = await FirebaseFirestore.instance
        .collection("configuration")
        .doc("token-wa")
        .get();
    if (response.exists) {
      return response.data()!["token"];
    }

    return ExceptionHandleDataSource.execute(404, "Data not found");
  }
}
