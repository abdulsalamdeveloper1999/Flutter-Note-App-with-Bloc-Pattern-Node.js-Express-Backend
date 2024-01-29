part of 'update_note_cubit.dart';

sealed class UpdateNoteState extends Equatable {
  const UpdateNoteState();

  @override
  List<Object> get props => [];
}

final class UpdateNoteInitial extends UpdateNoteState {}

final class UpdateNoteLoading extends UpdateNoteState {}

final class UpdateNoteSuccess extends UpdateNoteState {
  final NoteModel noteModel;

  const UpdateNoteSuccess({required this.noteModel});

  @override
  List<Object> get props => [noteModel];
}

final class UpdateNoteFailure extends UpdateNoteState {
  final String error;

  const UpdateNoteFailure({required this.error});

  @override
  List<Object> get props => [error];
}
