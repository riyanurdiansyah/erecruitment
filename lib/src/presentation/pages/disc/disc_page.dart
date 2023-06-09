import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recruitment/src/presentation/blocs/disc/disc_bloc.dart';
import 'package:recruitment/src/presentation/pages/disc/disc_instruksi_widget.dart';
import 'package:recruitment/utils/app_constanta_list.dart';
import 'package:recruitment/utils/app_text.dart';

import '../../../../utils/app_color.dart';
import '../widgets/header.dart';
import 'disc_pertanyaan_widget.dart';
import 'widgets.dart/disc_preview_widget.dart';

class DiscPage extends StatefulWidget {
  const DiscPage({super.key});

  @override
  State<DiscPage> createState() => _DiscPageState();
}

class _DiscPageState extends State<DiscPage> {
  final _discBloc = DiscBloc();

  @override
  void initState() {
    _discBloc.add(DiscInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => _discBloc,
      child: Scaffold(
        key: _discBloc.globalKey,
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
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 15,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 14),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  BlocBuilder<DiscBloc, DiscState>(
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
                                              onTap: () => _discBloc.add(
                                                  DiscOnChangeTypeEvent(
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
                                  BlocBuilder<DiscBloc, DiscState>(
                                    builder: (context, state) {
                                      if (state.type == "Pertanyaan") {
                                        return DiscPertanyaanWidget(
                                          discBloc: _discBloc,
                                        );
                                      }
                                      return DiscInstruksiWidget(
                                        discBloc: _discBloc,
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 25,
                          ),
                          DiscPreviewWidget(size: size, discBloc: _discBloc),
                        ],
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
