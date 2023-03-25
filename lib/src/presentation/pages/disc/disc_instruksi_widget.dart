import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../utils/app_text.dart';

class DiscInstruksiWidget extends StatelessWidget {
  const DiscInstruksiWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText.labelW600(
          "Judul",
          16,
          Colors.black,
        ),
        const SizedBox(
          height: 12,
        ),
        TextFormField(
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintStyle: GoogleFonts.poppins(),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
            hintText: "...",
            border: const OutlineInputBorder(),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        AppText.labelW600(
          "Subjudul",
          16,
          Colors.black,
        ),
        const SizedBox(
          height: 12,
        ),
        TextFormField(
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintStyle: GoogleFonts.poppins(),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
            hintText: "...",
            border: const OutlineInputBorder(),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        AppText.labelW600(
          "Footer",
          16,
          Colors.black,
        ),
        const SizedBox(
          height: 12,
        ),
        TextFormField(
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintStyle: GoogleFonts.poppins(),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
            hintText: "...",
            border: const OutlineInputBorder(),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
