import 'dart:developer';
import 'package:dartz/dartz.dart';

import '../../core/exception_handling.dart';
import '../../core/failure.dart';
import '../../domain/repositories/blast_repository.dart';
import '../datasources/remote/blast_remote_datasource.dart';

class BlastRepositoryImpl implements BlastRepository {
  final BlastRemoteDataSource _datasource;
  BlastRepositoryImpl(this._datasource);

  @override
  Future<Either<Failure, bool>> sendMessage(
      String token, Map<String, dynamic> body) async {
    try {
      final response = await _datasource.sendMessage(token, body);
      return Right(response);
    } catch (e) {
      log("ERROR SEND MESSAGE : ${e.toString()}");
      return Left(ExceptionHandleRepository.execute(e));
    }
  }

  @override
  Future<Either<Failure, String>> getTokenWA() async {
    try {
      final response = await _datasource.getTokenWA();
      return Right(response);
    } catch (e) {
      log("ERROR GET TOKEN : ${e.toString()}");
      return Left(ExceptionHandleRepository.execute(e));
    }
  }
}
