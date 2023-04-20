part of 'disc_bloc.dart';

class DiscState extends Equatable {
  const DiscState({
    this.type = "Instruksi",
    this.showPreview = false,
    this.isRecording = false,
    this.indexPreview = 0,
    this.answerSesuai = "",
    this.answerTidakSesuai = "",
    this.isUpdateInstruksi = false,
    this.page = 1,
    this.listData = const [],
  });

  final String type;
  final bool showPreview;
  final bool isRecording;
  final int indexPreview;
  final String answerSesuai;
  final String answerTidakSesuai;
  final bool isUpdateInstruksi;
  final int page;
  final List<DiscEntity> listData;

  DiscState copyWith({
    String? type,
    bool? showPreview,
    bool? isRecording,
    final List<String>? listOptionTemp,
    int? indexPreview,
    String? answerSesuai,
    String? answerTidakSesuai,
    bool? isUpdateInstruksi,
    int? page,
    List<DiscEntity>? listData,
  }) {
    return DiscState(
      type: type ?? this.type,
      showPreview: showPreview ?? this.showPreview,
      isRecording: isRecording ?? this.isRecording,
      indexPreview: indexPreview ?? this.indexPreview,
      answerSesuai: answerSesuai ?? this.answerSesuai,
      answerTidakSesuai: answerTidakSesuai ?? this.answerTidakSesuai,
      isUpdateInstruksi: isUpdateInstruksi ?? this.isUpdateInstruksi,
      page: page ?? this.page,
      listData: listData ?? this.listData,
    );
  }

  @override
  List<Object> get props => [
        type,
        showPreview,
        isRecording,
        indexPreview,
        answerSesuai,
        answerTidakSesuai,
        isUpdateInstruksi,
        page,
        listData,
      ];
}

class DiscInitial extends DiscState {}

class CameraInitial extends DiscState {}

class CameraReadyState extends DiscState {}

class CameraFailureState extends DiscState {}
