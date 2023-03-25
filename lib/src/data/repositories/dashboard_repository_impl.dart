import 'package:recruitment/src/data/datasources/remote/dashbord_remote_datasource.dart';
import 'package:recruitment/src/domain/entities/disc_entity.dart';
import 'package:recruitment/src/domain/repositories/dashboard_repository.dart';

class DashboardRepositoryImpl implements DashboardRepository {
  final DashboardRemoteDataSource _datasource;

  DashboardRepositoryImpl(this._datasource);

  @override
  Stream<List<DiscEntity>> streamDisc() {
    return _datasource.streamDisc().map((event) => event);
  }
}
