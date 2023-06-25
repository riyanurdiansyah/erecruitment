import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../../utils/app_text.dart';
import '../../../../../../../utils/app_validator.dart';
import '../../../blocs/blast/blast_bloc.dart';

class WebInformasiBlastWidget extends StatelessWidget {
  const WebInformasiBlastWidget({
    Key? key,
    required BlastBloc blastBloc,
  })  : _blastBloc = blastBloc,
        super(key: key);

  final BlastBloc _blastBloc;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText.labelW600(
          "Undangan",
          16,
          Colors.black,
        ),
        const SizedBox(
          height: 12,
        ),
        TextFormField(
          keyboardType: TextInputType.number,
          validator: (val) => AppValidator.checkNama(val!),
          decoration: InputDecoration(
            hintStyle: GoogleFonts.poppins(),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
            hintText: "Psikotest",
            border: const OutlineInputBorder(),
          ),
          onChanged: (val) =>
              _blastBloc.add(BlastOnChangeTextFieldEvent("undangan", val)),
        ),
        const SizedBox(
          height: 20,
        ),
        AppText.labelW600(
          "Posisi",
          16,
          Colors.black,
        ),
        const SizedBox(
          height: 12,
        ),
        TextFormField(
          keyboardType: TextInputType.number,
          validator: (val) => AppValidator.checkNama(val!),
          decoration: InputDecoration(
            hintStyle: GoogleFonts.poppins(),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
            hintText: "Manager",
            border: const OutlineInputBorder(),
          ),
          onChanged: (val) =>
              _blastBloc.add(BlastOnChangeTextFieldEvent("posisi", val)),
        ),
        const SizedBox(
          height: 20,
        ),
        AppText.labelW600(
          "Hari",
          16,
          Colors.black,
        ),
        const SizedBox(
          height: 12,
        ),
        TextFormField(
          keyboardType: TextInputType.number,
          validator: (val) => AppValidator.checkNama(val!),
          decoration: InputDecoration(
            hintStyle: GoogleFonts.poppins(),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
            hintText: "Senin, 14 Maret 2023",
            border: const OutlineInputBorder(),
          ),
          onChanged: (val) =>
              _blastBloc.add(BlastOnChangeTextFieldEvent("hari", val)),
        ),
        const SizedBox(
          height: 20,
        ),
        AppText.labelW600(
          "Jam",
          16,
          Colors.black,
        ),
        const SizedBox(
          height: 12,
        ),
        TextFormField(
          keyboardType: TextInputType.number,
          validator: (val) => AppValidator.checkNama(val!),
          decoration: InputDecoration(
            hintStyle: GoogleFonts.poppins(),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
            hintText: "08.00",
            border: const OutlineInputBorder(),
          ),
          onChanged: (val) =>
              _blastBloc.add(BlastOnChangeTextFieldEvent("jam", val)),
        ),
        const SizedBox(
          height: 20,
        ),
        AppText.labelW600(
          "Group",
          16,
          Colors.black,
        ),
        const SizedBox(
          height: 12,
        ),
        TextFormField(
          keyboardType: TextInputType.number,
          validator: (val) => AppValidator.checkNama(val!),
          decoration: InputDecoration(
            hintStyle: GoogleFonts.poppins(),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
            hintText: "Psikotest",
            border: const OutlineInputBorder(),
          ),
          onChanged: (val) =>
              _blastBloc.add(BlastOnChangeTextFieldEvent("group", val)),
        ),
        const SizedBox(
          height: 20,
        ),
        AppText.labelW600(
          "Link Group",
          16,
          Colors.black,
        ),
        const SizedBox(
          height: 12,
        ),
        TextFormField(
          keyboardType: TextInputType.number,
          validator: (val) => AppValidator.checkNama(val!),
          decoration: InputDecoration(
            hintStyle: GoogleFonts.poppins(),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
            hintText: "https://chat.whatsapp.com/....",
            border: const OutlineInputBorder(),
          ),
          onChanged: (val) =>
              _blastBloc.add(BlastOnChangeTextFieldEvent("linkgroup", val)),
        ),
        const SizedBox(
          height: 20,
        ),
        AppText.labelW600(
          "Email Pengirim",
          16,
          Colors.black,
        ),
        const SizedBox(
          height: 12,
        ),
        TextFormField(
          keyboardType: TextInputType.number,
          validator: (val) => AppValidator.checkNama(val!),
          decoration: InputDecoration(
            hintStyle: GoogleFonts.poppins(),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
            hintText: "johndoe@gmail.com",
            border: const OutlineInputBorder(),
          ),
          onChanged: (val) =>
              _blastBloc.add(BlastOnChangeTextFieldEvent("pengirim", val)),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
