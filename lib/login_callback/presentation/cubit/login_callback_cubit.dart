import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'login_callback_state.dart';

class LoginCallbackCubit extends Cubit<LoginCallbackState> {
  late StreamSubscription supabaseAuthStateChanges;

  LoginCallbackCubit() : super(LoginCallbackInitial()) {
    supabaseAuthStateChanges = Supabase.instance.client.auth.onAuthStateChange
        .listen((data) {
          if (data.event == AuthChangeEvent.signedIn) {
            emit(LoginSuccessState());
          }
        });
  }

  @override
  Future<void> close() {
    supabaseAuthStateChanges.cancel();
    return super.close();
  }
}
