import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../domain/entities/user_spf_entity.dart';
part 'welcome_event.dart';
part 'welcome_state.dart';

class WelcomeBloc extends Bloc<WelcomeEvent, WelcomeState> {
  WelcomeBloc() : super(WelcomeInitial()) {
    on<WelcomeCheckAuthenticationEvent>(_checkAuthentication);
  }

  void _checkAuthentication(event, emit) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final username = pref.getString("username");

    if (username != null) {
      final role = pref.getInt("role") ?? 0;
      final tglMulai = pref.getString("tanggal_mulai") ?? "";
      final tglBerakhir = pref.getString("tanggal_berakhir") ?? "";

      final user = UserSpfEntity(
        username: username,
        role: role,
        tanggalMulai: tglMulai,
        tanggalBerakhir: tglBerakhir,
        password: "",
      );
      await Future.delayed(const Duration(seconds: 3))
          .whenComplete(() => emit(WelcomeAuthenticatedState(user)));
    } else {
      await Future.delayed(const Duration(seconds: 3))
          .whenComplete(() => emit(WelcomeUnAuthenticatedState()));
    }
  }
}
