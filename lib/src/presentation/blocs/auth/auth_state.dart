part of 'auth_bloc.dart';

class AuthState extends Equatable {
  const AuthState({
    // this.username = "",
    // this.password = "",
    this.isHidePassword = true,
  });

  // final String username;
  // final String password;
  final bool isHidePassword;

  AuthState copyWith({
    String? username,
    String? password,
    bool? isHidePassword,
  }) {
    return AuthState(
      // username: username ?? this.username,
      // password: password ?? this.password,
      isHidePassword: isHidePassword ?? this.isHidePassword,
    );
  }

  @override
  List<Object> get props => [isHidePassword];
}

class AuthInitial extends AuthState {}

class AuthLoadingState extends AuthState {}

class AuthLoginSuccessState extends AuthState {}

class AuthLoginErrorState extends AuthState {
  final String errorMsg;

  const AuthLoginErrorState(this.errorMsg);
}
