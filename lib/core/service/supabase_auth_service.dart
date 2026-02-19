import 'dart:developer';
import '../errors/excptions.dart';
import 'package:google_sign_in/google_sign_in.dart';
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
