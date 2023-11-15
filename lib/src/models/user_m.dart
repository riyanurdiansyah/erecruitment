import 'dart:convert';

UserM userFromJson(String str) => UserM.fromJson(json.decode(str));

String userToJson(UserM data) => json.encode(data.toJson());

class UserM {
  final String email;
  final String ended;
  final String id;
  final List<String> quizes;
  final String started;
  final String username;
  final String name;
  final String position;
  final int role;

  UserM({
    required this.email,
    required this.ended,
    required this.id,
    required this.quizes,
    required this.started,
    required this.username,
    required this.name,
    required this.position,
    required this.role,
  });

  UserM copyWith({
    String? email,
    String? ended,
    String? id,
    List<String>? quizes,
    String? started,
    String? username,
    String? name,
    String? position,
    int? role,
  }) =>
      UserM(
        email: email ?? this.email,
        ended: ended ?? this.ended,
        id: id ?? this.id,
        quizes: quizes ?? this.quizes,
        started: started ?? this.started,
        username: username ?? this.username,
        name: name ?? this.name,
        position: position ?? this.position,
        role: role ?? this.role,
      );

  factory UserM.fromJson(Map<String, dynamic> json) => UserM(
        email: json["email"] ?? "",
        ended: json["ended"] ?? DateTime.now().toIso8601String(),
        id: json["id"] ?? "",
        quizes: json["quizes"] == null
            ? []
            : List<String>.from(json["quizes"].map((x) => x)),
        started: json["started"] ?? DateTime.now().toIso8601String(),
        username: json["username"] ?? "",
        role: json["role"] ?? 99,
        name: json["name"] ?? "",
        position: json["position"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "ended": ended,
        "id": id,
        "quizes": List<dynamic>.from(quizes.map((x) => x)),
        "started": started,
        "username": username,
        "role": role,
        "name": name,
        "position": position,
      };
}
