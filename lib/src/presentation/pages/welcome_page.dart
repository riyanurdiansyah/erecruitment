import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:recruitment/routes/app_route_name.dart';
import '../blocs/welcome/welcome_bloc.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<WelcomeBloc>(
      create: (context) =>
          WelcomeBloc()..add(WelcomeCheckAuthenticationEvent()),
      child: BlocListener<WelcomeBloc, WelcomeState>(
        listener: (context, state) {
          if (state is WelcomeAuthenticatedState) {
            if (state.user.role == 1) {
              context.go(AppRouteName.home);
            } else {
              context.go(AppRouteName.home);
            }
          }

          if (state is WelcomeUnAuthenticatedState) {
            context.goNamed(AppRouteName.signin);
          }
        },
        child: Scaffold(
          body: Center(
            child: GestureDetector(
              onTap: () => context.go(AppRouteName.signin),
              child: Image.asset(
                "assets/images/logo.png",
                width: 200,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
