import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

/*
  INI UNTUK INTERCEPT TOKEN
  BISA JUGA UNTUK REFRESH TOKEN KALAU TOKEN EXPIRED
  JIK PAKAI JWT NANTI
*/
Future dioInterceptor(Dio dio) async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString("user_token");
  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (
        options,
        handler,
      ) async {
        final Map<String, dynamic> headers = {
          "Authorization": "Bearer $token",
          "Accept": "application/json",
          "Content-Type": "application/json",
        };
        options.headers.addAll(headers);
        return handler.next(options);
      },
      onResponse: (response, handler) {
        // SharedPreferences prefs = await SharedPreferences.getInstance();
        // prefs.clear();
        if (response.statusCode == 401) {}
        return handler.next(response);
      },
      onError: (error, handler) async {
        if (error.response!.statusCode == 401) {
          log("TOKEN UNAUTHORIZED");
        }
        return handler.next(error);
      },
    ),
  );
}

Future dioInterceptorWA(Dio dio, String token) async {
  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (
        options,
        handler,
      ) async {
        final Map<String, dynamic> headers = {
          "Authorization": "Bearer $token",
          "Accept": "application/json",
          "Content-Type": "application/json",
        };
        options.headers.addAll(headers);
        return handler.next(options);
      },
      onResponse: (response, handler) {
        if (response.statusCode == 401) {}
        return handler.next(response);
      },
      onError: (error, handler) async {
        if (error.response!.statusCode == 401) {
          log("TOKEN UNAUTHORIZED");
        }
        return handler.next(error);
      },
    ),
  );
}
