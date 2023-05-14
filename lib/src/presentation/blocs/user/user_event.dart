part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class UserInitialEvent extends UserEvent {}

class StreamUsersEvent extends UserEvent {}

class UserAddToChecklistEvent extends UserEvent {
  const UserAddToChecklistEvent(this.username);

  final String username;
}

class UserAddNewEvent extends UserEvent {
  const UserAddNewEvent(this.user);

  final UserEntity user;
}

class UserUpdateEvent extends UserEvent {
  const UserUpdateEvent(this.user);

  final UserEntity user;
}

class UserDeleteEvent extends UserEvent {}

class UserUpdateListDataEvent extends UserEvent {
  const UserUpdateListDataEvent(this.listData);

  final List<UserEntity> listData;
}

class UserOnChangePageEvent extends UserEvent {
  const UserOnChangePageEvent(this.currPage);

  final int currPage;
}
