abstract class BlastRemoteDataSource {
  Future<bool> sendMessage(String token, Map<String, dynamic> body);

  Future<String> getTokenWA();
}
