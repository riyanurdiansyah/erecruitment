part of 'papi_bloc.dart';

abstract class PapiEvent extends Equatable {
  const PapiEvent();

  @override
  List<Object> get props => [];
}

class PapiInitializeEvent extends PapiEvent {}

class PapiOnChangeTypeEvent extends PapiEvent {
  const PapiOnChangeTypeEvent(this.type);

  final String type;
}

class PapiGetInstruksiDetailEvent extends PapiEvent {}

class PapiUpdateUjianDetailEvent extends PapiEvent {}
