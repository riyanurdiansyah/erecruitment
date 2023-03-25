part of 'disc_bloc.dart';

class DiscState extends Equatable {
  const DiscState({
    this.type = "Instruksi",
    this.showPreview = false,
  });

  final String type;
  final bool showPreview;

  DiscState copyWith({
    String? type,
    bool? showPreview,
  }) {
    return DiscState(
      type: type ?? this.type,
      showPreview: showPreview ?? this.showPreview,
    );
  }

  @override
  List<Object> get props => [type, showPreview];
}

class DiscInitial extends DiscState {}
