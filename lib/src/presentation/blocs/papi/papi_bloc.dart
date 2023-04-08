import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../utils/app_dialog.dart';
import '../../../data/datasources/remote/dashboard_remote_datasource_impl.dart';
import '../../../data/repositories/dashboard_repository_impl.dart';
import '../../../domain/usecases/dashboard_usecase.dart';

part 'papi_event.dart';
part 'papi_state.dart';

class PapiBloc extends Bloc<PapiEvent, PapiState> {
  final globalKey = GlobalKey<ScaffoldState>();
  late DashboardRemoteDataSourceImpl _datasource;
  late DashboardRepositoryImpl _repository;
  late DashboardUseCase _usecase;

  late SharedPreferences _prefs;

  TextEditingController tcOption = TextEditingController();

  TextEditingController tcInstruksi = TextEditingController();
  TextEditingController tcMaxSoal = TextEditingController();
  TextEditingController tcWaktu = TextEditingController();
  PapiBloc() : super(PapiInitial()) {
    on<PapiEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<PapiInitializeEvent>(_onInitialize);
    on<PapiOnChangeTypeEvent>(_onChangeType);
    on<PapiGetInstruksiDetailEvent>(_onGetInstruksiDetail);
    on<PapiUpdateUjianDetailEvent>(_onUpdateUjianDetail);
  }

  FutureOr<void> _onChangeType(
      PapiOnChangeTypeEvent event, Emitter<PapiState> emit) {
    emit(state.copyWith(type: event.type));
  }

  FutureOr<void> _onGetInstruksiDetail(
      PapiGetInstruksiDetailEvent event, Emitter<PapiState> emit) async {
    final response = await _usecase.getUjianDetail("papi-kostick");
    response.fold((l) => null, (data) {
      tcInstruksi.text = data.instruksi;
      tcMaxSoal.text = data.maxSoal.toString();
      tcWaktu.text = data.waktu.toString();
    });
  }

  FutureOr<void> _onInitialize(
      PapiInitializeEvent event, Emitter<PapiState> emit) {
    _datasource = DashboardRemoteDataSourceImpl();
    _repository = DashboardRepositoryImpl(_datasource);
    _usecase = DashboardUseCase(_repository);
    add(PapiGetInstruksiDetailEvent());
  }

  FutureOr<void> _onUpdateUjianDetail(
      PapiUpdateUjianDetailEvent event, Emitter<PapiState> emit) async {
    if (state.isUpdateInstruksi) {
      final body = {
        "id": "papi-kostick",
        "max_soal": int.parse(tcMaxSoal.text),
        "waktu": int.parse(tcWaktu.text),
        "instruksi": tcInstruksi.text,
      };

      final response = await _usecase.updateInstruksi(body);
      response.fold(
          (l) => AppDialog.dialogNoAction(
              context: globalKey.currentContext!, title: "Gagal update data"),
          (r) => AppDialog.dialogNoAction(
              context: globalKey.currentContext!,
              title: "Data berhasil diupdate"));
    }

    emit(state.copyWith(isUpdateInstruksi: !state.isUpdateInstruksi));
  }
}
