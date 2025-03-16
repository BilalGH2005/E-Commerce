import 'dart:async';

import 'package:e_commerce/core/utils/screens_names.dart';
import 'package:e_commerce/core/utils/snackbar_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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

  Future<void> authentication(
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
          SnackBarUtil.showSuccessfulSnackBar(context!,
              AppLocalizations.of(context)!.checkEmailForVerification);
          break;
        case ScreensNames.resetPassword:
          await _supabaseAuth.resetPasswordForEmail(
              // captchaToken: token,
              //TOD0: imp(1) - redirect user to reset the password
              emailTextController.text);
          SnackBarUtil.showSuccessfulSnackBar(
              context!, AppLocalizations.of(context)!.resetPasswordEmailSent);
      }
    } on AuthException catch (exception) {
      SnackBarUtil.showErrorSnackBar(context!, exception.message);
    }
    // on TurnstileException catch (exception) {
    //   SnackBarUtil.showErrorSnackBar(context, exception.message);
    // }
    catch (exception) {
      SnackBarUtil.showErrorSnackBar(context!, exception.toString());
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
    final BuildContext? context = AppRouter.navigatorKey.currentContext;
    if (value == null || value.trim().isEmpty) {
      return AppLocalizations.of(context!)!.passwordRequired;
    }
    if (value.length < 8) {
      return AppLocalizations.of(context!)!.passwordLength;
    }
    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return AppLocalizations.of(context!)!.passwordUppercase;
    }
    if (!RegExp(r'[a-z]').hasMatch(value)) {
      return AppLocalizations.of(context!)!.passwordLowercase;
    }
    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return AppLocalizations.of(context!)!.passwordNumber;
    }
    return null;
  }

  static String? emailValidator(String? value) {
    final BuildContext? context = AppRouter.navigatorKey.currentContext;
    if (value == null || value.trim().isEmpty) {
      return AppLocalizations.of(context!)!.emailRequired;
    }
    if (!RegExp(
            r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.(com|org|net|edu|gov|io|us)$")
        .hasMatch(value)) {
      return AppLocalizations.of(context!)!.emailInvalid;
    }
    return null;
  }

  static String? confirmPasswordValidator(
      {required String? value,
      required TextEditingController passwordTextController}) {
    if (value != passwordTextController.text) {
      final BuildContext? context = AppRouter.navigatorKey.currentContext;
      return AppLocalizations.of(context!)!.passwordsDoNotMatch;
    }
    return null;
  }
}
