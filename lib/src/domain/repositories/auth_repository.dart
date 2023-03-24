import 'package:dartz/dartz.dart';
import 'package:recruitment/src/domain/entities/user_spf_entity.dart';

import '../../core/failure.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserSpfEntity>> getUser(
      String username, String password);
}
