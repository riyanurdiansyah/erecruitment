import 'dart:convert';

QuestionsM questionsMFromJson(String str) =>
    QuestionsM.fromJson(json.decode(str));

String questionsMToJson(QuestionsM data) => json.encode(data.toJson());

class QuestionsM {
  final String created;
  final String id;
  final String question;
  final String updated;
  final List<QuestionIstOptionM> options;
  final bool status;
  final int page;

  QuestionsM({
    required this.created,
    required this.id,
    required this.question,
    required this.updated,
    required this.options,
    required this.status,
    required this.page,
  });

  QuestionsM copyWith({
    String? created,
    String? id,
    String? question,
    String? updated,
    List<QuestionIstOptionM>? options,
    bool? status,
    int? page,
  }) =>
      QuestionsM(
        created: created ?? this.created,
        id: id ?? this.id,
        question: question ?? this.question,
        updated: updated ?? this.updated,
        options: options ?? this.options,
        status: status ?? this.status,
        page: page ?? this.page,
      );

  factory QuestionsM.fromJson(Map<String, dynamic> json) => QuestionsM(
        created: json["created"],
        id: json["id"],
        question: json["question"],
        updated: json["updated"],
        options: json["options"] == null
            ? []
            : List<QuestionIstOptionM>.from(
                json["options"].map((x) => QuestionIstOptionM.fromJson(x))),
        status: json["status"],
        page: 0,
      );

  Map<String, dynamic> toJson() => {
        "created": created,
        "id": id,
        "question": question,
        "updated": updated,
        "options": List<dynamic>.from(options.map((x) => x.toJson())),
        "status": status,
      };
}

class QuestionIstOptionM {
  final bool answer;
  final int point;
  final String teks;

  QuestionIstOptionM({
    required this.answer,
    required this.point,
    required this.teks,
  });

  QuestionIstOptionM copyWith({
    bool? answer,
    int? point,
    String? teks,
  }) =>
      QuestionIstOptionM(
        answer: answer ?? this.answer,
        point: point ?? this.point,
        teks: teks ?? this.teks,
      );

  factory QuestionIstOptionM.fromJson(Map<String, dynamic> json) =>
      QuestionIstOptionM(
        answer: json["answer"],
        point: json["point"],
        teks: json["teks"],
      );

  Map<String, dynamic> toJson() => {
        "answer": answer,
        "point": point,
        "teks": teks,
      };
}
