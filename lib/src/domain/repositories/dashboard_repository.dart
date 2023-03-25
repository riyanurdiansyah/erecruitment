import 'package:recruitment/src/domain/entities/disc_entity.dart';

abstract class DashboardRepository {
  Stream<List<DiscEntity>> streamDisc();
}
