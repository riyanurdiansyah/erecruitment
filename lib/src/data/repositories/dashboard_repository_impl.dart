import 'package:recruitment/src/core/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:recruitment/src/data/datasources/remote/dashbord_remote_datasource.dart';
import 'package:recruitment/src/domain/entities/disc_entity.dart';
import 'package:recruitment/src/domain/entities/ujian_entity.dart';
import 'package:recruitment/src/domain/entities/user_entity.dart';
import 'package:recruitment/src/domain/repositories/dashboard_repository.dart';

import '../../core/exception_handling.dart';

class DashboardRepositoryImpl implements DashboardRepository {
  final DashboardRemoteDataSource _datasource;

  DashboardRepositoryImpl(this._datasource);

  @override
  Stream<List<DiscEntity>> streamDisc() {
    return _datasource.streamDisc().map((event) => event);
  }

  @override
  Stream<List<UserEntity>> streamUsers() {
    return _datasource.streamUsers().map((event) => event);
  }

  @override
  Future<Either<Failure, bool>> createSoalDisc(
      Map<String, dynamic> data) async {
    try {
      final response = await _datasource.createSoalDisc(data);
      return Right(response);
    } catch (e) {
      return Left(ExceptionHandleRepository.execute(e));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteSoalDisc(String id) async {
    try {
      final response = await _datasource.deleteSoalDisc(id);
      return Right(response);
    } catch (e) {
      return Left(ExceptionHandleRepository.execute(e));
    }
  }

  @override
  Future<Either<Failure, bool>> updateSoalDisc(
      Map<String, dynamic> data) async {
    try {
      final response = await _datasource.updateSoalDisc(data);
      return Right(response);
    } catch (e) {
      return Left(ExceptionHandleRepository.execute(e));
    }
  }

  @override
  Future<Either<Failure, UjianEntity>> getUjianDetail(String id) async {
    try {
      final response = await _datasource.getUjianDetail(id);
      return Right(response);
    } catch (e) {
      return Left(ExceptionHandleRepository.execute(e));
    }
  }

  @override
  Future<Either<Failure, bool>> updateInstruksi(
      Map<String, dynamic> data) async {
    try {
      final response = await _datasource.updateInstruksi(data);
      return Right(response);
    } catch (e) {
      return Left(ExceptionHandleRepository.execute(e));
    }
  }

  @override
  Future<Either<Failure, bool>> addNewUser(UserEntity user) async {
    try {
      final response = await _datasource.addNewUser(user);
      return Right(response);
    } catch (e) {
      return Left(ExceptionHandleRepository.execute(e));
    }
  }

  @override
  Future<Either<Failure, bool>> updateUser(UserEntity user) async {
    try {
      final response = await _datasource.updateUser(user);
      return Right(response);
    } catch (e) {
      return Left(ExceptionHandleRepository.execute(e));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteUser(String username) async {
    try {
      final response = await _datasource.deleteUser(username);
      return Right(response);
    } catch (e) {
      return Left(ExceptionHandleRepository.execute(e));
    }
  }
}
