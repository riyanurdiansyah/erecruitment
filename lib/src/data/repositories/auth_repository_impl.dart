import 'package:crypt/crypt.dart';
import 'package:dartz/dartz.dart';
import 'package:recruitment/src/core/exception.dart';
import 'package:recruitment/src/core/exception_handling.dart';
import 'package:recruitment/src/core/failure.dart';
import 'package:recruitment/src/data/datasources/remote/auth_remote_datasource.dart';
import 'package:recruitment/src/domain/entities/user_spf_entity.dart';
import 'package:recruitment/src/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _datasource;

  AuthRepositoryImpl(this._datasource);

  @override
  Future<Either<Failure, UserSpfEntity>> getUser(
      String username, String password) async {
    try {
      final data = await _datasource.getUser(username, password);
      final hashPassword = Crypt.sha256(password);
      if (hashPassword.hash == data.password) {
        return Right(data);
      }

      return Left(ExceptionHandleRepository.execute(
          CustomException(400, "Password anda salah")));
    } catch (e) {
      return Left(ExceptionHandleRepository.execute(e));
    }
  }
}
