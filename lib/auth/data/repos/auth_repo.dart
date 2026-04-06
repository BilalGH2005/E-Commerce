import 'dart:io';

import 'package:e_commerce/core/utils/auth_failure_mapper.dart';
import 'package:flutter_async_value/flutter_async_value.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/constants/app_links.dart';

abstract class AuthRepo {
  Future<AsyncResult<void, String>> signInWithPassword({
    required String email,
    required String password,
  });

  Future<AsyncResult<void, String>> signUp({
    required String email,
    required String password,
    String? userName,
  });

  Future<AsyncResult<void, String>> resetPasswordForEmail({
    required String email,
  });

  Future<AsyncResult<void, String>> googleSignIn();

  Future<AsyncResult<void, String>> signOut();

  Future<AsyncResult<void, String>> updateUserPassword({
    required String newPassword,
  });
}

class SupabaseAuthRepo implements AuthRepo {
  final _supabaseAuth = Supabase.instance.client.auth;
  final _googleSignIn = GoogleSignIn.instance;
  bool _isGoogleSignInInitialized = false;

  @override
  Future<AsyncResult<void, String>> signInWithPassword({
    required String email,
    required String password,
  }) async {
    try {
      await _supabaseAuth.signInWithPassword(email: email, password: password);
      return const AsyncResult.data(data: null);
    } on SocketException catch (_) {
      return AsyncResult.error(error: 'noInternetConnection');
    } on AuthException catch (exception) {
      return AsyncResult.error(
        error: AuthFailureMapper.supabaseAuthError(exception.code),
      );
    } catch (exception) {
      return AsyncResult.error(error: 'other');
    }
  }

  @override
  Future<AsyncResult<void, String>> signUp({
    required String email,
    required String password,
    String? userName,
  }) async {
    try {
      await _supabaseAuth.signUp(
        email: email,
        password: password,
        data: {'display_name': userName},
        emailRedirectTo: AppLinks.signUpRedirectDeepLink,
      );
      return const AsyncResult.data(data: null);
    } on AuthException catch (exception) {
      return AsyncResult.error(
        error: AuthFailureMapper.supabaseAuthError(exception.code),
      );
    } on SocketException catch (_) {
      return AsyncResult.error(error: 'noInternetConnection');
    } catch (_) {
      return AsyncResult.error(error: 'other');
    }
  }

  @override
  Future<AsyncResult<void, String>> resetPasswordForEmail({
    required String email,
  }) async {
    try {
      await _supabaseAuth.resetPasswordForEmail(
        email,
        redirectTo: AppLinks.resetPasswordDeepLink,
      );
      return const AsyncResult.data(data: null);
    } on AuthException catch (exception) {
      return AsyncResult.error(
        error: AuthFailureMapper.supabaseAuthError(exception.code),
      );
    } on SocketException catch (_) {
      return AsyncResult.error(error: 'noInternetConnection');
    } catch (_) {
      return AsyncResult.error(error: 'other');
    }
  }

  Future<void> _ensureGoogleSignInInitialized() async {
    if (_isGoogleSignInInitialized) return;

    final webClientId = dotenv.env['GOOGLE_OAUTH_WEB_CLIENT_ID']!;
    final iosClientId = dotenv.env['GOOGLE_OAUTH_IOS_CLIENT_ID']!;

    await _googleSignIn.initialize(
      clientId: Platform.isIOS ? iosClientId : null,
      serverClientId: webClientId,
    );

    _isGoogleSignInInitialized = true;
  }

  @override
  Future<AsyncResult<void, String>> googleSignIn() async {
    try {
      await _ensureGoogleSignInInitialized();

      final googleUser = await _googleSignIn.authenticate(scopeHint: ['email']);
      final idToken = googleUser.authentication.idToken;

      if (idToken == null) {
        throw Exception('Missing Google credentials');
      }

      await Supabase.instance.client.auth.signInWithIdToken(
        provider: OAuthProvider.google,
        idToken: idToken,
      );

      return const AsyncResult.data(data: null);
    } on AuthException catch (exception) {
      return AsyncResult.error(
        error: AuthFailureMapper.supabaseAuthError(exception.code),
      );
    } on SocketException catch (_) {
      return AsyncResult.error(error: 'noInternetConnection');
    } catch (_) {
      return AsyncResult.error(error: 'other');
    }
  }

  @override
  Future<AsyncResult<void, String>> signOut() async {
    try {
      await _googleSignIn.signOut();
      await _supabaseAuth.signOut();

      return AsyncResult.data(data: null);
    } on AuthException catch (exception) {
      return AsyncResult.error(
        error: AuthFailureMapper.supabaseAuthError(exception.code),
      );
    } on SocketException catch (_) {
      return AsyncResult.error(error: 'noInternetConnection');
    } catch (_) {
      return AsyncResult.error(error: 'other');
    }
  }

  @override
  Future<AsyncResult<void, String>> updateUserPassword({
    required String newPassword,
  }) async {
    try {
      await _supabaseAuth.updateUser(UserAttributes(password: newPassword));

      return AsyncResult.data(data: null);
    } on AuthException catch (exception) {
      return AsyncResult.error(
        error: AuthFailureMapper.supabaseAuthError(exception.code),
      );
    } on SocketException catch (_) {
      return AsyncResult.error(error: 'noInternetConnection');
    } catch (_) {
      return AsyncResult.error(error: 'other');
    }
  }
}
