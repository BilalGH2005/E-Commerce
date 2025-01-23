import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloudflare_turnstile/cloudflare_turnstile.dart';
import 'package:e_commerce/auth/screens/reset_password_screen.dart';
import 'package:e_commerce/auth/screens/sign_in_screen.dart';
import 'package:e_commerce/auth/screens/sign_up_screen.dart';
import 'package:e_commerce/core/utils/snackbar_util.dart';
import 'package:e_commerce/core/utils/svg_util.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'auth_state.dart';

//TODO: imp(3) - add reCAPTCHA to the auth

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial()) {
    print('AuthCubit instantiated');
    SvgUtil.preLoadSvgImages([
      'assets/images/apple_icon.svg',
      'assets/images/facebook_icon.svg',
      'assets/images/google_icon.svg'
    ]);
  }
  final _supabaseAuth = Supabase.instance.client.auth;
  final TextEditingController emailTextController = TextEditingController(),
      passwordTextController = TextEditingController(),
      confirmPasswordTextController = TextEditingController();
  int authStatus = 0;
  bool isPasswordObscure = true, isConfirmPasswordObscure = true;

  Future<void> formsAuthentication(
      {required BuildContext context,
      required GlobalKey<FormState> formKey,
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
        case SignInScreen.name:
          await _supabaseAuth.signInWithPassword(
              password: passwordTextController.text,
              email: emailTextController.text);
        case SignUpScreen.name:
          await _supabaseAuth.signUp(
              password: passwordTextController.text,
              email: emailTextController.text,
              emailRedirectTo: 'myapp://auth');
          SnackBarUtil.showSuccessfulSnackBar(
              context, 'Check your email messages');
          break;
        case ResetPasswordScreen.name:
          await _supabaseAuth.resetPasswordForEmail(
              //TODO: imp(2) - redirect user to reset the password
              emailTextController.text);
          SnackBarUtil.showSuccessfulSnackBar(
              context, 'Check your email messages');
      }
    } on AuthException catch (exception) {
      SnackBarUtil.showErrorSnackBar(context, exception.message);
    } finally {
      authStatus = 0;
      emit(AuthStateChanged());
    }
  }

  Future<void> googleOAuth() async => await _supabaseAuth
      .signInWithOAuth(OAuthProvider.google, redirectTo: 'myapp://auth');

  Future<void> signOut() async => await _supabaseAuth.signOut();

  void togglePasswordObscure() {
    isPasswordObscure = !isPasswordObscure;
    emit(AuthStateChanged());
  }

  void toggleConfirmPasswordObscure() {
    isConfirmPasswordObscure = !isConfirmPasswordObscure;
    emit(AuthStateChanged());
  }

  Future<String?> get token async {
    final turnstile = CloudflareTurnstile.invisible(
      siteKey: '1x00000000000000000000BB',
    );
    try {
      final token = await turnstile.getToken();
      return token;
    } on TurnstileException catch (e) {
      print('Challenge failed: ${e.message}');
    } finally {
      turnstile.dispose();
    }
    return null;
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

  static String? confirmPasswordValidator(
      {required String? value,
      required TextEditingController passwordTextController}) {
    if (value != passwordTextController.text) {
      return 'Passwords do not match';
    }
    return null;
  }
}
