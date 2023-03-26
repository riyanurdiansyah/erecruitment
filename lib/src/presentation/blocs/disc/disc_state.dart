part of 'disc_bloc.dart';

class DiscState extends Equatable {
  const DiscState({
    this.type = "Instruksi",
    this.showPreview = false,
    this.isRecording = false,
    this.indexPreview = 0,
    this.indexSesuai = 99,
    this.indexTidakSesuai = 99,
    this.isUpdateInstruksi = false,
  });

  final String type;
  final bool showPreview;
  final bool isRecording;
  final int indexPreview;
  final int indexSesuai;
  final int indexTidakSesuai;
  final bool isUpdateInstruksi;

  DiscState copyWith({
    String? type,
    bool? showPreview,
    bool? isRecording,
    final List<String>? listOptionTemp,
    int? indexPreview,
    int? indexSesuai,
    int? indexTidakSesuai,
    bool? isUpdateInstruksi,
  }) {
    return DiscState(
      type: type ?? this.type,
      showPreview: showPreview ?? this.showPreview,
      isRecording: isRecording ?? this.isRecording,
      indexPreview: indexPreview ?? this.indexPreview,
      indexSesuai: indexSesuai ?? this.indexSesuai,
      indexTidakSesuai: indexTidakSesuai ?? this.indexTidakSesuai,
      isUpdateInstruksi: isUpdateInstruksi ?? this.isUpdateInstruksi,
    );
  }

  @override
  List<Object> get props => [
        type,
        showPreview,
        isRecording,
        indexPreview,
        indexSesuai,
        indexTidakSesuai,
        isUpdateInstruksi,
      ];
}

class DiscInitial extends DiscState {}

class CameraInitial extends DiscState {}

class CameraReadyState extends DiscState {}

class CameraFailureState extends DiscState {}
