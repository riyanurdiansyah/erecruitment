import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:recruitment/src/core/exception_handling.dart';
import 'package:recruitment/src/domain/entities/user_spf_entity.dart';

import 'auth_remote_datasource.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  @override
  Future<UserSpfEntity> getUser(String username, String password) async {
    final response = await FirebaseFirestore.instance
        .collection("users")
        .doc(username)
        .get();
    if (response.data() != null) {
      return UserSpfEntity.fromJson(response.data()!);
    }
    return ExceptionHandleDataSource.execute(404, "Username tidak terdaftar");
  }
}
