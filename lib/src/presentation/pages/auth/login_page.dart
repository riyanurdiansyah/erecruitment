import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recruitment/routes/app_route_name.dart';

import '../../../../utils/app_color.dart';
import '../../../../utils/app_validator.dart';
import '../../blocs/auth/auth_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _authBloc = AuthBloc();

  @override
  void initState() {
    _authBloc.add(AuthSetupEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final router = GoRouter.of(context);
    return BlocProvider(
      create: (context) => _authBloc,
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthLoginErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  state.errorMsg,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                backgroundColor: Colors.red,
                duration: const Duration(milliseconds: 900),
              ),
            );
          }

          if (state is AuthLoginSuccessState) {
            router.goNamed(AppRouteName.home);
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    elevation: 4,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: size.width / 2.5,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 35),
                          child: Form(
                            key: _authBloc.formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: size.width,
                                  alignment: Alignment.center,
                                  child: Image.asset(
                                    "assets/images/logo.png",
                                    filterQuality: FilterQuality.high,
                                    width: 225,
                                  ),
                                ),
                                TextFormField(
                                  controller: _authBloc.tcUsername,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  textInputAction: TextInputAction.next,
                                  cursorColor: Colors.black,
                                  style: GoogleFonts.poppins(
                                    color: Colors.black54,
                                  ),
                                  onChanged: (val) =>
                                      _authBloc.add(AuthOnChangeUsername(val)),
                                  validator: (value) =>
                                      AppValidator.requiredField(value!),
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.zero,
                                    hintText: "johndoe",
                                    hintStyle: GoogleFonts.poppins(
                                      color: Colors.black54,
                                      fontSize: 16,
                                    ),
                                    label: Text(
                                      "Username",
                                      style: GoogleFonts.poppins(
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                BlocBuilder<AuthBloc, AuthState>(
                                  builder: (context, state) {
                                    return TextFormField(
                                      controller: _authBloc.tcPassword,
                                      obscureText: state.isHidePassword,
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      textInputAction: TextInputAction.next,
                                      cursorColor: Colors.black,
                                      keyboardType: TextInputType.emailAddress,
                                      style: GoogleFonts.poppins(
                                        color: Colors.black54,
                                      ),
                                      onChanged: (val) => _authBloc
                                          .add(AuthOnChangePassword(val)),
                                      validator: (value) =>
                                          AppValidator.checkFieldPass(value!),
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.zero,
                                        hintText: "********",
                                        hintStyle: GoogleFonts.poppins(
                                          color: Colors.black54,
                                          fontSize: 16,
                                        ),
                                        label: Text(
                                          "Password",
                                          style: GoogleFonts.poppins(
                                            fontSize: 16,
                                          ),
                                        ),
                                        suffixIcon: InkWell(
                                          onTap: () => _authBloc.add(
                                              const AuthOnChangeVisiblePassword()),
                                          child: Icon(
                                            state.isHidePassword
                                                ? CupertinoIcons.eye
                                                : CupertinoIcons.eye_slash,
                                            color: Colors.black54,
                                            size: 18,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 20,
                                      child: Checkbox(
                                        value: false,
                                        onChanged: (val) {},
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      "Remember me",
                                      style: GoogleFonts.poppins(
                                        color: colorPrimaryDark,
                                        fontSize: 12,
                                      ),
                                    ),
                                    const Spacer(),
                                    TextButton(
                                      onPressed: () {},
                                      child: Text(
                                        "Forgot Password",
                                        style: GoogleFonts.poppins(
                                          color: colorPrimaryDark,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        BlocBuilder<AuthBloc, AuthState>(
                          builder: (context, state) {
                            return Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 18),
                              height: 50,
                              width: size.width / 2.5,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: colorPrimaryDark,
                                ),
                                onPressed: () {
                                  if (_authBloc.formKey.currentState!
                                      .validate()) {
                                    _authBloc.add(AuthLoginEvent(
                                        _authBloc.tcUsername.text,
                                        _authBloc.tcPassword.text));
                                  }
                                },
                                child: Text(
                                  "Sign In",
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
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
                ),
                BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
                  if (state is AuthLoadingState) {
                    return Container(
                      width: double.infinity,
                      height: size.height,
                      color: Colors.transparent,
                      child: Align(
                        alignment: Alignment.center,
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 35),
                          width: 50,
                          height: 50,
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: const CircularProgressIndicator(
                            color: Colors.black26,
                          ),
                        ),
                      ),
                    );
                  }

                  return const SizedBox();
                }),
              ],
            ),
          );
        },
      ),
    );
  }
}
