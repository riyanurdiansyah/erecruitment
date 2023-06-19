import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recruitment/utils/app_validator.dart';

import '../../../../../utils/app_text.dart';
import '../../../blocs/blast/blast_bloc.dart';

class WebCustomBlastWidget extends StatelessWidget {
  const WebCustomBlastWidget({
    Key? key,
    required BlastBloc blastBloc,
  })  : _blastBloc = blastBloc,
        super(key: key);

  final BlastBloc _blastBloc;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 10,
        ),
        AppText.labelW600(
          "Undangan",
          16,
          Colors.black,
        ),
        const SizedBox(
          height: 12,
        ),
        TextFormField(
          maxLines: 15,
          minLines: 3,
          // controller: trainBloc.tcDetail,
          keyboardType: TextInputType.multiline,
          validator: (val) => AppValidator.requiredField(val!),
          style: GoogleFonts.poppins(
            height: 1.4,
          ),
          onChanged: (val) =>
              _blastBloc.add(BlastOnChangeTextFieldEvent("custom", val)),
          decoration: InputDecoration(
            hintStyle: GoogleFonts.poppins(),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
            hintText: "Isikan detail pesan",
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        const SizedBox(
          height: 45,
        ),
      ],
    );
  }
}
