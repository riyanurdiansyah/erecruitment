import 'package:equatable/equatable.dart';

class UjianEntity extends Equatable {
  const UjianEntity({
    required this.maxSoal,
    required this.tipe,
    required this.instruksi,
    required this.waktu,
  });

  final int maxSoal;
  final String tipe;
  final String instruksi;
  final int waktu;

  @override
  List<Object?> get props => [];

  factory UjianEntity.fromJson(Map<String, dynamic> json) => UjianEntity(
        maxSoal: json["max_soal"] ?? 0,
        tipe: json["tipe"] ?? "",
        instruksi: json["instruksi"] ?? "",
        waktu: json["waktu"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "max_soal": maxSoal,
        "waktu": waktu,
        "tipe": tipe,
        "instruksi": instruksi,
      };
}
