import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../core/routes/app_router.dart';
import '../../core/utils/snackbar_util.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  final _supabaseAuth = Supabase.instance.client.auth;
  final TextEditingController emailTextController = TextEditingController(),
      passwordTextController = TextEditingController(),
      confirmPasswordTextController = TextEditingController();
  int authStatus = 0;
  bool isPasswordObscure = true, isConfirmPasswordObscure = true;

  Future<void> signIn({
    required GlobalKey<FormState> formKey,
  }) async {
    if (!_validateForm(formKey)) return;
    final context = AppRouter.navigatorKey.currentContext;
    try {
      await _supabaseAuth.signInWithPassword(
        email: emailTextController.text,
        password: passwordTextController.text,
      );
      // SnackBarUtil.showSuccessfulSnackBar(
      //     context!, AppLocalizations.of(context)!.signedInSuccessfully);
    } on AuthException catch (exception) {
      SnackBarUtil.showErrorSnackBar(context!, exception.message);
    } on SocketException catch (_) {
      SnackBarUtil.showErrorSnackBar(
          context!, AppLocalizations.of(context)!.noInternetConnection);
    } catch (exception) {
      SnackBarUtil.showErrorSnackBar(context!, exception.toString());
    } finally {
      authStatus = 0;
      emit(AuthStateChanged());
    }
  }

  Future<void> signUp({
    required GlobalKey<FormState> formKey,
  }) async {
    if (!_validateForm(formKey)) return;
    final context = AppRouter.navigatorKey.currentContext;
    try {
      await _supabaseAuth.signUp(
        email: emailTextController.text,
        password: passwordTextController.text,
        emailRedirectTo: 'myapp://auth',
      );
      SnackBarUtil.showSuccessfulSnackBar(
        context!,
        AppLocalizations.of(context)!.checkEmailForVerification,
      );
    } on AuthException catch (exception) {
      SnackBarUtil.showErrorSnackBar(context!, exception.message);
    } on SocketException catch (_) {
      SnackBarUtil.showErrorSnackBar(
          context!, AppLocalizations.of(context)!.noInternetConnection);
    } catch (exception) {
      SnackBarUtil.showErrorSnackBar(context!, exception.toString());
    } finally {
      authStatus = 0;
      emit(AuthStateChanged());
    }
  }

  Future<void> resetPassword({
    required GlobalKey<FormState> formKey,
  }) async {
    if (!_validateForm(formKey)) return;
    final context = AppRouter.navigatorKey.currentContext;
    try {
      await _supabaseAuth.resetPasswordForEmail(
        emailTextController.text,
      );
      SnackBarUtil.showSuccessfulSnackBar(
        context!,
        AppLocalizations.of(context)!.resetPasswordEmailSent,
      );
    } on AuthException catch (exception) {
      SnackBarUtil.showErrorSnackBar(context!, exception.message);
    } on SocketException catch (_) {
      SnackBarUtil.showErrorSnackBar(
          context!, AppLocalizations.of(context)!.noInternetConnection);
    } catch (exception) {
      SnackBarUtil.showErrorSnackBar(context!, exception.toString());
    } finally {
      authStatus = 0;
      emit(AuthStateChanged());
    }
  }

  Future<void> googleOAuth() async {
    await _supabaseAuth.signInWithOAuth(OAuthProvider.google,
        redirectTo: kIsWeb ? 'http://localhost:5555/' : 'myapp://auth');
  }

  Future<void> signOut() async => await _supabaseAuth.signOut();

  void togglePasswordObscure() {
    isPasswordObscure = !isPasswordObscure;
    emit(AuthStateChanged());
  }

  void toggleConfirmPasswordObscure() {
    isConfirmPasswordObscure = !isConfirmPasswordObscure;
    emit(AuthStateChanged());
  }

// ---------------------------------- Authentication Helpers ---------------------------------- //
  bool _validateForm(GlobalKey<FormState> formKey) {
    if (!formKey.currentState!.validate()) {
      authStatus = 0;
      emit(AuthStateChanged());
      return false;
    }

    formKey.currentState!.save();
    authStatus = 1;
    emit(AuthStateChanged());
    return true;
  }

// ---------------------------------- Authentication Validators ---------------------------------- //
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
    final BuildContext? context = AppRouter.navigatorKey.currentContext;
    if (value != passwordTextController.text) {
      return AppLocalizations.of(context!)!.passwordsDoNotMatch;
    }
    return null;
  }
}
