import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app_with_mongo/cubit/addnote/addnote_cubit.dart';
import 'package:note_app_with_mongo/models/notes_model.dart';

import 'package:note_app_with_mongo/utils/elevated_button.dart';
import 'package:note_app_with_mongo/utils/snackbar.dart';
import 'package:note_app_with_mongo/utils/textformfield.dart';

class AddNotePage extends StatefulWidget {
  const AddNotePage({super.key});

  @override
  State<AddNotePage> createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: const Text('Add Note'),
      ),
      body: BlocConsumer<AddnoteCubit, AddnoteState>(
        builder: (_, state) {
          // if (state is AddnoteLoading) {
          //   return const Center(
          //     child: CircularProgressIndicator(),
          //   );
          // } else

          return _body(context, state);
        },
        listener: (BuildContext context, state) {
          if (state is AddnoteFailed) {
            showSnackBar(state.error, context);
          }
        },
      ),
    );
  }

  Padding _body(BuildContext context, AddnoteState state) {
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
              loading: state is AddnoteLoading ? true : false,
              onPress: () {
                if (_key.currentState!.validate()) {
                  NoteModel noteModel = NoteModel(
                    uid: '',
                    title: _titleController.text,
                    description: _descriptionController.text,
                  );
                  context.read<AddnoteCubit>().addNote(noteModel).then((value) {
                    _titleController.clear();
                    _descriptionController.clear();
                    showSnackBar('Note has been added', context);
                  });
                }
              },
              text: 'Add Note',
            ),
          ],
        ),
      ),
    );
  }
}
