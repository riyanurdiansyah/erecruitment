import 'dart:async';

import 'package:camera/camera.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recruitment/src/domain/entities/disc_entity.dart';
import 'package:recruitment/utils/app_dialog.dart';
import 'package:recruitment/utils/app_empty_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import '../../../../services/app_camera.dart';
import '../../../data/datasources/remote/dashboard_remote_datasource_impl.dart';
import '../../../data/repositories/dashboard_repository_impl.dart';
import '../../../domain/entities/ujian_entity.dart';
import '../../../domain/usecases/dashboard_usecase.dart';

part 'disc_event.dart';
part 'disc_state.dart';

class DiscBloc extends Bloc<DiscEvent, DiscState> {
  final globalKey = GlobalKey<ScaffoldState>();
  late AppCameraService cameraService;
  CameraController? cameraController;
  late DashboardRemoteDataSourceImpl _datasource;
  late DashboardRepositoryImpl _repository;
  late DashboardUseCase _usecase;

  late SharedPreferences _prefs;

  TextEditingController tcOption = TextEditingController();

  TextEditingController tcInstruksi = TextEditingController();
  TextEditingController tcMaxSoal = TextEditingController();
  TextEditingController tcWaktu = TextEditingController();

  @override
  Future<void> close() {
    cameraController?.dispose();
    return super.close();
  }

  DiscBloc() : super(DiscInitial()) {
    on<DiscEvent>((event, emit) {});
    on<DiscInitialEvent>(_onInitialize);

    on<DiscOnChangeTypeEvent>(_onChangeType);
    on<DiscInsertDataToListTempEvent>(_onInsertData);
    on<DiscCreateSoalEvent>(_onCreateSoal);
    on<DiscTakeQuiz>(_onTakeQuiz);
    on<DiscPreviewEvent>(_onPreview);
    on<DiscOnChangeIndexPreviewEvent>(_onChangeIndexPreview);
    on<DiscOnChangeRadio>(_onChangeRadio);
    on<DiscUpdateSoalEvent>(_onUpdateDiscSoal);
    on<DiscDeleteSoalEvent>(_onDeleteDiscSoal);
    on<DiscAddDataToListEvent>(_onAddDataToListInstruksi);
    on<DiscUpdateUjianDetail>(_onUpdateUjianDetail);
    on<DiscOnChangePageEvent>(_onChangePage);
    on<DiscUpdateListDataEvent>(_onUpdateList);
  }

  FutureOr<void> _onChangeType(
      DiscOnChangeTypeEvent event, Emitter<DiscState> emit) {
    emit(state.copyWith(type: event.type));
  }

  Stream<List<DiscEntity>> streamDisc() {
    return _usecase.streamDisc().map((data) {
      add(DiscUpdateListDataEvent(data));
      return data;
    });
  }

  Stream<List<DiscEntity>> streamDiscWhereActive() {
    return _usecase.streamDisc().map((data) {
      return data.where((e) => e.status == true).toList();
    });
  }

  Future<UjianEntity> getUjianDetail() async {
    final response = await _usecase.getUjianDetail("disc");

    return response.fold((l) => emptyUjianDetail, (data) {
      tcInstruksi.text = data.instruksi;
      tcMaxSoal.text = data.maxSoal.toString();
      tcWaktu.text = data.waktu.toString();
      return data;
    });
  }

  FutureOr<void> _onInitialize(
      DiscInitialEvent event, Emitter<DiscState> emit) async {
    _datasource = DashboardRemoteDataSourceImpl();
    _repository = DashboardRepositoryImpl(_datasource);
    _usecase = DashboardUseCase(_repository);
    getUjianDetail();
    _prefs = await SharedPreferences.getInstance();
    cameraService = AppCameraService();
    // try {
    //   cameraController = await cameraService.getCameraController(
    //       ResolutionPreset.medium, CameraLensDirection.front);
    //   await cameraController!.initialize();
    //   await cameraController!.startVideoRecording();
    //   emit(CameraReadyState().copyWith(isRecording: true));
    //   debugPrint("CEK : ${state.isRecording}");
    // } on CameraException catch (e) {
    //   debugPrint("ERROR CAMERA : ${e.toString()}");
    //   emit(CameraFailureState());
    // } catch (e) {
    //   debugPrint("ERROR CAMERA : ${e.toString()}");
    //   emit(CameraFailureState());
    // }
  }

  FutureOr<void> _onInsertData(
      DiscInsertDataToListTempEvent event, Emitter<DiscState> emit) {}

  FutureOr<void> _onCreateSoal(
      DiscCreateSoalEvent event, Emitter<DiscState> emit) async {
    final id = const Uuid().v4();
    final user = _prefs.getString("username");
    final body = {
      "responses": [],
      "soal": event.listSoal,
      "id": id,
      "status": event.status,
      "update_by": {
        "user": user,
        "date": DateTime.now().toIso8601String(),
      }
    };
    final response = await _usecase.createSoalDisc(body);
    response.fold(
        (l) => AppDialog.dialogNoAction(
            context: globalKey.currentContext!, title: "Gagal menambah data"),
        (r) => AppDialog.dialogNoAction(
            context: globalKey.currentContext!,
            title: "Data berhasil ditambahkan"));
  }

  FutureOr<void> _onTakeQuiz(
      DiscTakeQuiz event, Emitter<DiscState> emit) async {
    // if (!cameraController!.value.isRecordingVideo) {
    //   debugPrint("KEPENCET 2");
    //   cameraController = await cameraService.getCameraController(
    //       ResolutionPreset.medium, CameraLensDirection.front);
    //   await cameraController!.initialize();
    //   await cameraController!.startVideoRecording();
    //   emit(state.copyWith(isRecording: true));
    //   // log("CEK : ${result}")
    //   // emit(CameraCaptureSuccessState(File(result.path)));
    // } else {
    //   debugPrint("KEPENCET 3");
    //   emit(state.copyWith(isRecording: false));
    //   await cameraController!
    //       .stopVideoRecording()
    //       .then((value) => debugPrint("CEK FILE : $value"));
    //   // emit(CameraCaptureFailureState());
    // }
  }

  FutureOr<void> _onPreview(DiscPreviewEvent event, Emitter<DiscState> emit) {
    emit(state.copyWith(showPreview: !state.showPreview));
  }

  FutureOr<void> _onChangeIndexPreview(
      DiscOnChangeIndexPreviewEvent event, Emitter<DiscState> emit) {
    emit(state.copyWith(indexPreview: event.index));
  }

  FutureOr<void> _onChangeRadio(
      DiscOnChangeRadio event, Emitter<DiscState> emit) {
    if (event.type == "sesuai") {
      debugPrint(state.answerTidakSesuai);
      debugPrint(event.answer);
      if (state.answerTidakSesuai != event.answer) {
        emit(state.copyWith(answerSesuai: event.answer));
      }
    } else {
      if (state.answerSesuai != event.answer) {
        emit(state.copyWith(answerTidakSesuai: event.answer));
      }
    }
  }

  FutureOr<void> _onUpdateDiscSoal(
      DiscUpdateSoalEvent event, Emitter<DiscState> emit) async {
    final body = event.disc.toJson();
    final response = await _usecase.updateSoalDisc(body);
    response.fold(
        (l) => AppDialog.dialogNoAction(
            context: globalKey.currentContext!, title: "Gagal update data"),
        (r) => AppDialog.dialogNoAction(
            context: globalKey.currentContext!,
            title: "Data berhasil diupdate"));
  }

  FutureOr<void> _onDeleteDiscSoal(
      DiscDeleteSoalEvent event, Emitter<DiscState> emit) async {
    final response = await _usecase.deleteSoalDisc(event.id);
    response.fold(
        (l) => AppDialog.dialogNoAction(
            context: globalKey.currentContext!, title: "Gagal menghapus data"),
        (r) => AppDialog.dialogNoAction(
            context: globalKey.currentContext!,
            title: "Data berhasil dihapus"));
  }

  FutureOr<void> _onAddDataToListInstruksi(
      DiscAddDataToListEvent event, Emitter<DiscState> emit) {
    debugPrint("CEK UP : ${event.instruksi}");
    // emit(state.copyWith(listInstruksi: event.instruksi));
  }

  FutureOr<void> _onUpdateUjianDetail(
      DiscUpdateUjianDetail event, Emitter<DiscState> emit) async {
    if (state.isUpdateInstruksi) {
      final body = {
        "id": "disc",
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

  FutureOr<void> _onChangePage(
      DiscOnChangePageEvent event, Emitter<DiscState> emit) {
    emit(state.copyWith(page: event.currPage));
  }

  FutureOr<void> _onUpdateList(
      DiscUpdateListDataEvent event, Emitter<DiscState> emit) {
    double page = 0;
    for (int i = 0; i < event.listData.length; i++) {
      page = (i + 1) / 4;
      event.listData[i].number = i + 1;
      if (page < 1) {
        event.listData[i].page = page.ceil();
      } else {
        event.listData[i].page = page.round();
      }
    }

    emit(state.copyWith(listData: event.listData));
  }
}
