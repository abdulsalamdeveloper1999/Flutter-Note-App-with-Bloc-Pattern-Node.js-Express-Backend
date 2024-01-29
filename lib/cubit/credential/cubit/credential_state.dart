part of 'credential_cubit.dart';

sealed class CredentialState extends Equatable {
  const CredentialState();

  @override
  List<Object> get props => [];
}

final class CredentialInitial extends CredentialState {
  @override
  List<Object> get props => [];
}

final class Credentialloading extends CredentialState {
  @override
  List<Object> get props => [];
}

final class CredentialSuccess extends CredentialState {
  final UserModel userModel;

  const CredentialSuccess({required this.userModel});

  @override
  List<Object> get props => [];
}

final class CredentialFailure extends CredentialState {
  final String errorMessage;

  const CredentialFailure({required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}
