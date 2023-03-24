import 'dart:developer';

import 'exception.dart';
import 'failure.dart';

/*
  Handle error 
  Bisa digunakan untuk memberi 
  pesan ke user jika request nya gagal
*/
class ExceptionHandle {
  static execute(Failure fail) {
    if (fail is HttpFailure) {
      log("ERROR ${fail.code}x : ${fail.message}");
    } else {
      log("Error: Failed connect to server Please check your connection");
    }
  }
}

/*
  Handle error 
  Digunakan pada repository
  jika terjadi error pada proses try catch
*/
class ExceptionHandleRepository {
  static HttpFailure execute(Object e) {
    if (e is CustomException) {
      return HttpFailure(e.code, e.message);
    } else {
      return const HttpFailure(
        500,
        'Error... failed connect to server \nPlease check your connection',
      );
    }
  }
}

/*
  Handle error 
  Digunakan pada file datasource
  jika terjadi error pada proses hit API
*/
class ExceptionHandleDataSource {
  static execute(int code, String? errorMsg) {
    throw CustomException(
        code, errorMsg ?? 'Error... failed connect to server');
  }
}
