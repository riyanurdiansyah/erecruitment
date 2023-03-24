import 'package:dartz/dartz.dart';
import 'package:recruitment/src/core/failure.dart';
import 'package:recruitment/src/domain/entities/user_spf_entity.dart';
import 'package:recruitment/src/domain/repositories/auth_repository.dart';

class AuthUseCase {
  final AuthRepository _repository;

  AuthUseCase(this._repository);

  Future<Either<Failure, UserSpfEntity>> getUser(
          String username, String password) async =>
      await _repository.getUser(username, password);
}
