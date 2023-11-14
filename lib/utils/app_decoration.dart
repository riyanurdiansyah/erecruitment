import 'package:flutter/material.dart';

InputDecoration textFieldAuthDecoration(
    {required double fontSize, required String hintText, double? radius}) {
  return InputDecoration(
    contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
    labelStyle: TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: fontSize,
    ),
    hintText: hintText,
    focusedErrorBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: Colors.red,
        ),
        borderRadius: BorderRadius.circular(5)),
    errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: Colors.red,
        ),
        borderRadius: BorderRadius.circular(5)),
    focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.blue),
        borderRadius: BorderRadius.circular(5)),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.grey.shade400,
      ),
      borderRadius: BorderRadius.circular(radius ?? 6),
    ),
  );
}
