import 'package:flutter/material.dart';
import 'package:note_app_with_mongo/router/page_constant.dart';
import 'package:note_app_with_mongo/ui/auth_views/login.dart';
import 'package:note_app_with_mongo/ui/auth_views/signup.dart';
import 'package:note_app_with_mongo/ui/home_views/home_view.dart';
import 'package:note_app_with_mongo/ui/profile_views/profile_view.dart';

import '../ui/add_note_views/add_note_view.dart';

class OnGenerateRoute {
  static Route<dynamic> route(RouteSettings settings) {
    // ignore: unused_local_variable
    final args = settings.arguments;

    switch (settings.name) {
      case PageConstant.loginPage:
        return materialPage(widget: const LoginPage());

      case PageConstant.signUpPage:
        {
          return materialPage(widget: const SignupPage());
        }
      case PageConstant.homePage:
        {
          return materialPage(widget: const NoteHomePage());
        }
      case PageConstant.profilePage:
        {
          if (args is String) {
            return materialPage(
                widget: ProfilePage(
              uid: args,
            ));
          } else {
            return materialPage(widget: const Error());
          }
        }
      case PageConstant.addNotePage:
        {
          return materialPage(widget: const AddNotePage());
        }
      default:
        return materialPage(widget: const Error());
    }
  }
}

MaterialPageRoute materialPage({required Widget widget}) {
  return MaterialPageRoute(builder: (_) => widget);
}

class Error extends StatelessWidget {
  const Error({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('ERROR no screen found'),
      ),
    );
  }
}
