import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../utils/app_text.dart';
import '../../../../../utils/app_translate_animation.dart';
import '../../../blocs/blast/blast_bloc.dart';

class WebPreviewBlastWidget extends StatelessWidget {
  const WebPreviewBlastWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocBuilder<BlastBloc, BlastState>(
      builder: (context, state) {
        if (state.template == "informasi") {
          return TranslateRightToLeftAnimation(
            child: AnimatedContainer(
              duration: const Duration(seconds: 1),
              alignment: Alignment.topRight,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                color: Colors.grey.shade100,
                alignment: Alignment.topCenter,
                height: size.height,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppText.labelBold(
                          "Preview",
                          16,
                          Colors.black,
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.close_rounded,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 10,
                      ),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (state.imageFile != null)
                            SizedBox(
                              width: double.infinity,
                              child: Image.memory(
                                state.imageFile!,
                                errorBuilder: (_, __, ___) => const SizedBox(),
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Column(
                              children: [
                                RichText(
                                  text: TextSpan(
                                    style: GoogleFonts.poppins(
                                      fontSize: 12.5,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    children: [
                                      TextSpan(
                                        text:
                                            'Halo! Kami ingin menginformasikan jadwal ${state.undangan} ',
                                      ),
                                      TextSpan(
                                        text:
                                            'TMS Group posisi ${state.posisi} ',
                                      ),
                                      TextSpan(
                                        text:
                                            'yang akan dilakukan hari ${state.hari} ',
                                      ),
                                      TextSpan(
                                        text: 'pukul ${state.jam} WIB, ',
                                      ),
                                      TextSpan(
                                        text:
                                            'silahkan gabung ke group ${state.group} ',
                                      ),
                                      const TextSpan(
                                        text:
                                            'TMS pada link di bawah ini untuk informasi lebih lanjut! \n\n',
                                      ),
                                      TextSpan(
                                        text: '${state.linkGroup} \n',
                                        style: GoogleFonts.poppins(
                                          color: Colors.blue,
                                        ),
                                      ),
                                      const TextSpan(
                                        text: 'Semoga sukses selalu! \n',
                                      ),
                                      const TextSpan(
                                        text:
                                            'Terima kasih atas perhatiannya. \n\n',
                                      ),
                                      const TextSpan(
                                        text: 'Best Regrads, \n',
                                      ),
                                      const TextSpan(
                                        text: 'Recruitment Team \n',
                                      ),
                                      const TextSpan(
                                        text: 'Marketing Support Department \n',
                                      ),
                                      TextSpan(
                                        text: "${state.emailPengirim} \n",
                                        style: GoogleFonts.poppins(
                                          color: Colors.blue,
                                        ),
                                      ),
                                      const TextSpan(
                                        text: 'TMS Group \n',
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}
