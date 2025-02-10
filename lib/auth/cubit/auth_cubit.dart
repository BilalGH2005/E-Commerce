import 'dart:async';

import 'package:e_commerce/core/utils/constants/screens_names.dart';
import 'package:e_commerce/core/utils/snackbar_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../core/routes/app_router.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  final _supabaseAuth = Supabase.instance.client.auth;
  final TextEditingController emailTextController = TextEditingController(),
      passwordTextController = TextEditingController(),
      confirmPasswordTextController = TextEditingController();
  int authStatus = 0;
  bool isPasswordObscure = true, isConfirmPasswordObscure = true;

  Future<void> formsAuthentication(
      {required GlobalKey<FormState> formKey, required String screen}) async {
    authStatus = 1;
    emit(AuthStateChanged());
    if (!formKey.currentState!.validate()) {
      authStatus = 0;
      emit(AuthStateChanged());
      return;
    }
    formKey.currentState!.save();
    //TOD0: imp(3) - make a web-view and a domain for captcha
    // final turnstile = CloudflareTurnstile.invisible(
    //     siteKey:
    //     dotenv.env['TURNSTILE_SITE_KEY']!);
    final BuildContext? context = AppRouter.navigatorKey.currentContext;
    if (context == null) return;
    try {
      // final token = await turnstile.getToken();
      // print(token);
      switch (screen) {
        case ScreensNames.signIn:
          await _supabaseAuth.signInWithPassword(
              // captchaToken: token,
              password: passwordTextController.text,
              email: emailTextController.text);
        case ScreensNames.signUp:
          await _supabaseAuth.signUp(
              // captchaToken: token,
              email: emailTextController.text,
              password: passwordTextController.text,
              emailRedirectTo: 'myapp://auth');
          SnackBarUtil.showSuccessfulSnackBar(
              context, 'Check your email for verification.');
          break;
        case ScreensNames.resetPassword:
          await _supabaseAuth.resetPasswordForEmail(
              // captchaToken: token,
              //TOD0: imp(1) - redirect user to reset the password
              emailTextController.text);
          SnackBarUtil.showSuccessfulSnackBar(context,
              'If this email is registered, you will receive a reset link.');
      }
    } on AuthException catch (exception) {
      SnackBarUtil.showErrorSnackBar(context, exception.message);
    }
    // on TurnstileException catch (exception) {
    //   SnackBarUtil.showErrorSnackBar(context, exception.message);
    // }
    catch (exception) {
      SnackBarUtil.showErrorSnackBar(context, exception.toString());
    } finally {
      authStatus = 0;
      emit(AuthStateChanged());
      // turnstile.dispose();
    }
  }

  Future<void> googleOAuth() async => await _supabaseAuth
      .signInWithOAuth(OAuthProvider.google, redirectTo: 'myapp://auth');

  Future<void> signOut() async => await _supabaseAuth.signOut();

  void togglePasswordObscure(String? fieldName) {
    if (fieldName == 'password') {
      isPasswordObscure = !isPasswordObscure;
    } else if (fieldName == 'confirmPassword') {
      isConfirmPasswordObscure = !isConfirmPasswordObscure;
    }
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

  static String? confirmPasswordValidator(
      {required String? value,
      required TextEditingController passwordTextController}) {
    if (value != passwordTextController.text) {
      return 'Passwords do not match';
    }
    return null;
  }
}
