import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../utils/app_color.dart';
import '../../../../../../utils/app_text.dart';
import '../../../../utils/app_constanta_list.dart';
import '../../blocs/blast/blast_bloc.dart';
import 'widgets/web_multiple_blast_widget.dart';
import 'widgets/web_preview_blast_widget.dart';
import 'widgets/web_single_blast_widget.dart';

class WebBlastPage extends StatefulWidget {
  const WebBlastPage({super.key});

  @override
  State<WebBlastPage> createState() => _WebBlastPageState();
}

class _WebBlastPageState extends State<WebBlastPage> {
  final _blastBloc = BlastBloc();

  @override
  void initState() {
    _blastBloc.add(BlastInitializeEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocProvider<BlastBloc>(
      create: (_) => _blastBloc,
      child: Scaffold(
        key: _blastBloc.globalKey,
        body: Row(
          children: [
            Expanded(
              flex: 3,
              child: BlocBuilder<BlastBloc, BlastState>(
                builder: (context, state) {
                  return SingleChildScrollView(
                    padding:
                        const EdgeInsets.only(right: 25, left: 16, top: 20),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        SizedBox(
                          width: double.infinity,
                          height: kToolbarHeight,
                          child: Text(
                            "Blast",
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Row(
                          children: List.generate(
                            listBlast.length,
                            (index) => Container(
                              margin: const EdgeInsets.only(right: 6),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 12),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: listBlast[index] == state.type
                                    ? colorPrimaryDark
                                    : Colors.grey.shade200,
                              ),
                              child: InkWell(
                                onTap: () => _blastBloc.add(
                                    BlastOnChangeTypeEvent(listBlast[index])),
                                child: AppText.labelW500(
                                  listBlast[index],
                                  14,
                                  listBlast[index] == state.type
                                      ? Colors.white
                                      : Colors.grey.shade600,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        if (state.type == "Single")
                          WebSingleBlastWidget(blastBloc: _blastBloc),
                        if (state.type == "Multiple")
                          WebMultipleBlastWidget(blastBloc: _blastBloc),
                      ],
                    ),
                  );
                },
              ),
            ),
            const Expanded(
              flex: 1,
              child: WebPreviewBlastWidget(),
            ),
          ],
        ),
      ),
    );
  }
}
