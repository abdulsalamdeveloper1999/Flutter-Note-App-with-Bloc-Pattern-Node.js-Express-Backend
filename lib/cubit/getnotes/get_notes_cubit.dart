import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app_with_mongo/models/notes_model.dart';
import 'package:note_app_with_mongo/respository/network_repository.dart';

part 'get_notes_state.dart';

class GetNotesCubit extends Cubit<GetNotesState> {
  final networkRepo = NetworkRepo();
  GetNotesCubit() : super(GetNotesInitial());

  Future<void> getNotes() async {
    emit(GetNotesLoading());
    try {
      final notes = await networkRepo.getNotes();

      emit(GetNotesSuccess(noteModel: notes));
    } catch (e) {
      emit(GetNotesFailure(error: e.toString()));
    }
  }

  Future<void> deleteNote(NoteModel noteModel) async {
    await networkRepo.deleteNote(noteModel).then((value) {
      getNotes();
    });
  }

  @override
  void onChange(Change<GetNotesState> change) {
    // log(change.toString());
    super.onChange(change);
  }
}
