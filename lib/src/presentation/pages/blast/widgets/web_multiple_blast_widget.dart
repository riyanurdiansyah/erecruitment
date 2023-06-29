import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../utils/app_color.dart';
import '../../../../../../utils/app_text.dart';
import '../../../../../utils/app_constanta_list.dart';
import '../../../../domain/entities/template_entity.dart';
import '../../../blocs/blast/blast_bloc.dart';
import 'user_data_table.dart';

class WebMultipleBlastWidget extends StatelessWidget {
  const WebMultipleBlastWidget({
    Key? key,
    required BlastBloc blastBloc,
  })  : _blastBloc = blastBloc,
        super(key: key);

  final BlastBloc _blastBloc;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    List<DataColumn> _buildColumns(List<Map<String, dynamic>> data) {
      return data[0].keys.map<DataColumn>((String key) {
        return DataColumn(
          label: Text(key),
        );
      }).toList();
    }

    return SizedBox(
      height: size.height / 1.16,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // AppText.labelW600(
            //   "Unggah File",
            //   16,
            //   Colors.black,
            // ),
            // const SizedBox(
            //   height: 12,
            // ),
            // TextFormField(
            //   decoration: InputDecoration(
            //     hintStyle: GoogleFonts.poppins(),
            //     contentPadding:
            //         const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
            //     hintText: "Unggah File .csv",
            //     border: const OutlineInputBorder(),
            //     suffixIcon: Container(
            //       margin: const EdgeInsets.symmetric(vertical: 4),
            //       padding: const EdgeInsets.only(right: 12),
            //       child: OutlinedButton(
            //         style: ButtonStyle(
            //           backgroundColor: MaterialStateProperty.all(Colors.white),
            //           side: MaterialStateProperty.all(
            //             BorderSide(
            //               color: Colors.grey.shade400,
            //               width: 0.5,
            //             ),
            //           ),
            //         ),
            //         onPressed: () => _blastBloc.add(BlastUploadCsvEvent()),
            //         child: AppText.labelW500(
            //           "Pilih",
            //           14,
            //           Colors.black,
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            // const SizedBox(
            //   height: 16,
            // ),
            AppText.labelW600(
              "Link Sheet",
              16,
              Colors.black,
            ),
            const SizedBox(
              height: 12,
            ),
            TextFormField(
              controller: _blastBloc.tcSheet,
              decoration: InputDecoration(
                hintStyle: GoogleFonts.poppins(),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
                hintText: "Masukkan link google Sheet",
                border: const OutlineInputBorder(),
                suffixIcon: Container(
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  padding: const EdgeInsets.only(right: 12),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(colorPrimaryDark),
                      side: MaterialStateProperty.all(
                        BorderSide(
                          color: Colors.grey.shade400,
                          width: 0.5,
                        ),
                      ),
                    ),
                    onPressed: () => _blastBloc.add(BlastUploadSheetEvent()),
                    child: AppText.labelW500(
                      "Ekstrak",
                      14,
                      Colors.white,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(
              height: 16,
            ),
            BlocBuilder<BlastBloc, BlastState>(
              builder: (context, state) {
                if (state.datasheets.isEmpty) {
                  return const SizedBox();
                }
                return Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    PaginatedDataTable(
                      rowsPerPage: 5,
                      arrowHeadColor: colorPrimaryDark,
                      columns: _buildColumns(state.datasheets),
                      source: UserDataTableSource(
                        userData: state.datasheets,
                      ),
                    ),
                  ],
                );
              },
            ),
            const SizedBox(
              height: 20,
            ),
            AppText.labelW600(
              "Pilih Template",
              16,
              Colors.black,
            ),
            const SizedBox(
              height: 12,
            ),
            DropdownButtonFormField<TemplateEntity>(
              items: templateBlast.map((TemplateEntity template) {
                return DropdownMenuItem<TemplateEntity>(
                  value: template,
                  child: Row(
                    children: <Widget>[
                      AppText.labelW600(
                        template.name,
                        14,
                        Colors.grey.shade600,
                      ),
                    ],
                  ),
                );
              }).toList(),
              onChanged: (val) =>
                  _blastBloc.add(BlastOnChangeTemplateEvent(val!)),
              decoration: InputDecoration(
                hintStyle: GoogleFonts.poppins(),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
                hintText: ".....",
                border: const OutlineInputBorder(),
              ),
            ),
            // const SizedBox(
            //   height: 35,
            // ),
            // BlocBuilder<BlastBloc, BlastState>(
            //   builder: ((context, state) {
            //     if (state.template.contains("informasi")) {
            //       return WebInformasiBlastWidget(blastBloc: _blastBloc);
            //     }

            //     if (state.template.contains("custom")) {
            //       return WebCustomBlastWidget(blastBloc: _blastBloc);
            //     }
            //     if (state.template.contains("invitation")) {
            //       return Container(
            //         width: double.infinity,
            //         height: 80,
            //         color: Colors.blue,
            //       );
            //     }

            //     return const SizedBox();
            //   }),
            // ),
            const SizedBox(
              height: 35,
            ),
            BlocBuilder<BlastBloc, BlastState>(
              builder: (context, state) {
                return SizedBox(
                  height: 45,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => _blastBloc.add(
                      BlastSendMultipleMessageEvent(
                          // listData: state.listData ?? [],
                          ),
                    ),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(colorPrimaryDark)),
                    child: AppText.labelBold(
                      "Kirim",
                      14,
                      Colors.white,
                    ),
                  ),
                );
              },
            ),
            const SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
