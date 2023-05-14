import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recruitment/src/domain/entities/user_entity.dart';

import '../../../../utils/app_dialog.dart';
import '../../../data/datasources/remote/dashboard_remote_datasource_impl.dart';
import '../../../data/repositories/dashboard_repository_impl.dart';
import '../../../domain/usecases/dashboard_usecase.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final globalKey = GlobalKey<ScaffoldState>();
  late DashboardRemoteDataSourceImpl _datasource;
  late DashboardRepositoryImpl _repository;
  late DashboardUseCase _usecase;

  UserBloc() : super(UserInitial()) {
    on<UserEvent>((event, emit) {});
    on<UserInitialEvent>(_onInitialize);
    on<UserAddToChecklistEvent>(_onAddUserToChecklist);
    on<UserAddNewEvent>(_onAddUserNew);
    on<UserUpdateEvent>(_onUpdateUser);
    on<UserDeleteEvent>(_onDeleteUser);
    on<UserOnChangePageEvent>(_onUserChangePage);
    on<UserUpdateListDataEvent>(_onUserUpdateListData);
  }
  FutureOr<void> _onInitialize(
      UserInitialEvent event, Emitter<UserState> emit) {
    _datasource = DashboardRemoteDataSourceImpl();
    _repository = DashboardRepositoryImpl(_datasource);
    _usecase = DashboardUseCase(_repository);
    emit(state.copyWith(isLoadingSetup: false));
  }

  Stream<List<UserEntity>> streamUsers() {
    return _usecase.streamUsers().map((data) {
      add(UserUpdateListDataEvent(data));
      return data;
    });
  }

  FutureOr<void> _onAddUserToChecklist(
      UserAddToChecklistEvent event, Emitter<UserState> emit) {
    List<String> listTemp = [];
    // listTemp = state.listChekedUsername;

    for (var data in state.listChekedUsername) {
      listTemp.add(data);
    }
    if (listTemp.contains(event.username)) {
      listTemp.removeWhere((e) => e == event.username);
    } else {
      listTemp.add(event.username);
    }
    emit(state.copyWith(listChekedUsername: listTemp));
  }

  FutureOr<void> _onAddUserNew(
      UserAddNewEvent event, Emitter<UserState> emit) async {
    final response = await _usecase.addNewUser(event.user);
    response.fold(
        (l) => AppDialog.dialogNoAction(
            context: globalKey.currentContext!, title: "Gagal menambah data"),
        (r) => AppDialog.dialogNoAction(
            context: globalKey.currentContext!,
            title: "Data berhasil ditambahkan"));
  }

  Future<TimeOfDay?> getTime() async {
    return await showTimePicker(
      context: globalKey.currentContext!,
      initialTime: TimeOfDay.now(),
    );
  }

  Future<DateTime?> getDate() async {
    return await showDatePicker(
        context: globalKey.currentContext!,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        initialEntryMode: DatePickerEntryMode.calendarOnly,
        initialDatePickerMode: DatePickerMode.day,
        lastDate: DateTime.now().add(const Duration(days: 365)));
  }

  FutureOr<void> _onUpdateUser(
      UserUpdateEvent event, Emitter<UserState> emit) async {
    final response = await _usecase.updateUser(event.user);
    response.fold(
        (l) => AppDialog.dialogNoAction(
            context: globalKey.currentContext!, title: "Gagal mengubah data"),
        (r) => AppDialog.dialogNoAction(
            context: globalKey.currentContext!, title: "Data berhasil diubah"));
  }

  FutureOr<void> _onDeleteUser(
      UserDeleteEvent event, Emitter<UserState> emit) async {
    for (int i = 0; i < state.listChekedUsername.length; i++) {
      final response = await _usecase.deleteUser(state.listChekedUsername[i]);
      if ((i + 1) == state.listChekedUsername.length) {
        emit(state.copyWith(listChekedUsername: []));
        response.fold(
            (l) => AppDialog.dialogNoAction(
                context: globalKey.currentContext!,
                title: "Gagal menghapus data"),
            (r) => AppDialog.dialogNoAction(
                context: globalKey.currentContext!,
                title: "Data berhasil dihapus"));
      }
    }
  }

  FutureOr<void> _onUserUpdateListData(
      UserUpdateListDataEvent event, Emitter<UserState> emit) {
    double page = 0;
    for (int i = 0; i < event.listData.length; i++) {
      page = (i + 1) / 8;
      event.listData[i].number = i + 1;
      event.listData[i].page = page.ceil();
    }

    emit(state.copyWith(listData: event.listData));
  }

  FutureOr<void> _onUserChangePage(
      UserOnChangePageEvent event, Emitter<UserState> emit) {
    emit(state.copyWith(page: event.currPage));
  }
}
