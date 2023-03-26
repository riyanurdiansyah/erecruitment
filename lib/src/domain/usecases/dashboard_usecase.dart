import 'package:dartz/dartz.dart';
import 'package:recruitment/src/core/failure.dart';
import 'package:recruitment/src/domain/entities/disc_entity.dart';
import 'package:recruitment/src/domain/repositories/dashboard_repository.dart';

class DashboardUseCase {
  final DashboardRepository _repository;

  DashboardUseCase(this._repository);

  Stream<List<DiscEntity>> streamDisc() => _repository.streamDisc();

  Future<Either<Failure, bool>> createSoalDisc(
          Map<String, dynamic> data) async =>
      await _repository.createSoalDisc(data);

  Future<Either<Failure, bool>> updateSoalDisc(
          Map<String, dynamic> data) async =>
      await _repository.updateSoalDisc(data);

  Future<Either<Failure, bool>> deleteSoalDisc(String id) async =>
      await _repository.deleteSoalDisc(id);
}
