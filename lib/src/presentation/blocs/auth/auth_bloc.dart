import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recruitment/src/core/failure.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/datasources/remote/auth_remote_datasource_impl.dart';
import '../../../data/repositories/auth_repository_impl.dart';
import '../../../domain/usecases/auth_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final formKey = GlobalKey<FormState>();
  late AuthRemoteDataSourceImpl _datasource;
  late AuthRepositoryImpl _repository;
  late AuthUseCase _usecase;

  late SharedPreferences _pref;

  TextEditingController tcUsername = TextEditingController();
  TextEditingController tcPassword = TextEditingController();

  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>((event, emit) {});
    on<AuthSetupEvent>(_onSetup);
    on<AuthOnChangeVisiblePassword>(_onChangeVisiblePassword);
    on<AuthLoginEvent>(_onLogin);
    on<AuthOnChangePassword>(_onChangePassword);
    on<AuthOnChangeUsername>(_onChangeUsername);
  }

  FutureOr<void> _onChangeVisiblePassword(
      AuthOnChangeVisiblePassword event, Emitter<AuthState> emit) async {
    emit(state.copyWith(isHidePassword: !state.isHidePassword));
  }

  FutureOr<void> _onLogin(AuthLoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    final response = await _usecase.getUser(event.username, event.password);
    response.fold((fail) {
      if (fail is HttpFailure) {
        Future.delayed(const Duration(seconds: 2));
        emit(AuthLoginErrorState(fail.message));
      }
      Future.delayed(const Duration(seconds: 2));
      emit(const AuthLoginErrorState("Failed connect to server"));
    }, (user) {
      _pref.setString("username", user.username);
      _pref.setString("tanggal_mulai", user.tanggalMulai);
      _pref.setString("tanggal_berakhir", user.tanggalBerakhir);
      emit(AuthLoginSuccessState());
    });
  }

  FutureOr<void> _onChangeUsername(
      AuthOnChangeUsername event, Emitter<AuthState> emit) {
    emit(state.copyWith(username: event.username));
  }

  FutureOr<void> _onChangePassword(
      AuthOnChangePassword event, Emitter<AuthState> emit) {
    emit(state.copyWith(password: event.password));
  }

  FutureOr<void> _onSetup(AuthSetupEvent event, Emitter<AuthState> emit) async {
    _datasource = AuthRemoteDataSourceImpl();
    _repository = AuthRepositoryImpl(_datasource);
    _usecase = AuthUseCase(_repository);

    _pref = await SharedPreferences.getInstance();
  }
}
