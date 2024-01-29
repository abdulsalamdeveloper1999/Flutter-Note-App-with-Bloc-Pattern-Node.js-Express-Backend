import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app_with_mongo/cubit/getnotes/get_notes_cubit.dart';
import 'package:note_app_with_mongo/cubit/updatenote/update_note_cubit.dart';
import 'package:note_app_with_mongo/models/notes_model.dart';

import 'package:note_app_with_mongo/utils/elevated_button.dart';
import 'package:note_app_with_mongo/utils/snackbar.dart';
import 'package:note_app_with_mongo/utils/textformfield.dart';

class UpdateNotePage extends StatefulWidget {
  final NoteModel noteModel;
  const UpdateNotePage({super.key, required this.noteModel});

  @override
  State<UpdateNotePage> createState() => _UpdateNotePageState();
}

class _UpdateNotePageState extends State<UpdateNotePage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    updateFields();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios),
          ),
          title: const Text('Update Note'),
        ),
        body: BlocBuilder<UpdateNoteCubit, UpdateNoteState>(
          builder: (context, state) {
            return _body(context, state);
          },
        ));
  }

  Padding _body(BuildContext context, state) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _key,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MyField(
              validator: (value) {
                if (value!.isEmpty) {
                  return "required*";
                }
                return null;
              },
              controller: _titleController,
              hintText: 'Title',
            ),
            const SizedBox(height: 16),
            MyField(
              validator: (value) {
                if (value!.isEmpty) {
                  return "required*";
                }
                return null;
              },
              maxLines: 5,
              controller: _descriptionController,
              hintText: 'Description',
            ),
            const SizedBox(height: 16),
            MyButton(
              loading: state is GetNotesLoading ? true : false,
              onPress: () {
                if (_key.currentState!.validate()) {
                  NoteModel noteModel = NoteModel(
                    uid: widget.noteModel.uid,
                    title: _titleController.text,
                    description: _descriptionController.text,
                  );
                  context
                      .read<UpdateNoteCubit>()
                      .updateProfile(noteModel)
                      .then((value) {
                    _titleController.clear();
                    _descriptionController.clear();
                    showSnackBar("Note has been updated", context);
                  });
                }
              },
              text: 'Update Note',
            ),
          ],
        ),
      ),
    );
  }

  void updateFields() {
    _titleController.value = TextEditingValue(
      text: widget.noteModel.title!,
    );
    _descriptionController.value = TextEditingValue(
      text: widget.noteModel.description!,
    );
  }
}
