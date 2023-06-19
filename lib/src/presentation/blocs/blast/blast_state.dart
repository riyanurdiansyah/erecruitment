part of 'blast_bloc.dart';

class BlastState extends Equatable {
  const BlastState({
    this.template = "",
    this.type = "Single",
    this.imageFile,
    this.csvFile,
    this.listData,
    this.undangan = "{{1}}",
    this.hp = "",
    this.posisi = "{{2}}",
    this.hari = "{{3}}",
    this.custom = "",
    this.jam = "{{4}}",
    this.group = "{{5}}",
    this.linkGroup = "{{6}}",
    this.emailPengirim = "{{7}}",
    this.showPreview = false,
    this.isLoading = true,
  });

  final String template;
  final String undangan;
  final String posisi;
  final String hari;
  final String jam;
  final String group;
  final String linkGroup;
  final String emailPengirim;
  final String hp;
  final String custom;
  final String type;
  final Uint8List? imageFile;
  final Uint8List? csvFile;
  final List<BlastEntity>? listData;
  final bool showPreview;
  final bool isLoading;

  BlastState copyWith({
    String? template,
    String? type,
    Uint8List? imageFile,
    Uint8List? csvFile,
    List<BlastEntity>? listData,
    String? undangan,
    String? posisi,
    String? hari,
    String? jam,
    String? group,
    String? linkGroup,
    String? emailPengirim,
    String? hp,
    String? custom,
    bool? showPreview,
    bool? isLoading,
  }) {
    return BlastState(
      template: template ?? this.template,
      imageFile: imageFile ?? this.imageFile,
      type: type ?? this.type,
      csvFile: csvFile ?? this.csvFile,
      listData: listData ?? this.listData,
      undangan: undangan ?? this.undangan,
      posisi: posisi ?? this.posisi,
      jam: jam ?? this.jam,
      group: group ?? this.group,
      linkGroup: linkGroup ?? this.linkGroup,
      emailPengirim: emailPengirim ?? this.emailPengirim,
      hp: hp ?? this.hp,
      custom: custom ?? this.custom,
      hari: hari ?? this.hari,
      showPreview: showPreview ?? this.showPreview,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object> get props => [
        template,
        type,
        imageFile ?? Uint8List(0),
        listData ?? [],
        undangan,
        posisi,
        jam,
        group,
        linkGroup,
        emailPengirim,
        hp,
        custom,
        hari,
        isLoading,
      ];
}

class BlastInitial extends BlastState {}

class BlastLoadingState extends BlastState {}

class BlastSuccessState extends BlastState {}

class BlastFailureState extends BlastState {
  const BlastFailureState(this.errorMsg);

  final String errorMsg;
}
