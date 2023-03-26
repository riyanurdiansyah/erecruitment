part of 'disc_bloc.dart';

abstract class DiscEvent extends Equatable {
  const DiscEvent();

  @override
  List<Object> get props => [];
}

class DiscInitialEvent extends DiscEvent {}

class DiscOnChangeTypeEvent extends DiscEvent {
  const DiscOnChangeTypeEvent(this.type);

  final String type;
}

class DiscInsertDataToListTempEvent extends DiscEvent {
  const DiscInsertDataToListTempEvent(this.option);

  final String option;
}

class DiscCreateSoalEvent extends DiscEvent {
  const DiscCreateSoalEvent({
    required this.listSoal,
    required this.status,
  });

  final List<String> listSoal;
  final bool status;
}

class DiscUpdateSoalEvent extends DiscEvent {
  const DiscUpdateSoalEvent({
    required this.disc,
  });

  final DiscEntity disc;
}

class DiscDeleteSoalEvent extends DiscEvent {
  const DiscDeleteSoalEvent({
    required this.id,
  });

  final String id;
}

class DiscTakeQuiz extends DiscEvent {}

class DiscPreviewEvent extends DiscEvent {}

class DiscOnChangeIndexPreviewEvent extends DiscEvent {
  const DiscOnChangeIndexPreviewEvent(this.index);

  final int index;
}

class DiscOnChangeRadio extends DiscEvent {
  const DiscOnChangeRadio(this.index, this.type);

  final int index;
  final String type;
}
