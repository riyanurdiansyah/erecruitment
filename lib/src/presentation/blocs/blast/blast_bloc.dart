import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:csv/csv.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gsheets/gsheets.dart';

import '../../../../services/app_sheet_services.dart';
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

  final TextEditingController _tcSheet = TextEditingController();
  TextEditingController get tcSheet => _tcSheet;

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
    on<BlastUploadSheetEvent>(_onUploadSheet);
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
        undangan: state.undangan,
        job: state.posisi,
        date: state.hari,
        time: state.jam,
        group: state.group,
        linkGroup: state.linkGroup,
        from: state.tim,
        tempat: state.di,
        keterangan: state.keterangan,
        fromDivisi: state.divisi,
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
    if (event.type == "keterangan") {
      emit(state.copyWith(keterangan: event.text));
    }
    if (event.type == "pengirim") {
      emit(state.copyWith(emailPengirim: event.text));
    }
    if (event.type == "tempat") {
      emit(state.copyWith(di: event.text));
    }
    if (event.type == "tim") {
      emit(state.copyWith(tim: event.text));
    }
    if (event.type == "divisi") {
      emit(state.copyWith(divisi: event.text));
    }
  }

  void _onSendMultipleMessage(BlastSendMultipleMessageEvent event, emit) async {
    for (int i = 0; i < state.datasheets.length; i++) {
      Map<String, dynamic> body = {};

      if (state.template.contains("custom")) {
        body = {
          "messaging_product": "whatsapp",
          "recipient_type": "individual",
          "to": state.datasheets[i]["HP"],
          "type": "text",
          "text": {
            "body": state.custom,
          }
        };
      } else {
        body = AppRequestWA.bodyInfoUtama(
          undangan: state.datasheets[i]["UNDANGAN"],
          tempat: state.datasheets[i]["TEMPAT"],
          job: state.datasheets[i]["POSISI"],
          date: state.datasheets[i]["HARI"],
          time: state.datasheets[i]["JAM"],
          group: state.datasheets[i]["GROUP"],
          keterangan: state.datasheets[i]["KETERANGAN"],
          linkGroup: state.datasheets[i]["LINK"],
          from: state.datasheets[i]["PENGIRIM"],
          fromDivisi: state.datasheets[i]["DEPARTEMENT"],
          fromEmail: state.datasheets[i]["EMAIL"],
          nomorWA: state.datasheets[i]["HP"],
        );
      }
      final response = await _usecase.sendMessage(_tcToken.text, body);
      response.fold((fail) => ExceptionHandle.execute(fail), (data) {
        if (data) {}
      });
      if (i == state.datasheets.length - 1) {
        AppDialog.dialogNoAction(
          context: globalKey.currentContext!,
          title: "Pesan berhasil dikirim",
        );
      }
    }
  }

  static Future<Worksheet> _getWorkSheet(
      Spreadsheet spreadsheet, String sheetId) async {
    try {
      return await spreadsheet.addWorksheet(sheetId);
    } catch (e) {
      return spreadsheet.worksheetById(int.parse(sheetId))!;
    }
  }

  FutureOr<void> _onUploadSheet(
      BlastUploadSheetEvent event, Emitter<BlastState> emit) async {
    final gsheet = GSheets(credentialSheet);

    if (!tcSheet.text.contains("https://docs.google.com/spreadsheets/d/")) {
      AppDialog.dialogNoAction(
          context: globalKey.currentContext!,
          title: "Masukkan link sheet yang sesuai yahh");
    } else {
      final spreadSheetId = tcSheet.text
          .split("/edit#gid=")[0]
          .replaceAll("https://docs.google.com/spreadsheets/d/", "");
      final sheetId = tcSheet.text.split("edit#gid=")[1];

      final spredsheet = await gsheet.spreadsheet(spreadSheetId.trim());
      // final worksheet = await _getWorkSheet(spredsheet, sheetId.trim());
      final worksheet = spredsheet.worksheetById(int.parse(sheetId))!;

      final rows = await worksheet.values.map.allRows() ?? [];
      // List<Map<String, dynamic>> headers = rows[0];
      Set<String> keys = <String>{};
      Set<dynamic> values = <dynamic>{};
      for (var data in rows) {
        keys.addAll(data.keys);
        values.addAll(data.values);
      }
      List<String> keyList = keys.toList();
      List<dynamic> valueList = values.toList();
      print("CEK ROW TITLE : $keyList");
      print("CEK ROW VALUE : $valueList");

      emit(state.copyWith(datasheets: rows));
    }
  }
}
