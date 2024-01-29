import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app_with_mongo/cubit/auth/cubit/auth_cubit.dart';
import 'package:note_app_with_mongo/cubit/credential/cubit/credential_cubit.dart';
import 'package:note_app_with_mongo/models/user_model.dart';
import 'package:note_app_with_mongo/router/page_constant.dart';
import 'package:note_app_with_mongo/ui/home_views/home_view.dart';
import 'package:note_app_with_mongo/utils/elevated_button.dart';
import 'package:note_app_with_mongo/utils/mytext.dart';
import 'package:note_app_with_mongo/utils/snackbar.dart';
import 'package:note_app_with_mongo/utils/textformfield.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<CredentialCubit, CredentialState>(
        builder: (_, credState) {
          if (credState is Credentialloading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (credState is CredentialSuccess) {
            return BlocBuilder<AuthCubit, AuthState>(
              builder: (_, authState) {
                if (authState is Authenticated) {
                  return NoteHomePage(
                    uid: authState.uid,
                  );
                } else {
                  return _body();
                }
              },
            );
          } else {
            return _body();
          }
        },
        listener: (_, credState) {
          if (credState is CredentialSuccess) {
            context.read<AuthCubit>().loggedIn(credState.userModel.uid!);
            _emailController.clear();
            _passwordController.clear();
          }
          if (credState is CredentialFailure) {
            showSnackBar(credState.errorMessage, context);
          }
        },
      ),
    );
  }

  Widget _body() {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Expanded(child: SizedBox()),
              MyField(
                controller: _emailController,
                labelText: 'Email',
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              MyField(
                obscureText: true,
                controller: _passwordController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
                labelText: 'Password',
              ),
              const SizedBox(height: 20),
              MyButton(
                onPress: () {
                  // log('message');
                  // Navigator.pushNamedAndRemoveUntil(
                  //   context,
                  //   PageConstant.homePage,
                  //   (route) => false,
                  // );
                  if (_formKey.currentState!.validate()) {
                    // Navigator.pushReplacementNamed(
                    //     context, PageConstant.homePage);
                    context.read<CredentialCubit>().signIn(
                          UserModel(
                            email: _emailController.text,
                            password: _passwordController.text,
                          ),
                        );
                  }
                },
                text: "Login",
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, PageConstant.signUpPage, (route) => false);
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MyText(
                        text: 'Dont have account? ',
                        size: 16.0,
                      ),
                      MyText(
                        text: 'Sign Up ',
                        color: Colors.deepPurple,
                        size: 16.0,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
