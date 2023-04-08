import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../utils/app_color.dart';
import '../../../../utils/app_constanta_list.dart';
import '../../../../utils/app_text.dart';
import '../../blocs/papi/papi_bloc.dart';
import '../widgets/header.dart';
import 'widgets/papi_instruksi_widget.dart';

class PapiPage extends StatefulWidget {
  const PapiPage({super.key});

  @override
  State<PapiPage> createState() => _PapiPageState();
}

class _PapiPageState extends State<PapiPage> {
  final _papiBloc = PapiBloc();

  @override
  void initState() {
    _papiBloc.add(PapiInitializeEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PapiBloc>(
      create: (context) => _papiBloc,
      child: Scaffold(
        key: _papiBloc.globalKey,
        backgroundColor: backgroundGrey,
        body: Container(
          width: double.infinity,
          padding: const EdgeInsets.only(right: 35),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 25,
              ),
              const Header(),
              const SizedBox(
                height: 25,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 15,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 14),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AppText.labelBold(
                                    "Setting",
                                    16,
                                    Colors.black,
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  Container(
                                    width: 60,
                                    height: 2,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      color: colorPrimaryDark,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  BlocBuilder<PapiBloc, PapiState>(
                                    builder: (context, state) {
                                      return Row(
                                        children: List.generate(
                                          listMenus.length,
                                          (index) => Container(
                                            margin:
                                                const EdgeInsets.only(right: 6),
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 8, horizontal: 12),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                              color:
                                                  listMenus[index] == state.type
                                                      ? colorPrimaryDark
                                                      : Colors.white,
                                            ),
                                            child: InkWell(
                                              onTap: () => _papiBloc.add(
                                                  PapiOnChangeTypeEvent(
                                                      listMenus[index])),
                                              child: AppText.labelW500(
                                                listMenus[index],
                                                14,
                                                listMenus[index] == state.type
                                                    ? Colors.white
                                                    : Colors.grey.shade600,
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  const SizedBox(
                                    height: 25,
                                  ),
                                  BlocBuilder<PapiBloc, PapiState>(
                                    builder: (context, state) {
                                      // if (state.type == "Pertanyaan") {
                                      //   return PapiPertanyaanWidget(
                                      //     papiBloc: _papiBloc,
                                      //   );
                                      // }
                                      return PapiInstruksiWidget(
                                        papiBloc: _papiBloc,
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
