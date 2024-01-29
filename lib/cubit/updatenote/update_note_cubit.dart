import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app_with_mongo/models/notes_model.dart';
import 'package:note_app_with_mongo/respository/network_repository.dart';

part 'update_note_state.dart';

class UpdateNoteCubit extends Cubit<UpdateNoteState> {
  final networkRepo = NetworkRepo();
  UpdateNoteCubit() : super(UpdateNoteInitial());

  Future<void> updateProfile(NoteModel noteModel) async {
    try {
      final data = await networkRepo.updateNote(noteModel);
      emit(UpdateNoteSuccess(noteModel: data));
    } catch (e) {
      emit(UpdateNoteFailure(error: e.toString()));
    }
  }
}
