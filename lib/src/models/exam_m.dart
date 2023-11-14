import 'dart:convert';

ExamM examMFromJson(String str) => ExamM.fromJson(json.decode(str));

String examMToJson(ExamM data) => json.encode(data.toJson());

class ExamM {
  final String id;
  final String title;
  final String created;
  final String updated;
  final String type;
  final int time;
  final int number;
  final List<String> users;

  ExamM({
    required this.id,
    required this.title,
    required this.created,
    required this.updated,
    required this.type,
    required this.time,
    required this.number,
    required this.users,
  });

  ExamM copyWith({
    String? id,
    String? title,
    String? created,
    String? updated,
    String? type,
    int? time,
    int? number,
    List<String>? users,
  }) =>
      ExamM(
        id: id ?? this.id,
        title: title ?? this.title,
        created: created ?? this.created,
        updated: updated ?? this.updated,
        type: type ?? this.type,
        time: time ?? this.time,
        number: number ?? this.number,
        users: users ?? this.users,
      );

  factory ExamM.fromJson(Map<String, dynamic> json) => ExamM(
        id: json["id"],
        title: json["title"],
        created: json["created"],
        updated: json["updated"],
        type: json["type"],
        time: json["time"],
        number: json["number"],
        users: json["users"] == null
            ? []
            : List<String>.from(json["users"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "created": created,
        "updated": updated,
        "type": type,
        "time": time,
        "number": number,
        "users": users,
      };
}
