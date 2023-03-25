import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:recruitment/src/domain/entities/disc_entity.dart';

import '../../../data/datasources/remote/dashboard_remote_datasource_impl.dart';
import '../../../data/repositories/dashboard_repository_impl.dart';
import '../../../domain/usecases/dashboard_usecase.dart';

part 'disc_event.dart';
part 'disc_state.dart';

class DiscBloc extends Bloc<DiscEvent, DiscState> {
  late DashboardRemoteDataSourceImpl _datasource;
  late DashboardRepositoryImpl _repository;
  late DashboardUseCase _usecase;

  DiscBloc() : super(DiscInitial()) {
    on<DiscEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<DiscInitialEvent>(_onInitialize);

    on<DiscOnChangeTypeEvent>(_onChangeType);
  }

  FutureOr<void> _onChangeType(
      DiscOnChangeTypeEvent event, Emitter<DiscState> emit) {
    emit(state.copyWith(type: event.type));
  }

  Stream<List<DiscEntity>> streamDisc() {
    return _usecase.streamDisc().map((data) {
      log("CEK DATA 2 : $data");
      return data;
    });
  }

  FutureOr<void> _onInitialize(
      DiscInitialEvent event, Emitter<DiscState> emit) {
    log("SETUP DISC BLOC");
    _datasource = DashboardRemoteDataSourceImpl();
    _repository = DashboardRepositoryImpl(_datasource);
    _usecase = DashboardUseCase(_repository);
  }
}
