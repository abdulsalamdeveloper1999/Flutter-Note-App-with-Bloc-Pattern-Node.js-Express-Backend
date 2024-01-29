import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app_with_mongo/cubit/user/user_cubit.dart';
import 'package:note_app_with_mongo/models/user_model.dart';
import 'package:note_app_with_mongo/utils/elevated_button.dart';
import 'package:note_app_with_mongo/utils/snackbar.dart';

import 'package:note_app_with_mongo/utils/textformfield.dart';

class ProfilePage extends StatefulWidget {
  final String uid;
  const ProfilePage({super.key, required this.uid});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  void initState() {
    context.read<UserCubit>().getprofile(UserModel(uid: widget.uid));
    super.initState();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
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
        title: const Text('Update Profile'),
      ),
      body: BlocBuilder<UserCubit, UserState>(
        builder: (context, state) {
          if (state is UserLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is UserSuccess) {
            updateFields(state.userModel);

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MyField(
                    labelText: 'Username',
                    controller: _usernameController,
                  ),
                  const SizedBox(height: 20),
                  MyField(
                    labelText: 'Email',
                    controller: _emailController,
                  ),
                  const SizedBox(height: 20),
                  MyButton(
                      text: 'Update',
                      onPress: () {
                        updateProfile(state.userModel);
                      })
                ],
              ),
            );
          }
          return const Text(' no state');
        },
      ),
    );
  }

  void updateFields(UserModel userModel) {
    _usernameController.value = TextEditingValue(text: userModel.username!);
    _emailController.value = TextEditingValue(text: userModel.email!);
  }

  void updateProfile(UserModel user) {
    if (_usernameController.text.isNotEmpty) {
      context
          .read<UserCubit>()
          .updateProfile(
            UserModel(
              uid: widget.uid,
              username: _usernameController.text,
            ),
          )
          .then((value) {
        showSnackBar('Username updated', context);
      });
    } else {
      showSnackBar('username is required', context);
    }
  }
}
