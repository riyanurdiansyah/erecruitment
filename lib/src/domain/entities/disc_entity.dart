import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:recruitment/utils/app_empty_entity.dart';

List<DiscEntity> discSoalFromJson(String str) =>
    List<DiscEntity>.from(json.decode(str).map((x) => DiscEntity.fromJson(x)));

class DiscEntity extends Equatable {
  DiscEntity({
    required this.id,
    required this.soal,
    required this.status,
    required this.updateBy,
    required this.responses,
    this.number = 0,
    this.page = 0,
  });
  final String id;
  final List<String> soal;
  final bool status;
  final DiscUpdateByEntity updateBy;
  final List<dynamic> responses;
  int number;
  int page;

  @override
  List<Object?> get props => [
        id,
        soal,
        status,
        updateBy,
        responses,
        number,
        page,
      ];

  factory DiscEntity.fromJson(Map<String, dynamic> json) => DiscEntity(
        id: json['id'],
        soal: json['soal'] == null ? [] : List<String>.from(json['soal']),
        status: json['status'] ?? false,
        updateBy: json['update_by'] == null
            ? emptyDiscUpdateBy
            : DiscUpdateByEntity.fromJson(json['update_by']),
        responses: const [],
        number: 0,
        page: 0,
      );

  Map<String, dynamic> toJson() => {
        // "responses": List<dynamic>.from(responses.map((x) => x)),
        "soal": List<String>.from(soal.map((x) => x)),
        "id": id,
        "status": status,
        "update_by": updateBy.toJson(),
      };
}

class DiscUpdateByEntity extends Equatable {
  const DiscUpdateByEntity({
    required this.user,
    required this.date,
  });

  final String user;
  final String date;

  factory DiscUpdateByEntity.fromJson(Map<String, dynamic> json) =>
      DiscUpdateByEntity(
        user: json['user'] ?? "",
        date: json['date'] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "user": user,
        "date": date,
      };

  @override
  List<Object?> get props => [user, date];
}
