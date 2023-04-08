import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../utils/app_color.dart';
import '../../../../../utils/app_text.dart';
import '../../../blocs/papi/papi_bloc.dart';

class PapiInstruksiWidget extends StatelessWidget {
  const PapiInstruksiWidget({
    super.key,
    required PapiBloc papiBloc,
  }) : _papiBloc = papiBloc;

  final PapiBloc _papiBloc;

  @override
  Widget build(BuildContext context) {
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
                  BlocBuilder<PapiBloc, PapiState>(
                    builder: (context, state) {
                      return TextFormField(
                        controller: _papiBloc.tcMaxSoal,
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
                  BlocBuilder<PapiBloc, PapiState>(
                    builder: (context, state) {
                      return TextFormField(
                        readOnly: !state.isUpdateInstruksi,
                        controller: _papiBloc.tcWaktu,
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
        BlocBuilder<PapiBloc, PapiState>(
          builder: (context, state) {
            return TextFormField(
              maxLines: 18,
              minLines: 1,
              readOnly: !state.isUpdateInstruksi,
              controller: _papiBloc.tcInstruksi,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                fillColor: Colors.white,
                filled: state.isUpdateInstruksi,
                hintStyle: GoogleFonts.poppins(),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                hintText: "...",
                border: const OutlineInputBorder(),
              ),
            );
          },
        ),
        const SizedBox(
          height: 25,
        ),
        BlocBuilder<PapiBloc, PapiState>(
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
                          : () => _papiBloc.add(PapiUpdateUjianDetailEvent()),
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
                          : () => _papiBloc.add(PapiUpdateUjianDetailEvent()),
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
  }
}
