import 'dart:convert';

ExamTypeM examTypeMFromJson(String str) => ExamTypeM.fromJson(json.decode(str));

String examTypeMToJson(ExamTypeM data) => json.encode(data.toJson());

List<ExamTypeM> examsMFromJson(String str) =>
    List<ExamTypeM>.from(json.decode(str).map((x) => ExamTypeM.fromJson(x)));

class ExamTypeM {
  final String id;
  final String created;
  final String updated;
  final String type;
  final int page;

  ExamTypeM({
    required this.id,
    required this.created,
    required this.updated,
    required this.type,
    required this.page,
  });

  ExamTypeM copyWith({
    String? id,
    String? created,
    String? updated,
    String? type,
    int? page,
  }) =>
      ExamTypeM(
        id: id ?? this.id,
        created: created ?? this.created,
        updated: updated ?? this.updated,
        type: type ?? this.type,
        page: page ?? this.page,
      );

  factory ExamTypeM.fromJson(Map<String, dynamic> json) => ExamTypeM(
        id: json["id"],
        created: json["created"],
        updated: json["updated"],
        type: json["type"],
        page: json["page"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created": created,
        "updated": updated,
        "type": type,
      };
}
