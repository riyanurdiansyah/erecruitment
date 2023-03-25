import 'package:recruitment/src/domain/entities/disc_entity.dart';
import 'package:recruitment/src/domain/repositories/dashboard_repository.dart';

class DashboardUseCase {
  final DashboardRepository _repository;

  DashboardUseCase(this._repository);

  Stream<List<DiscEntity>> streamDisc() => _repository.streamDisc();
}
