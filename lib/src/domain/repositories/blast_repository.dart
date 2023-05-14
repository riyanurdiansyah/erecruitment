import 'package:dartz/dartz.dart';

import '../../core/failure.dart';

abstract class BlastRepository {
  Future<Either<Failure, bool>> sendMessage(
      String token, Map<String, dynamic> body);

  Future<Either<Failure, String>> getTokenWA();
}
