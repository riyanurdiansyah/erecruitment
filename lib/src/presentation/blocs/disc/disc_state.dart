part of 'disc_bloc.dart';

class DiscState extends Equatable {
  const DiscState({
    this.type = "Instruksi",
    this.showPreview = false,
    this.isRecording = false,
  });

  final String type;
  final bool showPreview;
  final bool isRecording;

  DiscState copyWith({
    String? type,
    bool? showPreview,
    bool? isRecording,
    final List<String>? listOptionTemp,
  }) {
    return DiscState(
      type: type ?? this.type,
      showPreview: showPreview ?? this.showPreview,
      isRecording: isRecording ?? this.isRecording,
    );
  }

  @override
  List<Object> get props => [type, showPreview, isRecording];
}

class DiscInitial extends DiscState {}

class CameraInitial extends DiscState {}

class CameraReadyState extends DiscState {}

class CameraFailureState extends DiscState {}
