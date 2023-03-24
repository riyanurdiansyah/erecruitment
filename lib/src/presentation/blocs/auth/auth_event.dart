part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthSetupEvent extends AuthEvent {}

class AuthOnChangeUsername extends AuthEvent {
  final String username;

  const AuthOnChangeUsername(this.username);
}

class AuthOnChangePassword extends AuthEvent {
  final String password;

  const AuthOnChangePassword(this.password);
}

class AuthOnChangeVisiblePassword extends AuthEvent {
  const AuthOnChangeVisiblePassword();
}

class AuthLoginEvent extends AuthEvent {
  final String username;
  final String password;

  const AuthLoginEvent(this.username, this.password);
}
