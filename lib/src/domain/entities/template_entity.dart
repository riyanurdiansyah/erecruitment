import 'package:equatable/equatable.dart';

class TemplateEntity extends Equatable {
  const TemplateEntity({
    required this.name,
    required this.kode,
  });

  final String name;
  final String kode;

  @override
  List<Object?> get props => [name, kode];
}
