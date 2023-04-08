part of 'papi_bloc.dart';

class PapiState extends Equatable {
  const PapiState({
    this.type = "Instruksi",
    this.isUpdateInstruksi = false,
  });

  final String type;
  final bool isUpdateInstruksi;

  PapiState copyWith({
    String? type,
    bool? isUpdateInstruksi,
  }) =>
      PapiState(
        type: type ?? this.type,
        isUpdateInstruksi: isUpdateInstruksi ?? this.isUpdateInstruksi,
      );

  @override
  List<Object> get props => [type, isUpdateInstruksi];
}

class PapiInitial extends PapiState {}
