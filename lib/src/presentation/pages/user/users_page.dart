import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:recruitment/src/presentation/blocs/user/user_bloc.dart';
import 'package:recruitment/utils/app_dialog.dart';

import '../../../../utils/app_color.dart';
import '../../../../utils/app_text.dart';
import '../../../domain/entities/user_entity.dart';
import '../widgets/header.dart';
import '../widgets/pagination.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({super.key});

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  final _userBloc = UserBloc();

  @override
  void initState() {
    _userBloc.add(UserInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocProvider<UserBloc>(
      create: (context) => _userBloc,
      child: Scaffold(
        key: _userBloc.globalKey,
        backgroundColor: backgroundGrey,
        body: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            if (state.isLoadingSetup) {
              return const SizedBox();
            }
            return Container(
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
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {},
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: Colors.white,
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.upload_rounded,
                                  size: 14,
                                  color: Colors.black,
                                ),
                                const SizedBox(
                                  width: 12,
                                ),
                                AppText.labelW500(
                                  "Export",
                                  14,
                                  Colors.black,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 14,
                        ),
                        InkWell(
                          onTap: () {},
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: Colors.white,
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.download_rounded,
                                  size: 14,
                                  color: Colors.black,
                                ),
                                const SizedBox(
                                  width: 12,
                                ),
                                AppText.labelW500(
                                  "Import",
                                  14,
                                  Colors.black,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 14,
                        ),
                        InkWell(
                          onTap: () => _userBloc.add(UserDeleteEvent()),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: Colors.red,
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.delete_rounded,
                                  size: 14,
                                  color: Colors.white,
                                ),
                                const SizedBox(
                                  width: 12,
                                ),
                                AppText.labelW600(
                                  "Delete",
                                  14,
                                  Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const Spacer(),
                        InkWell(
                          onTap: () {},
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: Colors.white,
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.sort_by_alpha_rounded,
                                  size: 14,
                                  color: Colors.black,
                                ),
                                const SizedBox(
                                  width: 12,
                                ),
                                AppText.labelW500(
                                  "Sort",
                                  14,
                                  Colors.black,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 14,
                        ),
                        SizedBox(
                          width: 175,
                          height: 36,
                          child: TextField(
                            onTap: () {},
                            onEditingComplete: () {},
                            showCursor: false,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 0.2, color: Colors.grey),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 0.4, color: colorPrimaryDark),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 0.2, color: Colors.white),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 12),
                              hintText: 'Cari data disini',
                              hintStyle: GoogleFonts.poppins(
                                color: Colors.grey,
                                fontSize: 14,
                              ),
                              prefixIcon: const Icon(
                                Icons.search_rounded,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 14,
                        ),
                        InkWell(
                          onTap: () => AppDialog.dialogTambahUser(
                              context: context, userBloc: _userBloc),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: colorPrimaryDark,
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.add_rounded,
                                  size: 14,
                                  color: Colors.white,
                                ),
                                const SizedBox(
                                  width: 12,
                                ),
                                AppText.labelW600(
                                  "Add more",
                                  14,
                                  Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          color: colorSecondaryDark.withOpacity(0.4),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 16),
                          child: Row(
                            children: [
                              const SizedBox(
                                width: 45,
                              ),
                              Expanded(
                                flex: 2,
                                child: AppText.labelW600(
                                  "NAMA",
                                  14,
                                  Colors.black,
                                ),
                              ),
                              Expanded(
                                child: AppText.labelW600(
                                  "NO HP",
                                  14,
                                  Colors.black,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Expanded(
                                child: AppText.labelW600(
                                  "USERNAME",
                                  14,
                                  Colors.black,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Expanded(
                                child: AppText.labelW600(
                                  "KODE AKSES",
                                  14,
                                  Colors.black,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Expanded(
                                child: AppText.labelW600(
                                  "POSISI",
                                  14,
                                  Colors.black,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Expanded(
                                child: AppText.labelW600(
                                  "MULAI",
                                  14,
                                  Colors.black,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Expanded(
                                child: AppText.labelW600(
                                  "BERAKHIR",
                                  14,
                                  Colors.black,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              const SizedBox(
                                width: 36,
                              ),
                            ],
                          ),
                        ),
                        StreamBuilder<List<UserEntity>>(
                          stream: _userBloc.streamUsers(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData || snapshot.data!.isEmpty) {
                              return const SizedBox();
                            }
                            return BlocBuilder<UserBloc, UserState>(
                              builder: (context, state) {
                                return Column(
                                  children: [
                                    Column(
                                      children: List.generate(
                                        state.listData
                                                    .where((e) =>
                                                        e.page == state.page)
                                                    .length >
                                                8
                                            ? 8
                                            : state.listData
                                                .where(
                                                    (e) => e.page == state.page)
                                                .length,
                                        (i) {
                                          final data = state.listData
                                              .where(
                                                  (e) => e.page == state.page)
                                              .toList()[i];
                                          return Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10),
                                            color: i.isEven
                                                ? Colors.white
                                                : Colors.grey.shade300
                                                    .withOpacity(0.4),
                                            child: Row(
                                              children: [
                                                BlocBuilder<UserBloc,
                                                    UserState>(
                                                  builder: (context, state) {
                                                    return SizedBox(
                                                      width: 45,
                                                      height: 45,
                                                      child: Checkbox(
                                                          value: state
                                                              .listChekedUsername
                                                              .contains(data
                                                                  .username),
                                                          activeColor:
                                                              colorPrimaryDark,
                                                          onChanged: (val) =>
                                                              _userBloc.add(
                                                                  UserAddToChecklistEvent(
                                                                      data.username))),
                                                    );
                                                  },
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                      horizontal: 10,
                                                    ),
                                                    child: AppText.labelW600(
                                                      data.email,
                                                      12,
                                                      Colors.grey.shade600,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: AppText.labelW600(
                                                    data.noHp.toString(),
                                                    12,
                                                    Colors.grey.shade600,
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                                Expanded(
                                                  child: AppText.labelW600(
                                                    data.username,
                                                    12,
                                                    Colors.grey.shade600,
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                                Expanded(
                                                  child: AppText.labelW600(
                                                    data.kodeAkses,
                                                    12,
                                                    Colors.grey.shade600,
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                                Expanded(
                                                  child: AppText.labelW600(
                                                    data.posisi,
                                                    12,
                                                    Colors.grey.shade600,
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Center(
                                                    child: AppText.labelW600(
                                                      "${DateFormat.yMMMd('id').add_jm().format(DateTime.parse(data.tanggalMulai))} WIB",
                                                      12,
                                                      Colors.grey.shade600,
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 16,
                                                ),
                                                Expanded(
                                                  child: Center(
                                                    child: AppText.labelW600(
                                                      "${DateFormat.yMMMd('id').add_jm().format(DateTime.parse(data.tanggalSelesai))} WIB",
                                                      12,
                                                      Colors.grey.shade600,
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () => AppDialog
                                                      .dialogTambahUser(
                                                          context: context,
                                                          userBloc: _userBloc,
                                                          user: data),
                                                  child: Container(
                                                    width: 24,
                                                    height: 24,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              6),
                                                      color:
                                                          Colors.grey.shade300,
                                                    ),
                                                    child: const Icon(
                                                      Icons.edit_rounded,
                                                      color: Colors.grey,
                                                      size: 16,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 16,
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 25,
                                    ),
                                    if (snapshot.data!.isNotEmpty)
                                      WebPagination(
                                        currentPage: 1,
                                        totalPage:
                                            (snapshot.data!.length / 8).ceil(),
                                        displayItemCount: 8,
                                        onPageChanged: (page) => _userBloc
                                            .add(UserOnChangePageEvent(page)),
                                      ),
                                  ],
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
