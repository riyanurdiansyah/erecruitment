import 'package:dartz/dartz.dart';
import 'package:recruitment/src/core/failure.dart';
import 'package:recruitment/src/domain/entities/disc_entity.dart';
import 'package:recruitment/src/domain/entities/ujian_entity.dart';
import 'package:recruitment/src/domain/entities/user_entity.dart';
import 'package:recruitment/src/domain/repositories/dashboard_repository.dart';

class DashboardUseCase {
  final DashboardRepository _repository;

  DashboardUseCase(this._repository);

  Stream<List<DiscEntity>> streamDisc() => _repository.streamDisc();

  Stream<List<UserEntity>> streamUsers() => _repository.streamUsers();

  Future<Either<Failure, bool>> addNewUser(UserEntity user) async =>
      await _repository.addNewUser(user);

  Future<Either<Failure, bool>> updateUser(UserEntity user) async =>
      await _repository.updateUser(user);

  Future<Either<Failure, bool>> deleteUser(String username) async =>
      await _repository.deleteUser(username);

  Future<Either<Failure, bool>> createSoalDisc(
          Map<String, dynamic> data) async =>
      await _repository.createSoalDisc(data);

  Future<Either<Failure, bool>> updateSoalDisc(
          Map<String, dynamic> data) async =>
      await _repository.updateSoalDisc(data);

  Future<Either<Failure, bool>> updateInstruksi(
          Map<String, dynamic> data) async =>
      await _repository.updateInstruksi(data);

  Future<Either<Failure, bool>> deleteSoalDisc(String id) async =>
      await _repository.deleteSoalDisc(id);

  Future<Either<Failure, UjianEntity>> getUjianDetail(String id) async =>
      await _repository.getUjianDetail(id);
}
