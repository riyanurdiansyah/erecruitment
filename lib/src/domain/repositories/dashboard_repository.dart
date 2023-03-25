import 'package:dartz/dartz.dart';
import 'package:recruitment/src/core/failure.dart';
import 'package:recruitment/src/domain/entities/disc_entity.dart';

abstract class DashboardRepository {
  Stream<List<DiscEntity>> streamDisc();

  Future<Either<Failure, bool>> createSoalDisc(Map<String, dynamic> data);
}
