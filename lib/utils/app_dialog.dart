import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recruitment/src/domain/entities/disc_entity.dart';
import 'package:recruitment/utils/app_color.dart';

import '../src/presentation/blocs/disc/disc_bloc.dart';
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
