import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:e_commerce/auth/screens/reset_password_screen.dart';
import 'package:e_commerce/auth/screens/sign_in_screen.dart';
import 'package:e_commerce/auth/screens/sign_up_screen.dart';
import 'package:e_commerce/core/utils/snackbar_util.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uni_links/uni_links.dart';

import '../../home/screens/home_screen.dart';

part 'auth_state.dart';

//TODO: imp(1) - Error: AuthException(message: Code verifier could not be found in local storage., statusCode: null)
//TODO: imp(3) - add reCAPTCHA to the auth

class AuthCubit extends Cubit<AuthCubitState> {
  final _supabaseAuth = Supabase.instance.client.auth;
  late final StreamSubscription<Uri?> deepLinksListener;
  AuthCubit() : super(AuthInitial());
  bool isObscure = true;
  // 0 -> InitialState , 1 -> loading
  int authStatus = 0;
  Future<void> submitAuthentication(
      {required BuildContext context,
      required GlobalKey<FormState> formKey,
      required TextEditingController emailTextController,
      TextEditingController? passwordTextController,
      required String screen}) async {
    authStatus = 1;
    emit(AuthStateChanged());
    if (!formKey.currentState!.validate()) {
      authStatus = 0;
      emit(AuthStateChanged());
      return;
    }
    formKey.currentState!.save();
    try {
      switch (screen) {
        case SignInScreen.id:
          await _supabaseAuth.signInWithPassword(
              password: passwordTextController!.text,
              email: emailTextController.text);
        case SignUpScreen.id:
          await _supabaseAuth.signUp(
              password: passwordTextController!.text,
              email: emailTextController.text,
              emailRedirectTo: 'myapp://auth');
          SnackBarUtil.showSuccessfulSnackBar(
              context, 'Check your email messages');
          break;
        case ResetPasswordScreen.id:
          await _supabaseAuth.resetPasswordForEmail(
              //TODO: imp(2) - redirect user to reset the password
              emailTextController.text);
          SnackBarUtil.showSuccessfulSnackBar(
              context, 'Check your email messages');
      }
    } catch (exception) {
      //TODO: imp(1) - if(exception.toString() == AuthException(404))
      SnackBarUtil.showErrorSnackBar(context, exception.toString());
      return;
    } finally {
      authStatus = 0;
      emit(AuthStateChanged());
    }
  }

  Future<void> googleOAuth() async {
    await _supabaseAuth.signInWithOAuth(OAuthProvider.google,
        redirectTo: 'myapp://auth');
  }

  void handleIncomingLinks(BuildContext context) {
    deepLinksListener = uriLinkStream.listen(
      (Uri? uri) {
        if (uri != null) {
          Navigator.of(context)
              .pushNamedAndRemoveUntil(HomeScreen.id, (route) => false);
        }
      },
    );
  }

  void toggleObscure() {
    isObscure = !isObscure;
    emit(AuthStateChanged());
  }

  static String? passwordValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Password is required';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }
    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return 'Password must contain at least one uppercase letter';
    }
    if (!RegExp(r'[a-z]').hasMatch(value)) {
      return 'Password must contain at least one lowercase letter';
    }
    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return 'Password must contain at least one number';
    }
    return null;
  }

  static String? emailValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email address is required';
    }
    if (!RegExp(
            r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.(com|org|net|edu|gov|io|us)$")
        .hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  @override
  Future<void> close() {
    deepLinksListener.cancel();
    return super.close();
  }
}
