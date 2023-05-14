import 'package:dartz/dartz.dart';

import '../../core/failure.dart';
import '../repositories/blast_repository.dart';

class BlastUseCase {
  final BlastRepository _repository;

  BlastUseCase(this._repository);

  Future<Either<Failure, bool>> sendMessage(
          String token, Map<String, dynamic> body) async =>
      await _repository.sendMessage(token, body);

  Future<Either<Failure, String>> getTokenWA() async =>
      await _repository.getTokenWA();
}
