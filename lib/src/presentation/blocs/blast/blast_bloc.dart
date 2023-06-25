import 'dart:convert';
import 'dart:developer';
import 'package:csv/csv.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../utils/app_dialog.dart';
import '../../../../utils/app_request_wa.dart';
import '../../../core/exception_handling.dart';
import '../../../data/datasources/remote/blast_remote_datasource.dart';
import '../../../data/datasources/remote/blast_remote_datasource_impl.dart';
import '../../../data/repositories/blast_repository_impl.dart';
import '../../../domain/entities/blast_entity.dart';
import '../../../domain/entities/template_entity.dart';
import '../../../domain/repositories/blast_repository.dart';
import '../../../domain/usecases/blast_usecase.dart';

part 'blast_event.dart';
part 'blast_state.dart';

class BlastBloc extends Bloc<BlastEvent, BlastState> {
  final globalKey = GlobalKey<ScaffoldState>();

  late BlastRemoteDataSource _datasource;
  late BlastRepository _repository;
  late BlastUseCase _usecase;

  final TextEditingController _tcToken = TextEditingController();
  TextEditingController get tcToken => _tcToken;

  final TextEditingController _tcTemplate = TextEditingController();
  TextEditingController get tcTemplate => _tcTemplate;

  BlastBloc() : super(BlastInitial()) {
    on<BlastEvent>(((event, emit) {}));
    on<BlastInitializeEvent>(_onInitialize);
    on<BlastSendMessageEvent>(_onSendMessage);
    on<BlastOnChangeTemplateEvent>(_onChangeTemplate);
    on<BlastUploadImageEvent>(_onUploadImage);
    on<BlastUploadCsvEvent>(_onUplaodCsvFile);
    on<BlastOnChangeTypeEvent>(_onChangeType);
    on<BlastOnChangeTextFieldEvent>(_onChangeTextField);
    on<BlastSendMultipleMessageEvent>(_onSendMultipleMessage);
  }

  void _onInitialize(event, emit) async {
    log("==========> INITIALIZE BLAST BLOC");
    log("CEK TOKEN : ${_tcToken.text}");
    _datasource = BlastRemoteDataSourceImpl();
    _repository = BlastRepositoryImpl(_datasource);
    _usecase = BlastUseCase(_repository);
    final response = await _usecase.getTokenWA();
    response.fold((l) => emit(state.copyWith(isLoading: false)), (data) {
      print("INI TOKEN : $data");
      _tcToken.text = data;
      emit(state.copyWith(isLoading: false));
    });
  }

  void _onSendMessage(event, emit) async {
    Map<String, dynamic> body = {};
    if (state.template.contains("custom")) {
      body = {
        "messaging_product": "whatsapp",
        "recipient_type": "individual",
        "to": state.hp,
        "type": "text",
        "text": {
          "body": state.custom,
        }
      };
    } else {
      body = AppRequestWA.bodyInfoUtama(
        nomorWA: state.hp,
        title: state.undangan,
        job: state.posisi,
        date: state.hari,
        time: state.jam,
        group: state.group,
        linkGroup: state.linkGroup,
        from: "Sike Avika",
        fromDivisi: "Marketing Development",
        fromEmail: state.emailPengirim,
      );
    }
    final response = await _usecase.sendMessage(_tcToken.text, body);
    response.fold((fail) => ExceptionHandle.execute(fail), (data) {
      if (data) {
        AppDialog.dialogNoAction(
          context: globalKey.currentContext!,
          title: "Pesan berhasil dikirim",
        );
      }
    });
  }

  void _onChangeTemplate(BlastOnChangeTemplateEvent event, emit) async {
    if (state.type != "Multiple") {
      _tcTemplate.text = event.template.kode;
      emit(state.copyWith(template: event.template.kode));
    } else {
      emit(state.copyWith(template: event.template.kode));
    }
  }

  void _onUploadImage(BlastUploadImageEvent event, emit) async {
    var result = await FilePicker.platform.pickFiles(
      allowedExtensions: ["jpg", "jpeg", "png"],
      type: FileType.custom,
      allowMultiple: false,
    );
    if (result != null) {
      emit(state.copyWith(imageFile: result.files.first.bytes!));
    }
  }

  void _onChangeType(BlastOnChangeTypeEvent event, emit) async {
    emit(state.copyWith(type: event.type, template: ""));
  }

  void _onUplaodCsvFile(BlastUploadCsvEvent event, emit) async {
    var result = await FilePicker.platform.pickFiles(
      allowedExtensions: ["csv"],
      type: FileType.custom,
      allowMultiple: false,
    );

    if (result != null) {
      final bytes = utf8.decode(result.files.first.bytes!);
      final rows = const CsvToListConverter().convert(bytes);
      List<BlastEntity> listTemp = [];
      for (int i = 0; i < rows.length; i++) {
        if (rows[i].elementAt(0).toString() != "NAMA") {
          listTemp.add(
            BlastEntity(
              nama: rows[i].elementAt(0).toString(),
              hp: rows[i].elementAt(1).toString(),
              posisi: rows[i].elementAt(2).toString(),
              hari: rows[i].elementAt(3).toString(),
              jam: rows[i].elementAt(4).toString(),
              group: rows[i].elementAt(5).toString(),
              linkGroup: rows[i].elementAt(6).toString(),
              pengirim: rows[i].elementAt(7).toString(),
              undangan: rows[i].elementAt(8).toString(),
              status: rows[i].elementAt(9).toString(),
            ),
          );
        }
      }

      emit(state.copyWith(
        csvFile: result.files.first.bytes!,
        listData: listTemp,
        showPreview: true,
      ));
    }
  }

  void _onChangeTextField(BlastOnChangeTextFieldEvent event, emit) async {
    if (event.type == "custom") {
      emit(state.copyWith(custom: event.text));
    }

    if (event.type == "hp") {
      emit(state.copyWith(hp: event.text));
    }

    if (event.type == "undangan") {
      emit(state.copyWith(undangan: event.text));
    }
    if (event.type == "posisi") {
      emit(state.copyWith(posisi: event.text));
    }
    if (event.type == "hari") {
      emit(state.copyWith(hari: event.text));
    }
    if (event.type == "jam") {
      emit(state.copyWith(jam: event.text));
    }
    if (event.type == "group") {
      emit(state.copyWith(group: event.text));
    }
    if (event.type == "linkgroup") {
      emit(state.copyWith(linkGroup: event.text));
    }
    if (event.type == "pengirim") {
      emit(state.copyWith(emailPengirim: event.text));
    }
  }

  void _onSendMultipleMessage(BlastSendMultipleMessageEvent event, emit) async {
    for (int i = 0; i < event.listData.length; i++) {
      Map<String, dynamic> body = {};

      if (state.template.contains("custom")) {
        body = {
          "messaging_product": "whatsapp",
          "recipient_type": "individual",
          "to": event.listData[i].hp,
          "type": "text",
          "text": {
            "body": state.custom,
          }
        };
      } else {
        body = AppRequestWA.bodyInfoUtama(
          nomorWA: event.listData[i].hp,
          title: event.listData[i].undangan,
          job: event.listData[i].posisi,
          date: event.listData[i].hari,
          time: event.listData[i].jam,
          group: event.listData[i].group,
          linkGroup: event.listData[i].linkGroup,
          from: "Sike Avika",
          fromDivisi: "Marketing Development",
          fromEmail: event.listData[i].pengirim,
        );
      }
      final response = await _usecase.sendMessage(_tcToken.text, body);
      response.fold((fail) => ExceptionHandle.execute(fail), (data) {
        if (data) {}
      });
      if (i == event.listData.length - 1) {
        AppDialog.dialogNoAction(
          context: globalKey.currentContext!,
          title: "Pesan berhasil dikirim",
        );
      }
    }
  }
}
