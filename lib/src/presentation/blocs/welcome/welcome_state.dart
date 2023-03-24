part of 'welcome_bloc.dart';

abstract class WelcomeState extends Equatable {
  const WelcomeState();

  @override
  List<Object> get props => [];
}

class WelcomeInitial extends WelcomeState {}

class WelcomeAuthenticatedState extends WelcomeState {
  final UserSpfEntity user;

  const WelcomeAuthenticatedState(this.user);
}

class WelcomeUnAuthenticatedState extends WelcomeState {}
