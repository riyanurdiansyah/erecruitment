import 'package:dio/dio.dart';

Options dioOption({
  Map<String, dynamic>? headers,
}) {
  return Options(
    followRedirects: false,
    validateStatus: (status) => true,
    headers: headers ??
        {
          "Access-Control-Allow-Origin": "*",
          "Access-Control-Allow-Methods": "GET,PUT,PATCH,POST,DELETE",
          "Access-Control-Allow-Headers":
              "Origin, X-Requested-With, Content-Type, Accept",
        },
    responseType: ResponseType.json,
    sendTimeout: const Duration(minutes: 3),
  );
}
