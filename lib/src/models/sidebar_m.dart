import 'dart:convert';

SidebarM sidebarMFromJson(String str) => SidebarM.fromJson(json.decode(str));

String sidebarMToJson(SidebarM data) => json.encode(data.toJson());

class SidebarM {
  // final String image;
  final String route;
  final String id;
  final List<int> role;
  final String title;
  final String created;
  final String updated;

  SidebarM({
    // required this.image,
    required this.route,
    required this.id,
    required this.role,
    required this.title,
    required this.created,
    required this.updated,
  });

  SidebarM copyWith({
    // String? image,
    String? route,
    String? id,
    List<int>? role,
    String? title,
    String? created,
    String? updated,
  }) =>
      SidebarM(
        // image: image ?? this.image,
        route: route ?? this.route,
        id: id ?? this.id,
        role: role ?? this.role,
        title: title ?? this.title,
        created: created ?? this.created,
        updated: updated ?? this.updated,
      );

  factory SidebarM.fromJson(Map<String, dynamic> json) => SidebarM(
        // image: json["image"],
        route: json["route"],
        id: json["id"],
        role: List<int>.from(json["role"].map((x) => x)),
        title: json["title"],
        created: json["created"],
        updated: json["updated"],
      );

  Map<String, dynamic> toJson() => {
        // "image": image,
        "route": route,
        "id": id,
        "role": List<dynamic>.from(role.map((x) => x)),
        "title": title,
        "created": created,
        "updated": updated,
      };
}
