import 'package:recruitment/src/domain/entities/disc_entity.dart';

abstract class DashboardRemoteDataSource {
  Stream<List<DiscEntity>> streamDisc();

  Future<bool> createSoalDisc(Map<String, dynamic> data);

  Future<bool> updateSoalDisc(Map<String, dynamic> data);

  Future<bool> deleteSoalDisc(String id);
}
