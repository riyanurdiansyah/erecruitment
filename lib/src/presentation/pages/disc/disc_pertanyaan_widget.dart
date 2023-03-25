import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:recruitment/src/domain/entities/disc_entity.dart';
import 'package:recruitment/src/presentation/blocs/disc/disc_bloc.dart';

import '../../../../utils/app_color.dart';
import '../../../../utils/app_text.dart';

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
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              Expanded(
                flex: 2,
                child: AppText.labelW600(
                  "LAST UPDATE",
                  14,
                  Colors.black,
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              Expanded(
                child: AppText.labelW600(
                  "UPDATE BY",
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
            return Column(
              children: List.generate(snapshot.data?.length ?? 0, (i) {
                final data = snapshot.data![i];
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
                          (i + 1).toString(),
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
                              padding:
                                  const EdgeInsets.symmetric(vertical: 2.5),
                              child: AppText.labelW600(
                                "- ${data.soal[innerIndex]}",
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
                          Colors.grey.shade600,
                        ),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Expanded(
                        flex: 2,
                        child: AppText.labelW600(
                          "${DateFormat.yMMMd('id').add_jm().format(DateTime.parse(data.updateBy.date))} WIB",
                          12,
                          Colors.grey.shade600,
                        ),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Expanded(
                        child: AppText.labelW600(
                          data.updateBy.user,
                          12,
                          Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                );
              }),
            );
          },
        ),
        const SizedBox(
          height: 35,
        ),
        SizedBox(
          height: 40,
          width: double.infinity,
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(colorPrimaryDark),
            ),
            onPressed: () {},
            child: AppText.labelW600(
              "Tambah Soal",
              14,
              Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
