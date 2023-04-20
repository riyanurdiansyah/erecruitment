import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:recruitment/src/domain/entities/disc_entity.dart';
import 'package:recruitment/src/presentation/blocs/disc/disc_bloc.dart';
import 'package:recruitment/utils/app_dialog.dart';

import '../../../../utils/app_color.dart';
import '../../../../utils/app_text.dart';
import '../widgets/pagination.dart';

class DiscPertanyaanWidget extends StatelessWidget {
  const DiscPertanyaanWidget({
    super.key,
    required DiscBloc discBloc,
  }) : _discBloc = discBloc;

  final DiscBloc _discBloc;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: colorSecondaryDark.withOpacity(0.4),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
          child: Row(
            children: [
              SizedBox(
                width: 60,
                child: AppText.labelW600(
                  "No.",
                  14,
                  Colors.black,
                ),
              ),
              Expanded(
                flex: 3,
                child: AppText.labelW600(
                  "OPTION",
                  14,
                  Colors.black,
                ),
              ),
              Expanded(
                child: AppText.labelW600(
                  "STATUS",
                  14,
                  Colors.black,
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              BlocBuilder<DiscBloc, DiscState>(
                builder: (context, state) {
                  if (state.showPreview) {
                    return const SizedBox();
                  }
                  return Expanded(
                    flex: 2,
                    child: AppText.labelW600(
                      "LAST UPDATE",
                      14,
                      Colors.black,
                      textAlign: TextAlign.center,
                    ),
                  );
                },
              ),
              const SizedBox(
                width: 12,
              ),
              Expanded(
                child: AppText.labelW600(
                  "UPDATE BY",
                  14,
                  Colors.black,
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: AppText.labelW600(
                  "",
                  14,
                  Colors.black,
                ),
              ),
            ],
          ),
        ),
        StreamBuilder<List<DiscEntity>>(
          stream: _discBloc.streamDisc(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const SizedBox();
            }
            if (snapshot.data!.isEmpty) {
              return const SizedBox();
            }

            return BlocBuilder<DiscBloc, DiscState>(
              builder: (context, state) {
                return Column(
                  children: [
                    Column(
                      children: List.generate(
                          state.listData
                              .where((e) => e.page == state.page)
                              .length, (i) {
                        final data = state.listData
                            .where((e) => e.page == state.page)
                            .toList()[i];
                        return Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          color: i.isEven
                              ? Colors.white
                              : Colors.grey.shade300.withOpacity(0.4),
                          child: Row(
                            children: [
                              Container(
                                alignment: Alignment.center,
                                width: 60,
                                child: AppText.labelW600(
                                  data.number.toString(),
                                  12,
                                  Colors.grey.shade600,
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: List.generate(
                                    data.soal.length,
                                    (innerIndex) => Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 2.5),
                                      child: AppText.labelW600(
                                        "${String.fromCharCode("A".codeUnitAt(0) + innerIndex)}. ${data.soal[innerIndex]}",
                                        12,
                                        Colors.grey.shade600,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: AppText.labelW600(
                                  data.status ? "Aktif" : "Tidak Aktif",
                                  12,
                                  data.status ? Colors.green : Colors.red,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              const SizedBox(
                                width: 12,
                              ),
                              BlocBuilder<DiscBloc, DiscState>(
                                builder: (context, state) {
                                  if (state.showPreview) {
                                    return const SizedBox();
                                  }
                                  return Expanded(
                                    flex: 2,
                                    child: AppText.labelW600(
                                      "${DateFormat.yMMMd('id').add_jm().format(DateTime.parse(data.updateBy.date))} WIB",
                                      12,
                                      Colors.grey.shade600,
                                      textAlign: TextAlign.center,
                                    ),
                                  );
                                },
                              ),
                              const SizedBox(
                                width: 12,
                              ),
                              Expanded(
                                child: AppText.labelW600(
                                  data.updateBy.user,
                                  12,
                                  Colors.grey.shade600,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  children: [
                                    InkWell(
                                      onTap: () => _discBloc.add(
                                          DiscDeleteSoalEvent(id: data.id)),
                                      child: Container(
                                        width: 35,
                                        height: 35,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(6),
                                          color: Colors.red.shade300,
                                        ),
                                        child: const Icon(
                                          Icons.delete_rounded,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 12,
                                    ),
                                    InkWell(
                                      onTap: () =>
                                          AppDialog.dialogTambahSoalDISC(
                                        context: context,
                                        discBloc: _discBloc,
                                        data: data,
                                      ),
                                      child: Container(
                                        width: 35,
                                        height: 35,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(6),
                                          color: Colors.amber.shade300,
                                        ),
                                        child: const Icon(
                                          Icons.edit_rounded,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    if (snapshot.data!.isNotEmpty)
                      WebPagination(
                        currentPage: 1,
                        totalPage: (snapshot.data!.length / 5).ceil(),
                        displayItemCount: 11,
                        onPageChanged: (page) =>
                            _discBloc.add(DiscOnChangePageEvent(page)),
                      ),
                  ],
                );
              },
            );
          },
        ),
        const SizedBox(
          height: 35,
        ),
        Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 40,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.grey.shade400),
                  ),
                  onPressed: () => _discBloc.add(DiscPreviewEvent()),
                  child: AppText.labelW600(
                    "Preview",
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
                    backgroundColor:
                        MaterialStateProperty.all(colorPrimaryDark),
                  ),
                  onPressed: () {
                    AppDialog.dialogTambahSoalDISC(
                        context: context, discBloc: _discBloc);
                  },
                  child: AppText.labelW600(
                    "Tambah Soal",
                    14,
                    Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
