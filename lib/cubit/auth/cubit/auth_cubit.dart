import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app_with_mongo/utils/shared_pref.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final sharedPref = SharedPref();

  AuthCubit() : super(AuthInitial());

  Future<void> appStarted() async {
    try {
      final uid = await sharedPref.getUid();
      if (uid != null) {
        emit(Authenticated(uid: uid));
      } else {
        emit(UnAuthenticated());
      }
    } catch (e) {
      emit(UnAuthenticated());
    }
  }

  Future<void> loggedIn(String uid) async {
    sharedPref.setUid(uid);
    emit(Authenticated(uid: uid));
  }

  Future<void> loggedOut() async {
    sharedPref.setUid('');
    // emit(const Authenticated(uid: ''));
    emit(UnAuthenticated());
  }
}
