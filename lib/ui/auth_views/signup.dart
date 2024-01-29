import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app_with_mongo/cubit/auth/cubit/auth_cubit.dart';
import 'package:note_app_with_mongo/cubit/credential/cubit/credential_cubit.dart';
import 'package:note_app_with_mongo/models/user_model.dart';
import 'package:note_app_with_mongo/ui/home_views/home_view.dart';
import 'package:note_app_with_mongo/utils/elevated_button.dart';
import 'package:note_app_with_mongo/utils/snackbar.dart';

import '../../router/page_constant.dart';
import '../../utils/mytext.dart';
import '../../utils/textformfield.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();

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
              builder: (_, authSatte) {
                if (authSatte is Authenticated) {
                  return NoteHomePage(uid: authSatte.uid);
                } else {
                  return _body(context);
                }
              },
            );
          } else {
            return _body(context);
          }
        },
        listener: (BuildContext context, CredentialState state) {
          if (state is CredentialSuccess) {
            context.read<AuthCubit>().loggedIn(state.userModel.uid!);
            _emailController.clear();
            _passwordController.clear();
            _userNameController.clear();
            // Navigator.pushReplacement(
            //   context,
            //   MaterialPageRoute(
            //     builder: (_) => NoteHomePage(
            //       uid: state.userModel.uid,
            //     ),
            //   ),
            // );
          }

          if (state is CredentialFailure) {
            log(state.errorMessage);
            showSnackBar(state.errorMessage, context);
          }
        },
      ),
    );
  }

  Widget _body(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up Page'),
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
                controller: _userNameController,
                labelText: 'Username',
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your user name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
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
                  if (_formKey.currentState!.validate()) {
                    context.read<CredentialCubit>().signUp(
                          UserModel(
                            email: _emailController.text,
                            password: _passwordController.text,
                            username: _userNameController.text,
                          ),
                        );
                  }
                },
                text: 'Sign Up',
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, PageConstant.loginPage, (route) => false);
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MyText(
                        text: 'Dont have account? ',
                        size: 16.0,
                      ),
                      MyText(
                        text: 'Login',
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
