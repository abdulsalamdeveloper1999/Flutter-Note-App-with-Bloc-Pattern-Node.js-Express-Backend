import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app_with_mongo/models/user_model.dart';
import 'package:note_app_with_mongo/respository/network_repository.dart';
import 'package:note_app_with_mongo/utils/server_exception.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final networkRepo = NetworkRepo();
  UserCubit() : super(UserInitial());

  Future<void> getprofile(UserModel user) async {
    emit(UserLoading());
    try {
      final data = await networkRepo.getProfile(user);
      emit(UserSuccess(userModel: data));
    } on ServerException catch (e) {
      emit(UserFailure(error: e.toString()));
    }
  }

  Future<void> updateProfile(UserModel user) async {
    try {
      await networkRepo.updateProfile(user);
    } on ServerException catch (e) {
      emit(UserFailure(error: e.toString()));
    }
  }
}
