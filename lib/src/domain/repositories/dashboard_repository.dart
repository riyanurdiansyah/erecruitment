import 'package:dartz/dartz.dart';
import 'package:recruitment/src/core/failure.dart';
import 'package:recruitment/src/domain/entities/disc_entity.dart';
import 'package:recruitment/src/domain/entities/ujian_entity.dart';
import 'package:recruitment/src/domain/entities/user_entity.dart';

abstract class DashboardRepository {
  Stream<List<DiscEntity>> streamDisc();

  Stream<List<UserEntity>> streamUsers();

  Future<Either<Failure, bool>> addNewUser(UserEntity user);

  Future<Either<Failure, bool>> updateUser(UserEntity user);

  Future<Either<Failure, bool>> deleteUser(String username);

  Future<Either<Failure, bool>> createSoalDisc(Map<String, dynamic> data);

  Future<Either<Failure, bool>> updateSoalDisc(Map<String, dynamic> data);

  Future<Either<Failure, bool>> updateInstruksi(Map<String, dynamic> data);

  Future<Either<Failure, bool>> deleteSoalDisc(String id);

  Future<Either<Failure, UjianEntity>> getUjianDetail(String id);
}
