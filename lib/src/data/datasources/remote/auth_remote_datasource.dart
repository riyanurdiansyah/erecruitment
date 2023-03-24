import 'package:recruitment/src/domain/entities/user_spf_entity.dart';

abstract class AuthRemoteDataSource {
  Future<UserSpfEntity> getUser(String username, String password);
}
