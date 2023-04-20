class UserSpfEntity {
  UserSpfEntity({
    required this.username,
    required this.role,
    required this.tanggalMulai,
    required this.tanggalBerakhir,
    required this.password,
    required this.kodeAkses,
  });

  final String username;
  final int role;
  final String tanggalMulai;
  final String tanggalBerakhir;
  final String password;
  final String kodeAkses;

  UserSpfEntity copyWith({
    String? username,
    int? role,
    String? tanggalMulai,
    String? tanggalBerakhir,
    String? password,
    String? kodeAkses,
  }) =>
      UserSpfEntity(
        username: username ?? this.username,
        role: role ?? this.role,
        tanggalMulai: tanggalMulai ?? this.tanggalMulai,
        tanggalBerakhir: tanggalBerakhir ?? this.tanggalBerakhir,
        password: password ?? this.password,
        kodeAkses: kodeAkses ?? this.kodeAkses,
      );

  factory UserSpfEntity.fromJson(Map<String, dynamic> json) => UserSpfEntity(
        username: json["username"],
        role: json["role"],
        tanggalMulai: json["tanggal_mulai"],
        tanggalBerakhir: json["tanggal_berakhir"],
        password: json["password"] ?? "",
        kodeAkses: json["kode_akses"],
      );
}
