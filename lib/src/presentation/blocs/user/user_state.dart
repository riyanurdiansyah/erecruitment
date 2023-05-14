part of 'user_bloc.dart';

class UserState extends Equatable {
  const UserState({
    this.isLoadingSetup = true,
    this.listChekedUsername = const [],
    this.isChecked = false,
    this.page = 1,
    this.listData = const [],
  });

  final bool isLoadingSetup;
  final List<String> listChekedUsername;
  final bool isChecked;
  final int page;
  final List<UserEntity> listData;

  @override
  List<Object> get props => [
        isLoadingSetup,
        listChekedUsername,
        isChecked,
        page,
        listData,
      ];

  UserState copyWith({
    bool? isLoadingSetup,
    List<String>? listChekedUsername,
    bool? isChecked,
    int? page,
    List<UserEntity>? listData,
  }) =>
      UserState(
        isLoadingSetup: isLoadingSetup ?? this.isLoadingSetup,
        listChekedUsername: listChekedUsername ?? this.listChekedUsername,
        isChecked: isChecked ?? this.isChecked,
        page: page ?? this.page,
        listData: listData ?? this.listData,
      );
}

class UserInitial extends UserState {}
