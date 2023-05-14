import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:recruitment/src/domain/entities/disc_entity.dart';
import 'package:recruitment/utils/app_color.dart';
import 'package:recruitment/utils/app_format_text.dart';
import 'package:recruitment/utils/app_validator.dart';

import '../src/domain/entities/user_entity.dart';
import '../src/presentation/blocs/disc/disc_bloc.dart';
import '../src/presentation/blocs/user/user_bloc.dart';
import 'app_text.dart';

class AppDialog {
  static dialogNoAction({
    required BuildContext context,
    required String title,
    String? text,
  }) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Center(
            child: AppText.labelW600(
              title,
              16,
              Colors.black,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextButton(
                onPressed: () => context.pop(),
                child: const Text(
                  'Kembali',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: Colors.blue,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  static dialogTambahUser({
    required BuildContext context,
    required UserBloc userBloc,
    UserEntity? user,
  }) {
    final size = MediaQuery.of(context).size;
    TextEditingController tcNama = TextEditingController();
    TextEditingController tcNoHp = TextEditingController();
    TextEditingController tcEmail = TextEditingController();
    TextEditingController tcUsername = TextEditingController();
    TextEditingController tcKodeAkses = TextEditingController();
    TextEditingController tcPosisi = TextEditingController();
    TextEditingController tcMulai = TextEditingController();
    TextEditingController tcSelesai = TextEditingController();
    final formkey = GlobalKey<FormState>();
    String? tglMulai;
    String? tglSelesai;
    if (user != null) {
      tcEmail.text = user.email;
      tcUsername.text = user.username;
      tcKodeAkses.text = user.kodeAkses;
      tcPosisi.text = user.posisi;
      tcMulai.text =
          "${DateFormat.yMMMd('id').add_jm().format(DateTime.parse(user.tanggalMulai))} WIB";
      tcSelesai.text =
          "${DateFormat.yMMMd('id').add_jm().format(DateTime.parse(user.tanggalSelesai))} WIB";
      tcNama.text = user.nama;
      tcNoHp.text = user.noHp.toString();
    }
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: SizedBox(
            width: size.width / 4,
            child: Form(
              key: formkey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppText.labelW600(
                          "Tambah User",
                          16,
                          Colors.black,
                        ),
                        InkWell(
                          onTap: () => context.pop(),
                          child: const Icon(
                            Icons.close_rounded,
                            size: 18,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 11,
                    ),
                    AppText.labelW500(
                      "Email",
                      12,
                      Colors.black,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      controller: tcEmail,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintStyle: GoogleFonts.poppins(),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 12),
                        hintText: "....",
                        border: const OutlineInputBorder(),
                      ),
                      validator: (val) => AppValidator.checkEmail(val!),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                    const SizedBox(
                      height: 11,
                    ),
                    AppText.labelW500(
                      "Nama",
                      12,
                      Colors.black,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      controller: tcNama,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        hintStyle: GoogleFonts.poppins(),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 12),
                        hintText: "....",
                        border: const OutlineInputBorder(),
                      ),
                      validator: (val) => AppValidator.requiredField(val!),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                    const SizedBox(
                      height: 11,
                    ),
                    AppText.labelW500(
                      "Username",
                      12,
                      Colors.black,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      readOnly: user == null ? false : true,
                      controller: tcUsername,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        hintStyle: GoogleFonts.poppins(),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 12),
                        hintText: "....",
                        border: const OutlineInputBorder(),
                      ),
                      validator: (val) => AppValidator.requiredField(val!),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                    const SizedBox(
                      height: 11,
                    ),
                    AppText.labelW500(
                      "No Handphone",
                      12,
                      Colors.black,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      controller: tcNoHp,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        AppPhoneText(),
                      ],
                      decoration: InputDecoration(
                        hintStyle: GoogleFonts.poppins(),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 12),
                        hintText: "....",
                        border: const OutlineInputBorder(),
                      ),
                      validator: (val) => AppValidator.checkNumberPhone(val!),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                    const SizedBox(
                      height: 11,
                    ),
                    AppText.labelW500(
                      "Kode Akses",
                      12,
                      Colors.black,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      readOnly: true,
                      controller: tcKodeAkses,
                      keyboardType: TextInputType.text,
                      validator: (val) => AppValidator.requiredField(val!),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                        hintStyle: GoogleFonts.poppins(),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 12),
                        hintText: "....",
                        border: const OutlineInputBorder(),
                        suffixIcon: user != null
                            ? null
                            : InkWell(
                                onTap: () {
                                  const chars =
                                      'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
                                  final random = Random.secure();

                                  // Usage example:
                                  final randomString = String.fromCharCodes(
                                      Iterable.generate(
                                          8,
                                          (_) => chars.codeUnitAt(
                                              random.nextInt(chars.length))));
                                  tcKodeAkses.text = randomString;
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(right: 6),
                                  padding: const EdgeInsets.all(6),
                                  color: Colors.grey.shade300,
                                  child: const Text("Generate"),
                                ),
                              ),
                      ),
                    ),
                    const SizedBox(
                      height: 11,
                    ),
                    AppText.labelW500(
                      "Posisi",
                      12,
                      Colors.black,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      controller: tcPosisi,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        hintStyle: GoogleFonts.poppins(),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 12),
                        hintText: "....",
                        border: const OutlineInputBorder(),
                      ),
                      validator: (val) => AppValidator.requiredField(val!),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                    const SizedBox(
                      height: 11,
                    ),
                    AppText.labelW500(
                      "Tanggal Mulai",
                      12,
                      Colors.black,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      readOnly: true,
                      controller: tcMulai,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        hintStyle: GoogleFonts.poppins(),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 12),
                        hintText: "....",
                        border: const OutlineInputBorder(),
                        suffixIcon: InkWell(
                          onTap: () async {
                            final date = await userBloc.getDate();
                            if (date != null) {
                              final time = await userBloc.getTime();
                              if (time != null) {
                                tglMulai = date
                                    .add(Duration(
                                        hours: time.hour, minutes: time.minute))
                                    .toIso8601String();
                                tcMulai.text =
                                    "${DateFormat.yMMMd('id').add_jm().format(DateTime.parse(date.add(Duration(hours: time.hour, minutes: time.minute)).toIso8601String()))} WIB";
                              }
                            }
                          },
                          child: Container(
                            margin: const EdgeInsets.only(right: 6),
                            padding: const EdgeInsets.all(6),
                            color: Colors.grey.shade300,
                            child: const Icon(
                              Icons.calendar_month,
                            ),
                          ),
                        ),
                      ),
                      validator: (val) => AppValidator.requiredField(val!),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                    const SizedBox(
                      height: 11,
                    ),
                    AppText.labelW500(
                      "Tanggal Selesai",
                      12,
                      Colors.black,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      readOnly: true,
                      controller: tcSelesai,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        hintStyle: GoogleFonts.poppins(),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 12),
                        hintText: "....",
                        border: const OutlineInputBorder(),
                        suffixIcon: InkWell(
                          onTap: () async {
                            final date = await userBloc.getDate();
                            if (date != null) {
                              tglSelesai = date.toIso8601String();
                              final time = await userBloc.getTime();
                              if (time != null) {
                                if (tglMulai != null) {
                                  if (DateTime.parse(tglMulai!).isAfter(
                                      DateTime.parse(tglSelesai!).add(Duration(
                                          hours: time.hour,
                                          minutes: time.minute)))) {
                                    AppDialog.dialogNoAction(
                                        context: context,
                                        title:
                                            "Tanggal selesai tidak boleh sebelum tanggal mulai");
                                  } else {
                                    tcSelesai.text =
                                        "${DateFormat.yMMMd('id').add_jm().format(DateTime.parse(date.add(Duration(hours: time.hour, minutes: time.minute)).toIso8601String()))} WIB";
                                  }
                                } else {
                                  AppDialog.dialogNoAction(
                                      context: context,
                                      title: "Harap isi tanggal mulai dahulu");
                                }
                              }
                            }
                          },
                          child: Container(
                            margin: const EdgeInsets.only(right: 6),
                            padding: const EdgeInsets.all(6),
                            color: Colors.grey.shade300,
                            child: const Icon(
                              Icons.calendar_month,
                            ),
                          ),
                        ),
                      ),
                      validator: (val) => AppValidator.requiredField(val!),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 45,
                      child: ElevatedButton(
                        onPressed: () {
                          if (formkey.currentState!.validate()) {
                            context.pop();
                            if (user == null) {
                              userBloc.add(
                                UserAddNewEvent(
                                  UserEntity(
                                    nama: tcNama.text,
                                    username: tcUsername.text,
                                    email: tcEmail.text,
                                    posisi: tcPosisi.text,
                                    noHp: tcNoHp.text[0] == "0"
                                        ? int.parse(
                                            tcNoHp.text.replaceFirst("0", "62"))
                                        : int.parse(tcNoHp.text),
                                    tanggalMulai:
                                        DateTime.now().toIso8601String(),
                                    tanggalSelesai:
                                        DateTime.now().toIso8601String(),
                                    ujians: const [],
                                    role: 2,
                                    kodeAkses: tcKodeAkses.text,
                                  ),
                                ),
                              );
                            } else {
                              userBloc.add(
                                UserUpdateEvent(
                                  UserEntity(
                                    nama: tcNama.text,
                                    username: tcUsername.text,
                                    email: tcEmail.text,
                                    posisi: tcPosisi.text,
                                    noHp: tcNoHp.text[0] == "0"
                                        ? int.parse(
                                            tcNoHp.text.replaceFirst("0", "62"))
                                        : int.parse(tcNoHp.text),
                                    tanggalMulai:
                                        DateTime.now().toIso8601String(),
                                    tanggalSelesai:
                                        DateTime.now().toIso8601String(),
                                    ujians: const [],
                                    role: 2,
                                    kodeAkses: tcKodeAkses.text,
                                  ),
                                ),
                              );
                            }
                          }
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(colorPrimaryDark),
                        ),
                        child: AppText.labelBold(
                          user != null ? "Ubah" : "Tambah",
                          12.5,
                          Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  static dialogTambahSoalDISC({
    required BuildContext context,
    required DiscBloc discBloc,
    DiscEntity? data,
  }) {
    List<String> listTemp = [];
    bool status = true;
    if (data != null) {
      listTemp = data.soal;
      status = data.status;
    }
    final size = MediaQuery.of(context).size;
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: StatefulBuilder(
            builder: (context, setState) {
              return SizedBox(
                width: size.width / 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppText.labelW600(
                          "Tambah Soal",
                          16,
                          Colors.black,
                        ),
                        InkWell(
                          onTap: () => context.pop(),
                          child: const Icon(
                            Icons.close_rounded,
                            size: 18,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 11,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: discBloc.tcOption,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintStyle: GoogleFonts.poppins(),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 12),
                              hintText: "Masukkan option...",
                              border: const OutlineInputBorder(),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        InkWell(
                          onTap: () {
                            listTemp.add(discBloc.tcOption.text);
                            discBloc.tcOption.clear();
                            setState(() {});
                          },
                          child: const Icon(
                            Icons.add_rounded,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    AppText.labelW600(
                      "Status",
                      16,
                      Colors.black,
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              status = false;
                              setState(() {});
                            },
                            child: AnimatedContainer(
                              alignment: Alignment.center,
                              duration: const Duration(milliseconds: 500),
                              height: 40,
                              decoration: BoxDecoration(
                                color: status == true
                                    ? Colors.grey.shade300
                                    : Colors.red,
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(8),
                                  bottomLeft: Radius.circular(8),
                                ),
                              ),
                              child: AppText.labelW600(
                                "Tidak Aktif",
                                14,
                                status == true
                                    ? Colors.grey.shade600
                                    : Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              status = true;
                              setState(() {});
                            },
                            child: AnimatedContainer(
                              alignment: Alignment.center,
                              duration: const Duration(milliseconds: 500),
                              height: 40,
                              decoration: BoxDecoration(
                                color: status == true
                                    ? Colors.green
                                    : Colors.grey.shade300,
                                borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(8),
                                  bottomRight: Radius.circular(8),
                                ),
                              ),
                              child: AppText.labelW600(
                                "Aktif",
                                14,
                                status == true
                                    ? Colors.white
                                    : Colors.grey.shade600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    if (listTemp.isNotEmpty)
                      Wrap(
                        crossAxisAlignment: WrapCrossAlignment.start,
                        direction: Axis.horizontal,
                        children: List.generate(
                          listTemp.length,
                          (index) => Container(
                            margin: const EdgeInsets.only(right: 5, bottom: 5),
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.grey.shade300,
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                AppText.labelW500(
                                  listTemp[index],
                                  12,
                                  Colors.black,
                                ),
                                const SizedBox(
                                  width: 12,
                                ),
                                InkWell(
                                  onTap: () {
                                    listTemp.removeWhere(
                                        (e) => e == listTemp[index]);
                                    setState(() {});
                                  },
                                  child: const Icon(
                                    Icons.close_rounded,
                                    size: 18,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    const SizedBox(
                      height: 23,
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 40,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(colorPrimaryDark),
                        ),
                        onPressed: () {
                          if (listTemp.isEmpty) {
                            AppDialog.dialogNoAction(
                                context: context,
                                title: "Silahkan tambahkan option");
                          } else {
                            context.pop();
                            if (data != null) {
                              discBloc.add(
                                DiscUpdateSoalEvent(
                                  disc: DiscEntity(
                                    id: data.id,
                                    soal: listTemp,
                                    status: status,
                                    updateBy: DiscUpdateByEntity(
                                      user: data.updateBy.user,
                                      date: DateTime.now().toIso8601String(),
                                    ),
                                    responses: const [],
                                  ),
                                ),
                              );
                            } else {
                              discBloc.add(DiscCreateSoalEvent(
                                  listSoal: listTemp, status: status));
                            }
                          }
                        },
                        child: AppText.labelW600(
                          "Simpan",
                          14,
                          Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
