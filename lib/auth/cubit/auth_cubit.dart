import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:e_commerce/auth/data/repos/auth_repo.dart';
import 'package:e_commerce/core/utils/localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../core/constants/app_routes.dart';
import '../../core/cubit/app_cubit.dart';
import '../../core/router/app_router.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthCubitState> {
  final AuthRepo authRepo;

  AuthCubit(this.authRepo) : super(AuthInitial()) {
    _addAuthEventsListener();
    _addUriListener();
  }

  late final StreamSubscription<AuthState> _authListener;
  late final StreamSubscription<Uri?> _uriListener;
  final signInFormKey = GlobalKey<FormState>();
  final signUpFormKey = GlobalKey<FormState>();
  final forgetPasswordFormKey = GlobalKey<FormState>();
  final resetPasswordFormKey = GlobalKey<FormState>();
  final emailFieldController = TextEditingController();
  final passwordFieldController = TextEditingController();
  final confirmPasswordFieldController = TextEditingController();
  bool isLoading = false;

  StreamSubscription<AuthState> _addAuthEventsListener() =>
      _authListener = Supabase.instance.client.auth.onAuthStateChange.listen(
        (data) {
          final context = navigatorKey.currentContext;
          switch (data.event) {
            case AuthChangeEvent.signedIn:
              if (!context!.read<AppCubit>().seenGettingStarted) {
                context.goNamed(AppRoutes.gettingStarted.name);
              } else {
                context.goNamed(AppRoutes.home.name);
              }
              break;
            case AuthChangeEvent.signedOut:
              context!.goNamed(AppRoutes.auth.name);
              break;
            case AuthChangeEvent.passwordRecovery:
              context!.goNamed(AppRoutes.resetPassword.name, extra: this);
              break;
            default:
              break;
          }
        },
      );

  StreamSubscription<Uri?> _addUriListener() =>
      _uriListener = AppLinks().uriLinkStream.listen((uri) {
        // GoRouter.redirect and supabase handles the redirection
      });

  bool isSignIn = true;

  void toggleAuth() {
    isSignIn = !isSignIn;
    emit(AuthFormChanged());
  }

  Future<void> signInWithPassword() async {
    if (!signInFormKey.currentState!.validate()) return;
    isLoading = true;
    emit(AuthLoading());

    final result = await authRepo.signInWithPassword(
      email: emailFieldController.text.trim(),
      password: passwordFieldController.text.trim(),
    );

    isLoading = false;

    if (result.isData) {
      emit(AuthSuccessSignIn());
    } else {
      emit(AuthFailure(errorCode: result.error!));
    }
  }

  Future<void> signUp() async {
    if (!signUpFormKey.currentState!.validate()) return;
    isLoading = true;
    emit(AuthLoading());

    final result = await authRepo.signUp(
        email: emailFieldController.text.trim(),
        password: passwordFieldController.text.trim());

    isLoading = false;

    if (result.isData) {
      emit(AuthSuccessSignUp());
    } else {
      emit(AuthFailure(errorCode: result.error!));
    }
  }

  Future<void> resetPasswordForEmail() async {
    if (!forgetPasswordFormKey.currentState!.validate()) return;
    isLoading = true;
    emit(AuthLoading());

    final result = await authRepo.resetPasswordForEmail(
      email: emailFieldController.text.trim(),
    );

    isLoading = false;

    if (result.isData) {
      emit(AuthResetPasswordRequested());
    } else {
      emit(AuthFailure(errorCode: result.error!));
    }
  }

  Future<void> googleSignIn() async {
    final result = await authRepo.googleSignIn();

    if (result.isData) {
      emit(AuthSuccessSignIn());
    } else {
      emit(AuthFailure(errorCode: result.error!));
    }
  }

  Future<void> updateUserPassword() async {
    if (!resetPasswordFormKey.currentState!.validate()) return;

    isLoading = true;
    emit(AuthLoading());

    final result = await authRepo.updateUserPassword(
        newPassword: passwordFieldController.text.trim());

    isLoading = false;

    if (result.isData) {
      emit(AuthResetPasswordSuccess());
    } else {
      emit(AuthFailure(errorCode: result.error!));
    }
  }

  bool isPasswordFieldObscure = true;

  void togglePasswordObscure() {
    isPasswordFieldObscure = !isPasswordFieldObscure;
    emit(AuthFormChanged());
  }

  bool isConfirmPasswordObscure = true;

  void toggleConfirmPasswordFieldObscure() {
    isConfirmPasswordObscure = !isConfirmPasswordObscure;
    emit(AuthFormChanged());
  }

// ---------------------------------- Validators ---------------------------------- //
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

  String? confirmPasswordValidator({
    required BuildContext context,
    required String? value,
  }) {
    if (value != passwordFieldController.text) {
      return localization(context).passwordsDoNotMatch;
    }
    return null;
  }

  @override
  Future<void> close() {
    emailFieldController.dispose();
    passwordFieldController.dispose();
    confirmPasswordFieldController.dispose();
    _authListener.cancel();
    _uriListener.cancel();
    return super.close();
  }
}
