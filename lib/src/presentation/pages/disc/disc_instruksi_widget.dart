import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recruitment/src/domain/entities/ujian_entity.dart';

import '../../../../utils/app_color.dart';
import '../../../../utils/app_text.dart';
import '../../blocs/disc/disc_bloc.dart';

class DiscInstruksiWidget extends StatelessWidget {
  const DiscInstruksiWidget({
    super.key,
    required DiscBloc discBloc,
  }) : _discBloc = discBloc;

  final DiscBloc _discBloc;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UjianEntity>(
      future: _discBloc.getUjianDetail(),
      builder: (context, snapshot) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText.labelW600(
                        "Maksimal Soal",
                        16,
                        Colors.black,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      BlocBuilder<DiscBloc, DiscState>(
                        builder: (context, state) {
                          return TextFormField(
                            controller: _discBloc.tcMaxSoal,
                            keyboardType: TextInputType.number,
                            readOnly: !state.isUpdateInstruksi,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: state.isUpdateInstruksi,
                              hintStyle: GoogleFonts.poppins(),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 12),
                              hintText: "...",
                              border: const OutlineInputBorder(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText.labelW600(
                        "Waktu",
                        16,
                        Colors.black,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      BlocBuilder<DiscBloc, DiscState>(
                        builder: (context, state) {
                          return TextFormField(
                            readOnly: !state.isUpdateInstruksi,
                            controller: _discBloc.tcWaktu,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: state.isUpdateInstruksi,
                              hintStyle: GoogleFonts.poppins(),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 12),
                              hintText: "...",
                              border: const OutlineInputBorder(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            AppText.labelW600(
              "Instruksi",
              16,
              Colors.black,
            ),
            const SizedBox(
              height: 12,
            ),
            BlocBuilder<DiscBloc, DiscState>(
              builder: (context, state) {
                return TextFormField(
                  maxLines: 18,
                  minLines: 1,
                  readOnly: !state.isUpdateInstruksi,
                  controller: _discBloc.tcInstruksi,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: state.isUpdateInstruksi,
                    hintStyle: GoogleFonts.poppins(),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 12),
                    hintText: "...",
                    border: const OutlineInputBorder(),
                  ),
                );
              },
            ),
            const SizedBox(
              height: 25,
            ),
            BlocBuilder<DiscBloc, DiscState>(
              builder: (context, state) {
                return Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 40,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                state.isUpdateInstruksi
                                    ? Colors.grey.shade400
                                    : colorPrimaryDark),
                          ),
                          onPressed: state.isUpdateInstruksi
                              ? null
                              : () => _discBloc.add(DiscUpdateUjianDetail()),
                          child: AppText.labelW600(
                            "Update",
                            14,
                            Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: SizedBox(
                        height: 40,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                !state.isUpdateInstruksi
                                    ? Colors.grey.shade400
                                    : colorPrimaryDark),
                          ),
                          onPressed: !state.isUpdateInstruksi
                              ? null
                              : () => _discBloc.add(DiscUpdateUjianDetail()),
                          child: AppText.labelW600(
                            "Simpan",
                            14,
                            Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        );
      },
    );
  }
}
