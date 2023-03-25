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
    required this.options,
  });

  final List<String> options;
}
