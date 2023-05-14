part of 'blast_bloc.dart';

class BlastEvent extends Equatable {
  const BlastEvent();

  @override
  List<Object> get props => [];
}

class BlastInitializeEvent extends BlastEvent {}

class BlastOnChangeTemplateEvent extends BlastEvent {
  const BlastOnChangeTemplateEvent(this.template);

  final TemplateEntity template;
}

class BlastSendMessageEvent extends BlastEvent {}

class BlastSendMultipleMessageEvent extends BlastEvent {
  const BlastSendMultipleMessageEvent({required this.listData});

  final List<BlastEntity> listData;
}

class BlastUploadImageEvent extends BlastEvent {}

class BlastOnChangeTypeEvent extends BlastEvent {
  const BlastOnChangeTypeEvent(this.type);

  final String type;
}

class BlastUploadCsvEvent extends BlastEvent {}

class BlastOnChangeTextFieldEvent extends BlastEvent {
  const BlastOnChangeTextFieldEvent(this.type, this.text);

  final String type;
  final String text;
}
