import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
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
  }) {
    List<String> listTemp = [];
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
                            discBloc
                                .add(DiscCreateSoalEvent(options: listTemp));
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
