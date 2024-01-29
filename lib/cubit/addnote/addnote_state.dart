part of 'addnote_cubit.dart';

sealed class AddnoteState extends Equatable {
  const AddnoteState();

  @override
  List<Object> get props => [];
}

final class AddnoteInitial extends AddnoteState {}

final class AddnoteLoading extends AddnoteState {}

final class AddnoteSuccess extends AddnoteState {
  final NoteModel noteModel;

  const AddnoteSuccess({required this.noteModel});
  @override
  List<Object> get props => [noteModel];
}

final class AddnoteFailed extends AddnoteState {
  final String error;

  const AddnoteFailed({required this.error});

  @override
  List<Object> get props => [error];
}
