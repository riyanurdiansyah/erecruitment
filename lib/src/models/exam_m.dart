import 'dart:convert';

import 'package:equatable/equatable.dart';

ExamM examMFromJson(String str) => ExamM.fromJson(json.decode(str));

String examMToJson(ExamM data) => json.encode(data.toJson());

List<ExamM> examsMFromJson(String str) =>
    List<ExamM>.from(json.decode(str).map((x) => ExamM.fromJson(x)));

class ExamM extends Equatable {
  final String id;
  final String title;
  final String subname;
  final String created;
  final String updated;
  final String type;
  final String informasi;
  final int time;
  final int number;
  final List<String> users;
  final bool shuffle;

  const ExamM({
    required this.id,
    required this.title,
    required this.subname,
    required this.created,
    required this.updated,
    required this.type,
    required this.informasi,
    required this.time,
    required this.number,
    required this.users,
    required this.shuffle,
  });

  ExamM copyWith({
    String? id,
    String? title,
    String? subname,
    String? created,
    String? updated,
    String? type,
    String? informasi,
    int? time,
    int? number,
    List<String>? users,
    bool? shuffle,
  }) =>
      ExamM(
        id: id ?? this.id,
        title: title ?? this.title,
        subname: subname ?? this.subname,
        created: created ?? this.created,
        updated: updated ?? this.updated,
        type: type ?? this.type,
        informasi: informasi ?? this.informasi,
        time: time ?? this.time,
        number: number ?? this.number,
        users: users ?? this.users,
        shuffle: shuffle ?? this.shuffle,
      );

  factory ExamM.fromJson(Map<String, dynamic> json) => ExamM(
        id: json["id"],
        title: json["title"],
        created: json["created"],
        updated: json["updated"],
        type: json["type"],
        informasi: json["informasi"] ?? "",
        time: json["time"],
        number: json["number"],
        subname: json["subname"],
        users: json["users"] == null
            ? []
            : List<String>.from(json["users"].map((x) => x)),
        shuffle: json["shuffle"] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "subname": subname,
        "created": created,
        "updated": updated,
        "type": type,
        "informasi": informasi,
        "time": time,
        "number": number,
        "users": users,
        "shuffle": shuffle,
      };

  @override
  List<Object?> get props => [
        id,
        title,
        subname,
        created,
        updated,
        type,
        informasi,
        time,
        number,
        users,
        shuffle
      ];
}
