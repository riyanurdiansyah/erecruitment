import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../utils/app_color.dart';
import '../../../../../utils/app_text.dart';
import '../../../../domain/entities/disc_entity.dart';
import '../../../blocs/disc/disc_bloc.dart';

class DiscTableQuestionWidget extends StatelessWidget {
  const DiscTableQuestionWidget({
    Key? key,
    required DiscBloc discBloc,
  })  : _discBloc = discBloc,
        super(key: key);

  final DiscBloc _discBloc;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<DiscEntity>>(
      stream: _discBloc.streamDiscWhereActive(),
      builder: (context, snapshot) {
        if (snapshot.data == null) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        final data = snapshot.data ?? [];
        return BlocBuilder<DiscBloc, DiscState>(
          builder: (context, state) {
            int c = "a".codeUnitAt(0);
            return Column(
              children: [
                Table(
                    columnWidths: const {
                      0: FractionColumnWidth(0.2),
                      1: FractionColumnWidth(0.2),
                      2: FractionColumnWidth(0.6),
                    },
                    border: null,
                    children: [
                      TableRow(children: [
                        Center(
                          child: AppText.labelW500(
                            "Sesuai",
                            12,
                            Colors.grey,
                          ),
                        ),
                        Center(
                          child: AppText.labelW500(
                            "Tidak Sesuai",
                            12,
                            Colors.grey,
                          ),
                        ),
                        AppText.labelW500(
                          "",
                          12,
                          Colors.grey,
                        )
                      ]),
                    ]),
                Table(
                  border: TableBorder.all(),
                  columnWidths: const {
                    0: FractionColumnWidth(0.2),
                    1: FractionColumnWidth(0.2),
                    2: FractionColumnWidth(0.6),
                  },
                  children: List.generate(
                    data.length,
                    (index) => TableRow(children: [
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Center(
                          child: AppText.labelW500(
                            String.fromCharCode(c + index).toUpperCase(),
                            12,
                            Colors.grey,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Center(
                          child: AppText.labelW500(
                            String.fromCharCode(c + index).toUpperCase(),
                            12,
                            Colors.grey,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Center(
                          child: AppText.labelW500(
                            data[state.indexPreview].soal[index],
                            12,
                            Colors.grey,
                          ),
                        ),
                      ),
                    ]),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 40,
                          ),
                          AppText.labelW500(
                            "Sesuai",
                            14,
                            Colors.black54,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          AppText.labelW500(
                            "Tidak Sesuai",
                            14,
                            Colors.black54,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: List.generate(
                              data[state.indexPreview].soal.length,
                              (index) => Container(
                                margin: const EdgeInsets.only(left: 18),
                                width: 30,
                                height: 30,
                                child: AppText.labelW500(
                                  String.fromCharCode("a".codeUnitAt(0) + index)
                                      .toUpperCase(),
                                  12,
                                  Colors.grey,
                                ),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: List.generate(
                              data[state.indexPreview].soal.length,
                              (index) => SizedBox(
                                width: 30,
                                height: 30,
                                child: Radio(
                                  fillColor: MaterialStateProperty.all(
                                      colorPrimaryDark),
                                  value: String.fromCharCode(
                                          "a".codeUnitAt(0) + index)
                                      .toUpperCase(),
                                  groupValue: state.answerSesuai,
                                  onChanged: (val) => _discBloc
                                      .add(DiscOnChangeRadio(val!, "sesuai")),
                                ),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: List.generate(
                              data[state.indexPreview].soal.length,
                              (index) => SizedBox(
                                width: 30,
                                height: 30,
                                child: Radio(
                                  value: String.fromCharCode(
                                          "a".codeUnitAt(0) + index)
                                      .toUpperCase(),
                                  fillColor: MaterialStateProperty.all(
                                      colorPrimaryDark),
                                  groupValue: state.answerTidakSesuai,
                                  onChanged: (val) => _discBloc.add(
                                      DiscOnChangeRadio(val!, "tidak_sesuai")),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                Divider(
                  thickness: 2.5,
                  color: colorPrimaryDark.withOpacity(0.4),
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText.labelW500(
                      "Pertanyaan :",
                      14,
                      colorPrimaryDark,
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Expanded(
                      child: BlocBuilder<DiscBloc, DiscState>(
                        builder: (context, state) {
                          return Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: List.generate(
                              data.length,
                              (index) => InkWell(
                                onTap: () => _discBloc
                                    .add(DiscOnChangeIndexPreviewEvent(index)),
                                child: Container(
                                  alignment: Alignment.center,
                                  width: 30,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    color: state.indexPreview == index
                                        ? colorPrimaryDark
                                        : Colors.grey.shade300,
                                  ),
                                  child: AppText.labelW600(
                                    (index + 1).toString(),
                                    14,
                                    state.indexPreview == index
                                        ? Colors.white
                                        : Colors.grey.shade600,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 35,
                    ),
                    SizedBox(
                      height: 40,
                      width: 120,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            colorPrimaryDark,
                          ),
                        ),
                        child: AppText.labelW600(
                          "Kumpulkan",
                          14,
                          Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        );
      },
    );
  }
}
