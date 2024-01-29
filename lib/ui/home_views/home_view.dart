import 'package:flutter/material.dart';
import 'package:note_app_with_mongo/cubit/auth/cubit/auth_cubit.dart';

import 'package:note_app_with_mongo/cubit/getnotes/get_notes_cubit.dart';
import 'package:note_app_with_mongo/models/notes_model.dart';
import 'package:note_app_with_mongo/router/page_constant.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:note_app_with_mongo/ui/update_note/update_note.dart';

class NoteHomePage extends StatefulWidget {
  final String? uid;
  const NoteHomePage({super.key, this.uid});

  @override
  State<NoteHomePage> createState() => _NoteHomePageState();
}

class _NoteHomePageState extends State<NoteHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(
            context,
            PageConstant.addNotePage,
          );
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        backgroundColor: const Color(0xFF673AB7).withOpacity(0.5),
        leading: IconButton(
          onPressed: () {
            Navigator.pushNamed(
              context,
              PageConstant.profilePage,
              arguments: widget.uid,
            );
          },
          icon: const Icon(Icons.person),
        ),
        title: const Text('My Notes '),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              context.read<GetNotesCubit>().getNotes();
            },
          ),
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () {
              context.read<AuthCubit>().loggedOut();
            },
          ),
        ],
      ),
      body: BlocBuilder<GetNotesCubit, GetNotesState>(
        builder: (_, state) {
          if (state is GetNotesSuccess) {
            return _body(state);
          } else if (state is GetNotesLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is GetNotesFailure) {
            return Center(
              child: Text(state.error),
            );
          } else {
            return const Center(
              child: Text('no state'),
            );
          }
        },
      ),
    );
  }

  Widget _body(GetNotesSuccess state) {
    return state.noteModel.isEmpty
        ? const Center(
            child: Text('No Notes'),
          )
        : ListView.builder(
            itemCount: state.noteModel.length,
            itemBuilder: (context, index) {
              final data = state.noteModel[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => UpdateNotePage(
                        noteModel: data,
                      ),
                    ),
                  );
                },
                child: Dismissible(
                  key: Key(data.uid!),
                  background: Container(
                    padding: const EdgeInsets.only(left: 10),
                    alignment: Alignment.centerLeft,
                    color: Colors.red,
                    child: const Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                  ),
                  secondaryBackground: Container(
                    padding: const EdgeInsets.only(right: 10),
                    alignment: Alignment.centerRight,
                    color: Colors.red,
                    child: const Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                  ),
                  onDismissed: (direction) {
                    context.read<GetNotesCubit>().deleteNote(
                          NoteModel(uid: data.uid),
                        );
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${data.title} dismissed'),
                      ),
                    );
                  },
                  child: Card(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    elevation: 5,
                    child: ListTile(
                      title: Text(data.title!),
                      subtitle: Text(data.description!),
                      trailing: const Icon(Icons.arrow_forward),
                    ),
                  ),
                ),
              );
            },
          );
  }
}
