import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app_with_mongo/models/user_model.dart';

import 'package:note_app_with_mongo/utils/server_exception.dart';

import '../../../respository/network_repository.dart';

part 'credential_state.dart';

class CredentialCubit extends Cubit<CredentialState> {
  final networkRepo = NetworkRepo();

  CredentialCubit() : super(CredentialInitial());

  Future<void> signUp(UserModel user) async {
    emit(Credentialloading());

    try {
      final userData = await networkRepo.signUp(user);
      emit(CredentialSuccess(userModel: userData));
    } on ServerException catch (e) {
      emit(CredentialFailure(errorMessage: e.error));
    } catch (_) {
      emit(const CredentialFailure(errorMessage: "Unknown error occurred"));
    }
  }

  Future<void> signIn(UserModel user) async {
    emit(Credentialloading());

    try {
      final userData = await networkRepo.signIn(user);
      emit(CredentialSuccess(userModel: userData));
    } on ServerException catch (e) {
      emit(CredentialFailure(errorMessage: e.error));
    } catch (_) {
      emit(const CredentialFailure(errorMessage: "Unknown error occurred"));
    }
  }
}
