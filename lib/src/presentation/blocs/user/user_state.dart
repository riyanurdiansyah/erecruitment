part of 'user_bloc.dart';

class UserState extends Equatable {
  const UserState({
    this.isLoadingSetup = true,
    this.listChekedUsername = const [],
    this.isChecked = false,
  });

  final bool isLoadingSetup;
  final List<String> listChekedUsername;
  final bool isChecked;

  @override
  List<Object> get props => [
        isLoadingSetup,
        listChekedUsername,
        isChecked,
      ];

  UserState copyWith({
    bool? isLoadingSetup,
    List<String>? listChekedUsername,
    bool? isChecked,
  }) =>
      UserState(
        isLoadingSetup: isLoadingSetup ?? this.isLoadingSetup,
        listChekedUsername: listChekedUsername ?? this.listChekedUsername,
        isChecked: isChecked ?? this.isChecked,
      );
}

class UserInitial extends UserState {}
