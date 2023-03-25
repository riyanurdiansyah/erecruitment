import 'package:recruitment/src/domain/entities/disc_entity.dart';

abstract class DashboardRemoteDataSource {
  Stream<List<DiscEntity>> streamDisc();

  Future<bool> createSoalDisc(Map<String, dynamic> data);
}
