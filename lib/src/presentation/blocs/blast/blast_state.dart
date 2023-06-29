part of 'blast_bloc.dart';

class BlastState extends Equatable {
  const BlastState({
    this.template = "",
    this.type = "Single",
    this.imageFile,
    this.csvFile,
    this.listData,
    this.undangan = "{{1}}",
    this.di = "{{2}}",
    this.hp = "",
    this.posisi = "{{3}}",
    this.hari = "{{4}}",
    this.custom = "",
    this.jam = "{{5}}",
    this.group = "{{6}}",
    this.keterangan = "{{7}}",
    this.linkGroup = "{{8}}",
    this.from = "{{8}}",
    this.tim = "{{9}}",
    this.divisi = "{{10}}",
    this.emailPengirim = "{{11}}",
    this.showPreview = false,
    this.isLoading = true,
    this.datasheets = const [],
  });

  final String template;
  final String undangan;
  final String di;
  final String posisi;
  final String hari;
  final String jam;
  final String group;
  final String keterangan;
  final String linkGroup;
  final String from;
  final String tim;
  final String divisi;
  final String emailPengirim;
  final String hp;
  final String custom;
  final String type;
  final Uint8List? imageFile;
  final Uint8List? csvFile;
  final List<BlastEntity>? listData;
  final bool showPreview;
  final bool isLoading;
  final List<Map<String, dynamic>> datasheets;

  BlastState copyWith({
    String? template,
    String? type,
    Uint8List? imageFile,
    Uint8List? csvFile,
    List<BlastEntity>? listData,
    String? undangan,
    String? di,
    String? posisi,
    String? hari,
    String? jam,
    String? group,
    String? keterangan,
    String? linkGroup,
    String? tim,
    String? divisi,
    String? emailPengirim,
    String? hp,
    String? custom,
    bool? showPreview,
    bool? isLoading,
    List<Map<String, dynamic>>? datasheets,
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
      di: di ?? this.di,
      tim: tim ?? this.tim,
      divisi: divisi ?? this.divisi,
      keterangan: keterangan ?? this.keterangan,
      datasheets: datasheets ?? this.datasheets,
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
        di,
        tim,
        divisi,
        keterangan,
        datasheets,
      ];
}

class BlastInitial extends BlastState {}

class BlastLoadingState extends BlastState {}

class BlastSuccessState extends BlastState {}

class BlastFailureState extends BlastState {
  const BlastFailureState(this.errorMsg);

  final String errorMsg;
}
