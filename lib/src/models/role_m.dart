import 'dart:convert';

import 'package:equatable/equatable.dart';

RoleM roleMFromJson(String str) => RoleM.fromJson(json.decode(str));

String roleMToJson(RoleM data) => json.encode(data.toJson());

class RoleM extends Equatable {
  final String id;
  final String created;
  final String updated;
  final int roleId;
  final String roleName;
  final int page;

  const RoleM({
    required this.id,
    required this.created,
    required this.updated,
    required this.roleId,
    required this.roleName,
    required this.page,
  });

  RoleM copyWith({
    String? id,
    String? created,
    String? updated,
    int? roleId,
    String? roleName,
    int? page,
  }) =>
      RoleM(
        id: id ?? this.id,
        created: created ?? this.created,
        updated: updated ?? this.updated,
        roleId: roleId ?? this.roleId,
        roleName: roleName ?? this.roleName,
        page: page ?? this.page,
      );

  factory RoleM.fromJson(Map<String, dynamic> json) => RoleM(
        id: json["id"],
        created: json["created"],
        updated: json["updated"],
        roleId: json["role_id"],
        roleName: json["role_name"],
        page: json["page"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created": created,
        "updated": updated,
        "role_id": roleId,
        "role_name": roleName,
      };

  @override
  List<Object?> get props => [id, created, updated, roleId, roleName, page];
}
