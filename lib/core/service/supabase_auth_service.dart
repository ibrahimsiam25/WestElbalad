import 'dart:convert';
import 'dart:developer';
import 'dart:math' as math;
import '../errors/excptions.dart';
import 'package:crypto/crypto.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseAuthService {
  final SupabaseClient _supabase = Supabase.instance.client;

  User? get currentUser => _supabase.auth.currentUser;

  bool get isEmailVerified =>
      _supabase.auth.currentUser?.emailConfirmedAt != null;

  Stream<AuthState> get authStateChanges => _supabase.auth.onAuthStateChange;

  Future<User> signUpWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _supabase.auth.signUp(
        email: email,
        password: password,
      );
      if (response.user == null) {
        throw CustomException(message: 'فشل في إنشاء الحساب. حاول مرة أخرى.');
      }
      return response.user!;
    } on AuthException catch (e) {
      log('AuthException in signUpWithEmailAndPassword: ${e.message}');
      _mapAuthException(e);
      rethrow;
    } catch (e) {
      if (e is CustomException) rethrow;
      log('Exception in signUpWithEmailAndPassword: $e');
      throw CustomException(message: 'حدث خطأ ما. الرجاء المحاولة مرة أخرى.');
    }
  }

  Future<User> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      if (response.user == null) {
        throw CustomException(message: 'فشل في تسجيل الدخول. حاول مرة أخرى.');
      }
      return response.user!;
    } on AuthException catch (e) {
      log('AuthException in signInWithEmailAndPassword: ${e.message}');
      _mapAuthException(e);
      rethrow;
    } catch (e) {
      if (e is CustomException) rethrow;
      log('Exception in signInWithEmailAndPassword: $e');
      throw CustomException(message: 'حدث خطأ ما. الرجاء المحاولة مرة أخرى.');
    }
  }

  Future<void> resendVerificationEmail(String email) async {
    try {
      await _supabase.auth.resend(
        type: OtpType.signup,
        email: email,
      );
    } on AuthException catch (e) {
      log('AuthException in resendVerificationEmail: ${e.message}');
      final msg = e.message.toLowerCase();
      if (msg.contains('rate limit') || msg.contains('too many')) {
        throw CustomException(
            message:
                'تم ارسال بريد التحقق بالفعل من قبل. يرجى المحاولة بعد دقيقة.');
      }
      throw CustomException(message: 'فشل في إرسال بريد التحقق.');
    } catch (e) {
      if (e is CustomException) rethrow;
      throw CustomException(
          message: 'حدث خطأ غير متوقع. حاول مرة أخرى لاحقاً.');
    }
  }

  Future<void> refreshSession() async {
    try {
      await _supabase.auth.refreshSession();
    } catch (_) {}
  }

  Future<void> resetPassword(String email) async {
    try {
      await _supabase.auth.resetPasswordForEmail(email);
    } on AuthException catch (e) {
      log('AuthException in resetPassword: ${e.message}');
      final msg = e.message.toLowerCase();
      if (msg.contains('user not found') || msg.contains('unable to find')) {
        throw CustomException(message: 'البريد الإلكتروني غير مسجل.');
      } else if (msg.contains('rate limit') || msg.contains('too many')) {
        throw CustomException(
            message:
                'تم إرسال بريد إعادة التعيين سابقاً. يرجى المحاولة بعد دقيقة.');
      }
      throw CustomException(message: 'حدث خطأ ما. حاول مرة أخرى لاحقاً.');
    } catch (e) {
      if (e is CustomException) rethrow;
      log('Exception in resetPassword: $e');
      throw CustomException(
          message: 'حدث خطأ غير متوقع. حاول مرة أخرى لاحقاً.');
    }
  }

  Future<User> signInWithGoogle() async {
    try {
      // TODO: ضع هنا الـ Web Client ID من Google Cloud Console
      // يمكن العثور عليه من: Supabase Dashboard → Auth → Providers → Google
      final GoogleSignIn googleSignIn = GoogleSignIn(
        serverClientId: 'YOUR_WEB_CLIENT_ID.apps.googleusercontent.com',
      );
      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        throw CustomException(message: 'تم إلغاء تسجيل الدخول بجوجل.');
      }
      final googleAuth = await googleUser.authentication;
      final idToken = googleAuth.idToken;
      final accessToken = googleAuth.accessToken;
      if (idToken == null) {
        throw CustomException(message: 'فشل في الحصول على token من جوجل.');
      }
      final response = await _supabase.auth.signInWithIdToken(
        provider: OAuthProvider.google,
        idToken: idToken,
        accessToken: accessToken,
      );
      if (response.user == null) {
        throw CustomException(message: 'فشل في تسجيل الدخول بجوجل.');
      }
      return response.user!;
    } on AuthException catch (e) {
      log('AuthException in signInWithGoogle: ${e.message}');
      _mapAuthException(e);
      rethrow;
    } catch (e) {
      if (e is CustomException) rethrow;
      log('Exception in signInWithGoogle: $e');
      throw CustomException(
          message: 'فشل في تسجيل الدخول بجوجل. حاول مرة أخرى.');
    }
  }

  Future<void> deleteUser() async {
    try {
      await _supabase.auth.admin.deleteUser(currentUser!.id);
    } catch (e) {
      log('Error deleting user: $e');
    }
  }

  Future<User> signInWithApple() async {
    try {
      final rawNonce = _generateNonce();
      final nonce = _sha256ofString(rawNonce);

      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        nonce: nonce,
      );

      if (appleCredential.identityToken == null) {
        throw CustomException(message: 'فشل في الحصول على token من Apple.');
      }

      final response = await _supabase.auth.signInWithIdToken(
        provider: OAuthProvider.apple,
        idToken: appleCredential.identityToken!,
        nonce: rawNonce,
      );

      if (response.user == null) {
        throw CustomException(message: 'فشل في تسجيل الدخول بـ Apple.');
      }
      return response.user!;
    } on AuthException catch (e) {
      log('AuthException in signInWithApple: ${e.message}');
      _mapAuthException(e);
      rethrow;
    } catch (e) {
      if (e is CustomException) rethrow;
      log('Exception in signInWithApple: $e');
      throw CustomException(
          message: 'فشل في تسجيل الدخول بـ Apple. حاول مرة أخرى.');
    }
  }

  // ─── Nonce helpers ───
  String _generateNonce([int length = 32]) {
    const charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = math.Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }

  String _sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  void _mapAuthException(AuthException e) {
    final msg = e.message.toLowerCase();
    if (msg.contains('already registered') ||
        msg.contains('user already exists')) {
      throw CustomException(
          message: 'الايميل مسجل من قبل. الرجاء تسجيل الدخول.');
    } else if (msg.contains('invalid email')) {
      throw CustomException(message: 'البريد الإلكتروني غير صالح.');
    } else if (msg.contains('password') && msg.contains('weak')) {
      throw CustomException(
          message: 'الرقم السري ضعيف جداً. يجب أن يكون 6 أحرف على الأقل.');
    } else if (msg.contains('network') || msg.contains('connection')) {
      throw CustomException(message: 'تأكد من اتصالك بالإنترنت.');
    } else if (msg.contains('invalid login') ||
        msg.contains('invalid credentials')) {
      throw CustomException(
          message: 'الرقم السري أو البريد الإلكتروني غير صحيح.');
    } else if (msg.contains('email not confirmed')) {
      throw CustomException(message: 'يرجى تأكيد بريدك الإلكتروني أولاً.');
    } else {
      throw CustomException(message: 'حدث خطأ ما. الرجاء المحاولة مرة أخرى.');
    }
  }
}
