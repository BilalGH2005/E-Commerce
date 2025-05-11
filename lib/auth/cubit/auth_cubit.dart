import 'dart:async';
import 'dart:io';

import 'package:app_links/app_links.dart';
import 'package:e_commerce/app/cubit/app_cubit.dart';
import 'package:e_commerce/core/constants/app_links.dart';
import 'package:e_commerce/core/constants/screens_names.dart';
import 'package:e_commerce/core/router/app_router.dart';
import 'package:e_commerce/core/utils/localization.dart';
import 'package:e_commerce/core/utils/snackbar_util.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthStateCubit> {
  AuthCubit() : super(AuthInitial());

  final _supabaseAuth = Supabase.instance.client.auth;
  late final StreamSubscription<AuthState> _authListener;
  late final StreamSubscription<Uri?> _uriListener;
  final TextEditingController emailTextController = TextEditingController(),
      passwordTextController = TextEditingController(),
      confirmPasswordTextController = TextEditingController();
  int authStatus = 0;
  bool isPasswordObscure = true,
      isConfirmPasswordObscure = true,
      isSignIn = true;

  StreamSubscription<AuthState> addAuthEventsListener() =>
      _authListener = _supabaseAuth.onAuthStateChange.listen(
        (data) {
          final context = rootNavigatorKey.currentContext;
          switch (data.event) {
            case AuthChangeEvent.signedIn:
              if (!context!.read<AppCubit>().seenGettingStarted) {
                context.goNamed(ScreensNames.gettingStarted);
              } else {
                context.goNamed(ScreensNames.home);
              }
              break;
            case AuthChangeEvent.signedOut:
              context!.goNamed(ScreensNames.auth);
              break;
            case AuthChangeEvent.passwordRecovery:
              context!.goNamed(ScreensNames.resetPasswordForm);
              break;
            default:
              break;
          }
        },
      );

  StreamSubscription<Uri?> addUriListener() =>
      _uriListener = AppLinks().uriLinkStream.listen((uri) {
        // GoRouter.redirect and supabase handles the redirection
      });

  void toggleAuth(BuildContext context) {
    isSignIn = !isSignIn;
    emit(AuthStateChanged());
  }

  Future<void> signIn({
    required BuildContext context,
    required GlobalKey<FormState> formKey,
  }) async {
    if (!_validateForm(formKey)) return;
    try {
      await _supabaseAuth.signInWithPassword(
        email: emailTextController.text,
        password: passwordTextController.text,
      );
    } on AuthException catch (exception) {
      SnackBarUtil.showErrorSnackBar(context, exception.message);
    } on SocketException catch (_) {
      SnackBarUtil.showErrorSnackBar(
          context, localization(context).noInternetConnection);
    } catch (exception) {
      SnackBarUtil.showErrorSnackBar(context, exception.toString());
    } finally {
      authStatus = 0;
      emit(AuthStateChanged());
    }
  }

  Future<void> signUp({
    required BuildContext context,
    required GlobalKey<FormState> formKey,
  }) async {
    if (!_validateForm(formKey)) return;
    try {
      await _supabaseAuth.signUp(
        email: emailTextController.text,
        password: passwordTextController.text,
        emailRedirectTo:
            kIsWeb ? AppDeepLinks.webRedirectLink : AppDeepLinks.mobileDeeplink,
      );
      SnackBarUtil.showSuccessfulSnackBar(
        context,
        localization(context).checkEmailForVerification,
      );
    } on AuthException catch (exception) {
      SnackBarUtil.showErrorSnackBar(context, exception.message);
    } on SocketException catch (_) {
      SnackBarUtil.showErrorSnackBar(
          context, localization(context).noInternetConnection);
    } catch (exception) {
      SnackBarUtil.showErrorSnackBar(context, exception.toString());
    } finally {
      authStatus = 0;
      emit(AuthStateChanged());
    }
  }

  Future<void> resetPassword({
    required BuildContext context,
    required GlobalKey<FormState> formKey,
  }) async {
    if (!_validateForm(formKey)) return;
    try {
      await _supabaseAuth.resetPasswordForEmail(emailTextController.text,
          redirectTo: kIsWeb
              ? AppDeepLinks.webRedirectLink
              : AppDeepLinks.mobileDeeplink);
      SnackBarUtil.showSuccessfulSnackBar(
        context,
        localization(context).resetPasswordEmailSent,
      );
    } on AuthException catch (exception) {
      SnackBarUtil.showErrorSnackBar(context, exception.message);
    } on SocketException catch (_) {
      SnackBarUtil.showErrorSnackBar(
          context, localization(context).noInternetConnection);
    } catch (exception) {
      SnackBarUtil.showErrorSnackBar(context, exception.toString());
    } finally {
      authStatus = 0;
      emit(AuthStateChanged());
    }
  }

  Future<void> googleOAuth() async {
    await _supabaseAuth.signInWithOAuth(
      OAuthProvider.google,
      redirectTo:
          kIsWeb ? AppDeepLinks.webRedirectLink : AppDeepLinks.mobileDeeplink,
      authScreenLaunchMode:
          kIsWeb ? LaunchMode.platformDefault : LaunchMode.externalApplication,
    );
  }

  Future<void> signOut() async {
    await _supabaseAuth.signOut();
  }

  void togglePasswordObscure() {
    isPasswordObscure = !isPasswordObscure;
    emit(AuthStateChanged());
  }

  void toggleConfirmPasswordObscure() {
    isConfirmPasswordObscure = !isConfirmPasswordObscure;
    emit(AuthStateChanged());
  }

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

  static String? passwordValidator(
      {required BuildContext context, String? value}) {
    if (value == null || value.trim().isEmpty) {
      return localization(context).passwordRequired;
    }
    if (value.length < 8) {
      return localization(context).passwordLength;
    }
    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return localization(context).passwordUppercase;
    }
    if (!RegExp(r'[a-z]').hasMatch(value)) {
      return localization(context).passwordLowercase;
    }
    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return localization(context).passwordNumber;
    }
    return null;
  }

  static String? emailValidator(
      {required BuildContext context, String? value}) {
    if (value == null || value.trim().isEmpty) {
      return localization(context).emailRequired;
    }
    if (!RegExp(
            r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.(com|org|net|edu|gov|io|us)$")
        .hasMatch(value)) {
      return localization(context).emailInvalid;
    }
    return null;
  }

  static String? confirmPasswordValidator(
      {required BuildContext context,
      required String? value,
      required TextEditingController passwordTextController}) {
    if (value != passwordTextController.text) {
      return localization(context).passwordsDoNotMatch;
    }
    return null;
  }

  @override
  Future<void> close() {
    _authListener.cancel();
    _uriListener.cancel();
    return super.close();
  }
}
