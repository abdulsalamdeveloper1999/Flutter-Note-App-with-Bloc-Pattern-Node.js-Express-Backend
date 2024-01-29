import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app_with_mongo/cubit/addnote/addnote_cubit.dart';
import 'package:note_app_with_mongo/cubit/auth/cubit/auth_cubit.dart';
import 'package:note_app_with_mongo/cubit/credential/cubit/credential_cubit.dart';
import 'package:note_app_with_mongo/cubit/getnotes/get_notes_cubit.dart';
import 'package:note_app_with_mongo/cubit/updatenote/update_note_cubit.dart';
import 'package:note_app_with_mongo/cubit/user/user_cubit.dart';
import 'package:note_app_with_mongo/router/ongenerate_route.dart';
import 'package:note_app_with_mongo/ui/auth_views/login.dart';
import 'package:note_app_with_mongo/ui/home_views/home_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocProvider<AuthCubit>(create: (_) => AuthCubit()..appStarted()),
        BlocProvider<CredentialCubit>(create: (_) => CredentialCubit()),
        BlocProvider<UserCubit>(create: (_) => UserCubit()),
        BlocProvider<AddnoteCubit>(create: (_) => AddnoteCubit()),
        BlocProvider<GetNotesCubit>(create: (_) => GetNotesCubit()..getNotes()),
        BlocProvider<UpdateNoteCubit>(create: (_) => UpdateNoteCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          primarySwatch: Colors.deepPurple,
          useMaterial3: true,
        ),
        onGenerateRoute: OnGenerateRoute.route,
        routes: {
          "/": (context) {
            return BlocBuilder<AuthCubit, AuthState>(
                builder: (context, authState) {
              if (authState is Authenticated) {
                if (authState.uid == "") {
                  return const LoginPage();
                } else {
                  return NoteHomePage(
                    uid: authState.uid,
                  );
                }
              } else {
                return const LoginPage();
              }
            });
          }
        },
      ),
    );
  }
}
