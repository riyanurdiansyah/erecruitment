import 'dart:async';

import 'package:camera/camera.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recruitment/src/domain/entities/disc_entity.dart';
import 'package:recruitment/utils/app_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../services/app_camera.dart';
import '../../../data/datasources/remote/dashboard_remote_datasource_impl.dart';
import '../../../data/repositories/dashboard_repository_impl.dart';
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
  }

  FutureOr<void> _onChangeType(
      DiscOnChangeTypeEvent event, Emitter<DiscState> emit) {
    emit(state.copyWith(type: event.type));
  }

  Stream<List<DiscEntity>> streamDisc() {
    return _usecase.streamDisc().map((data) {
      debugPrint("CEK DATA 2 : $data");
      return data;
    });
  }

  FutureOr<void> _onInitialize(
      DiscInitialEvent event, Emitter<DiscState> emit) async {
    debugPrint("SETUP DISC BLOC");
    _datasource = DashboardRemoteDataSourceImpl();
    _repository = DashboardRepositoryImpl(_datasource);
    _usecase = DashboardUseCase(_repository);
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
    final user = _prefs.getString("username");
    final body = {
      "responses": [],
      "soal": event.options,
      "status": true,
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
}
