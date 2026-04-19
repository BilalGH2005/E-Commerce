import 'dart:async';

import 'package:e_commerce/auth/data/repos/auth_repo.dart';
import 'package:e_commerce/core/constants/app_links.dart';
import 'package:e_commerce/core/models/webview_page_args.dart';
import 'package:e_commerce/core/utils/shortcuts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_routes.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepo _authRepo;

  AuthCubit(AuthRepo authRepo) : _authRepo = authRepo, super(AuthInitial());

  late final StreamSubscription<AuthState> _authListener;
  late final StreamSubscription<Uri?> _uriListener;
  final signInFormKey = GlobalKey<FormState>();
  final signUpFormKey = GlobalKey<FormState>();
  final forgetPasswordFormKey = GlobalKey<FormState>();
  final resetPasswordFormKey = GlobalKey<FormState>();
  final emailFieldController = TextEditingController();
  final nameFieldController = TextEditingController();
  final passwordFieldController = TextEditingController();
  final confirmPasswordFieldController = TextEditingController();
  bool isLoading = false;
  bool isSignIn = true;
  bool showPoliciesError = false;

  void toggleAuth() {
    isSignIn = !isSignIn;
    emailFieldController.clear();
    nameFieldController.clear();
    passwordFieldController.clear();
    confirmPasswordFieldController.clear();
    emit(AuthFormChanged());
  }

  void navigateToForgotPasswordScreen(BuildContext context) {
    context.pushNamed(AppRoutes.forgetPassword.name);
    emailFieldController.clear();
    nameFieldController.clear();
  }

  Future<void> signInWithPassword() async {
    if (!signInFormKey.currentState!.validate()) return;
    isLoading = true;
    emit(AuthLoading());

    final result = await _authRepo.signInWithPassword(
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
    final isFormValid = signUpFormKey.currentState!.validate();

    showPoliciesError = !isPoliciesAccepted;

    emit(AuthFormChanged());

    if (!isFormValid || !isPoliciesAccepted) return;
    isLoading = true;
    emit(AuthLoading());

    final result = await _authRepo.signUp(
      email: emailFieldController.text.trim(),
      password: passwordFieldController.text.trim(),
      userName: nameFieldController.text.trim(),
    );

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

    final result = await _authRepo.resetPasswordForEmail(
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
    final result = await _authRepo.googleSignIn();

    if (result.isData) {
      emit(AuthSuccessSignIn());
    } else {
      emit(AuthFailure(errorCode: result.error!));
    }
  }

  Future<void> updateUserPassword(BuildContext context) async {
    if (!resetPasswordFormKey.currentState!.validate()) return;

    isLoading = true;
    emit(AuthLoading());

    final result = await _authRepo.updateUserPassword(
      newPassword: passwordFieldController.text.trim(),
    );

    isLoading = false;

    if (result.isData) {
      emit(AuthResetPasswordSuccess());
      context.goNamed(AppRoutes.home.name);
    } else {
      emit(AuthFailure(errorCode: result.error!));
    }
  }

  bool isPasswordFieldObscure = true;

  void togglePasswordObscure() {
    isPasswordFieldObscure = !isPasswordFieldObscure;
    emit(AuthFormChanged());
  }

  bool isPoliciesAccepted = false;

  void togglePoliciesAccepted() {
    isPoliciesAccepted = !isPoliciesAccepted;
    if (isPoliciesAccepted) {
      showPoliciesError = false;
    }
    emit(AuthFormChanged());
  }

  bool isConfirmPasswordObscure = true;

  void toggleConfirmPasswordFieldObscure() {
    isConfirmPasswordObscure = !isConfirmPasswordObscure;
    emit(AuthFormChanged());
  }

  void launchTerms(BuildContext context, String locale) {
    context.pushNamed(
      AppRoutes.webview.name,
      extra: WebViewPageArgs(
        url: AppLinks.termsOfServiceLink(locale),
        title: localization(context).termsOfService,
      ),
    );
  }

  void launchPrivacy(BuildContext context, String locale) {
    context.pushNamed(
      AppRoutes.webview.name,
      extra: WebViewPageArgs(
        url: AppLinks.privacyPolicyLink(locale),
        title: localization(context).privacyPolicy,
      ),
    );
  }

  // ---------------------------------- Validators ---------------------------------- //
  static String? emailValidator({
    required BuildContext context,
    String? value,
  }) {
    if (value == null || value.trim().isEmpty) {
      return localization(context).emailRequired;
    }
    if (!RegExp(
      r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.(com|org|net|edu|gov|io|us)$",
    ).hasMatch(value)) {
      return localization(context).emailInvalid;
    }
    return null;
  }

  static String? passwordValidator({
    required BuildContext context,
    String? value,
  }) {
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

  static String? userNameValidator({
    required BuildContext context,
    String? value,
  }) {
    if (value == null || value.trim().isEmpty) {
      return localization(context).nameRequired;
    }
    return null;
  }

  @override
  Future<void> close() {
    emailFieldController.dispose();
    nameFieldController.dispose();
    passwordFieldController.dispose();
    confirmPasswordFieldController.dispose();
    _authListener.cancel();
    _uriListener.cancel();
    return super.close();
  }
}
