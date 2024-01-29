part of 'get_notes_cubit.dart';

sealed class GetNotesState extends Equatable {
  const GetNotesState();

  @override
  List<Object> get props => [];
}

final class GetNotesInitial extends GetNotesState {}

final class GetNotesLoading extends GetNotesState {}

final class GetNotesSuccess extends GetNotesState {
  final List<NoteModel> noteModel;

  const GetNotesSuccess({required this.noteModel});
  @override
  List<Object> get props => [noteModel];
}

final class GetNotesFailure extends GetNotesState {
  final String error;

  const GetNotesFailure({required this.error});
  @override
  List<Object> get props => [error];
}
