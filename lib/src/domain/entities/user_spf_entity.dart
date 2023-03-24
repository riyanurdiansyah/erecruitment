class UserSpfEntity {
  UserSpfEntity({
    required this.username,
    required this.role,
    required this.tanggalMulai,
    required this.tanggalBerakhir,
    required this.password,
  });

  final String username;
  final int role;
  final String tanggalMulai;
  final String tanggalBerakhir;
  final String password;

  UserSpfEntity copyWith({
    String? username,
    int? role,
    String? tanggalMulai,
    String? tanggalBerakhir,
    String? password,
  }) =>
      UserSpfEntity(
        username: username ?? this.username,
        role: role ?? this.role,
        tanggalMulai: tanggalMulai ?? this.tanggalMulai,
        tanggalBerakhir: tanggalBerakhir ?? this.tanggalBerakhir,
        password: password ?? this.password,
      );

  factory UserSpfEntity.fromJson(Map<String, dynamic> json) => UserSpfEntity(
        username: json["username"],
        role: json["role"],
        tanggalMulai: json["tanggal_mulai"],
        tanggalBerakhir: json["tanggal_berakhir"],
        password: json["password"],
      );
}
