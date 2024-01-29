part of 'user_cubit.dart';

sealed class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

final class UserInitial extends UserState {}

final class UserLoading extends UserState {}

final class UserSuccess extends UserState {
  final UserModel userModel;

  const UserSuccess({required this.userModel});

  @override
  List<Object> get props => [userModel];
}

final class UserFailure extends UserState {
  final String error;

  const UserFailure({required this.error});

  @override
  List<Object> get props => [error];
}
