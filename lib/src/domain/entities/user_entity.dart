import 'dart:convert';

import 'package:equatable/equatable.dart';

List<UserEntity> usersFromJson(String str) =>
    List<UserEntity>.from(json.decode(str).map((x) => UserEntity.fromJson(x)));

class UserEntity extends Equatable {
  UserEntity({
    required this.nama,
    required this.username,
    required this.email,
    required this.posisi,
    required this.noHp,
    required this.tanggalMulai,
    required this.tanggalSelesai,
    required this.ujians,
    required this.role,
    required this.kodeAkses,
    this.number = 0,
    this.page = 0,
  });

  final String nama;
  final String username;
  final String email;
  final String posisi;
  final int noHp;
  final String tanggalMulai;
  final String tanggalSelesai;
  final List<String> ujians;
  final int role;
  final String kodeAkses;
  int number;
  int page;

  @override
  List<Object?> get props => [
        nama,
        username,
        email,
        posisi,
        noHp,
        tanggalMulai,
        tanggalSelesai,
        ujians,
        role,
        kodeAkses,
        number,
        page,
      ];

  factory UserEntity.fromJson(Map<String, dynamic> json) => UserEntity(
        nama: json['nama'] ?? "",
        username: json['username'] ?? "",
        email: json['email'] ?? "",
        noHp: json['no_hp'] ?? 0,
        posisi: json['posisi'],
        tanggalMulai: json['tanggal_mulai'],
        tanggalSelesai: json['tanggal_berakhir'],
        ujians: json["ujian"] == null ? [] : List<String>.from(json["ujian"]),
        role: json['role'],
        kodeAkses: json['kode_akses'],
      );

  Map<String, dynamic> toJson() {
    return {
      "nama": nama,
      "username": username,
      "email": email,
      "no_hp": noHp,
      "posisi": posisi,
      "tanggal_mulai": tanggalMulai,
      "tanggal_berakhir": tanggalSelesai,
      "ujian": ujians,
      "role": role,
      "kode_akses": kodeAkses,
    };
  }
}
