import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextNormal {
  static labelNormal(
    String title,
    double fontSize,
    Color colors, {
    String? familiy,
    TextAlign? textAlign,
    TextOverflow? overflow,
    int? maxLines,
    double? height,
  }) {
    return Text(
      title,
      textAlign: textAlign ?? TextAlign.start,
      maxLines: maxLines ?? 1,
      style: GoogleFonts.sourceSans3(
        fontWeight: FontWeight.normal,
        fontSize: fontSize,
        color: colors,
        height: height ?? 1.0,
      ),
    );
  }

  static labelW400(
    String title,
    double fontSize,
    Color colors, {
    String? familiy,
    TextAlign? textAlign,
    TextOverflow? overflow,
    int? maxLines,
    double? height,
    FontStyle? fontStyle,
  }) {
    return Text(
      title,
      textAlign: textAlign ?? TextAlign.start,
      maxLines: maxLines ?? 1,
      style: GoogleFonts.sourceSans3(
          fontWeight: FontWeight.w400,
          fontSize: fontSize,
          color: colors,
          fontStyle: fontStyle ?? FontStyle.normal,
          height: height ?? 1.0),
    );
  }

  static labelW500(String title, double fontSize, Color colors,
      {String? familiy,
      TextAlign? textAlign,
      TextOverflow? overflow,
      int? maxLines,
      FontStyle? fontStyle,
      double? height,
      bool? softWarp,
      double? letterSpacing}) {
    return Text(
      title,
      textAlign: textAlign ?? TextAlign.start,
      maxLines: maxLines ?? 1,
      style: GoogleFonts.sourceSans3(
        letterSpacing: letterSpacing,
        fontWeight: FontWeight.w500,
        fontSize: fontSize,
        color: colors,
        fontStyle: fontStyle ?? FontStyle.normal,
        height: height ?? 1.0,
      ),
    );
  }

  static labelW600(String title, double fontSize, Color colors,
      {String? familiy,
      TextAlign? textAlign,
      TextOverflow? overflow,
      int? maxLines,
      double? height,
      FontStyle? fontStyle,
      double? letterSpacing}) {
    return Text(
      title,
      textAlign: textAlign ?? TextAlign.start,
      maxLines: maxLines ?? 1,
      style: GoogleFonts.sourceSans3(
          letterSpacing: letterSpacing,
          fontWeight: FontWeight.w600,
          fontSize: fontSize,
          color: colors,
          fontStyle: fontStyle ?? FontStyle.normal,
          height: height ?? 1.0),
    );
  }

  static labelW700(
    String title,
    double fontSize,
    Color colors, {
    String? familiy,
    TextAlign? textAlign,
    TextOverflow? overflow,
    int? maxLines,
    double? height,
  }) {
    return Text(
      title,
      textAlign: textAlign ?? TextAlign.start,
      maxLines: maxLines ?? 1,
      style: GoogleFonts.sourceSans3(
        fontWeight: FontWeight.w700,
        fontSize: fontSize,
        color: colors,
        height: height ?? 1.0,
      ),
    );
  }

  static labelW800(
    String title,
    double fontSize,
    Color colors, {
    String? familiy,
    TextAlign? textAlign,
    TextOverflow? overflow,
    int? maxLines,
  }) {
    return Text(
      title,
      textAlign: textAlign ?? TextAlign.start,
      maxLines: maxLines ?? 1,
      style: GoogleFonts.sourceSans3(
        fontWeight: FontWeight.w800,
        fontSize: fontSize,
        color: colors,
      ),
    );
  }

  static labelW900(
    String title,
    double fontSize,
    Color colors, {
    String? familiy,
    TextAlign? textAlign,
    TextOverflow? overflow,
    int? maxLines,
  }) {
    return Text(
      title,
      textAlign: textAlign ?? TextAlign.start,
      maxLines: maxLines ?? 1,
      style: GoogleFonts.sourceSans3(
        fontWeight: FontWeight.w900,
        fontSize: fontSize,
        color: colors,
      ),
    );
  }

  static labelBold(
    String title,
    double fontSize,
    Color colors, {
    String? familiy,
    TextAlign? textAlign,
    TextOverflow? overflow,
    int? maxLines,
    double? height,
  }) {
    return Text(
      title,
      textAlign: textAlign ?? TextAlign.start,
      maxLines: maxLines ?? 1,
      style: GoogleFonts.sourceSans3(
        fontWeight: FontWeight.bold,
        fontSize: fontSize,
        color: colors,
        height: height ?? 1.0,
      ),
    );
  }
}
