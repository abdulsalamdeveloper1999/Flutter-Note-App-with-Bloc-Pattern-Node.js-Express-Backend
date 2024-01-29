import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app_with_mongo/models/notes_model.dart';
import 'package:note_app_with_mongo/respository/network_repository.dart';

part 'addnote_state.dart';

class AddnoteCubit extends Cubit<AddnoteState> {
  final networkRepo = NetworkRepo();
  AddnoteCubit() : super(AddnoteInitial());

  Future<void> addNote(NoteModel noteModel) async {
    emit(AddnoteLoading());
    try {
      final data = await networkRepo.addNote(noteModel);
      emit(AddnoteSuccess(noteModel: data));
    } catch (e) {
      emit(AddnoteFailed(error: e.toString()));
    }
  }
}
