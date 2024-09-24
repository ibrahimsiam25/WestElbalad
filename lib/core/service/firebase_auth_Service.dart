import 'dart:io';
import 'dart:convert';
import 'dart:developer';
import 'dart:math' as math;
import '../errors/excptions.dart';
import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class FirebaseAuthService {
  Future deleteUser() async {
    await FirebaseAuth.instance.currentUser!.delete();
  }

  Future<void> sendEmailVerification(User user) async {
    try {
      await user.sendEmailVerification();
      log('Verification email sent to ${user.email}');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'too-many-requests') {
        log("Too many requests: ${e.message}");
        throw CustomException(
            message:
                'تم ارسال بريد التحقق بالفعل من قبل يرجي محاوله  تسجيل بعد دقيقة.');
      } else if (e.code == 'network-request-failed') {
        log("Network error: ${e.message}");
        throw CustomException(
            message:
                'تعذر إرسال البريد بسبب مشكلة في الاتصال بالشبكة. يرجى التحقق من اتصالك وحاول مرة أخرى.');
      } else {
        log("FirebaseAuthException: ${e.message}");
        throw CustomException(message: 'فشل في إرسال بريد التحقق.');
      }
    } catch (e) {
      log("Unexpected error: ${e.toString()}");
      throw CustomException(
          message: 'حدث خطأ غير متوقع. حاول مرة أخرى لاحقًا.');
    }
  }

  Future<User> createUserWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User user = credential.user!;
      await sendEmailVerification(user);

      return user;
    } on FirebaseAuthException catch (e) {
      log("Exception in FirebaseAuthService.createUserWithEmailAndPassword: ${e.toString()} and code is ${e.code}");
      final user = FirebaseAuth.instance.currentUser;

      bool isUserExist = await doesDocumentExist(user!.uid);
      if (e.code == 'email-already-in-use' && !isUserExist) {
        await sendEmailVerification(user);
        throw CustomException(
            message: 'الايميل مسجل من قبل ولاكن لم يتحقق منه');
      } else if (e.code == 'weak-password') {
        throw CustomException(message: 'الرقم السري ضعيف جداً.');
      } else if (e.code == 'email-already-in-use') {
        throw CustomException(
            message: 'لقد قمت بالتسجيل مسبقاً. الرجاء تسجيل الدخول.');
      } else if (e.code == 'network-request-failed') {
        throw CustomException(message: 'تأكد من اتصالك بالإنترنت.');
      } else if (e.code == 'invalid-email') {
        throw CustomException(message: 'البريد الإلكتروني غير صالح.');
      } else if (e.code == 'operation-not-allowed') {
        throw CustomException(message: 'عملية التسجيل غير مسموح بها حالياً.');
      } else if (e.code == 'user-disabled') {
        throw CustomException(
            message: 'تم تعطيل حسابك. الرجاء المحاولة مرة أخرى.');
      } else if (e.code == 'too-many-requests') {
        throw CustomException(
            message: 'تم حظر الطلبات مؤقتاً. حاول مرة أخرى لاحقاً.');
      } else {
        throw CustomException(
            message: 'لقد حدث خطأ ما. الرجاء المحاولة مرة أخرى.');
      }
    } catch (e) {
      log("Exception in FirebaseAuthService.createUserWithEmailAndPassword: ${e.toString()}");

      throw CustomException(
          message: 'لقد حدث خطأ ما. الرجاء المحاولة مرة اخرى.');
    }
  }

  Future<User> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      return credential.user!;
    } on FirebaseAuthException catch (e) {
      log("Exception in FirebaseAuthService.signInWithEmailAndPassword: ${e.toString()} and code is ${e.code}");
      if (e.code == 'user-not-found') {
        throw CustomException(
            message: 'لا يوجد حساب مسجل بهذا البريد الالكتروني.');
      } else if (e.code == 'wrong-password') {
        throw CustomException(
            message: 'الرقم السري او البريد الالكتروني غير صحيح.');
      } else if (e.code == 'invalid-credential') {
        throw CustomException(
            message: 'الرقم السري او البريد الالكتروني غير صحيح.');
      } else if (e.code == 'network-request-failed') {
        throw CustomException(message: 'تاكد من اتصالك بالانترنت.');
      } else {
        throw CustomException(
            message: 'لقد حدث خطأ ما. الرجاء المحاولة مرة اخرى.');
      }
    } catch (e) {
      log("Exception in FirebaseAuthService.signInWithEmailAndPassword: ${e.toString()}");

      throw CustomException(
          message: 'لقد حدث خطأ ما. الرجاء المحاولة مرة اخرى.');
    }
  }

  Future<User> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    return (await FirebaseAuth.instance.signInWithCredential(credential)).user!;
  }

  Future<User> signInWithFacebook() async {
    final rawNonce = generateNonce();
    final nonce = sha256ofString(rawNonce);
    final LoginResult loginResult =
        await FacebookAuth.instance.login(nonce: nonce);
    OAuthCredential facebookAuthCredential;

    if (Platform.isIOS) {
      switch (loginResult.accessToken!.type) {
        case AccessTokenType.classic:
          final token = loginResult.accessToken as ClassicToken;
          facebookAuthCredential = FacebookAuthProvider.credential(
            token.authenticationToken!,
          );
          break;
        case AccessTokenType.limited:
          final token = loginResult.accessToken as LimitedToken;
          facebookAuthCredential = OAuthCredential(
            providerId: 'facebook.com',
            signInMethod: 'oauth',
            idToken: token.tokenString,
            rawNonce: rawNonce,
          );
          break;
      }
    } else {
      facebookAuthCredential = FacebookAuthProvider.credential(
        loginResult.accessToken!.tokenString,
      );
    }

    return (await FirebaseAuth.instance
            .signInWithCredential(facebookAuthCredential))
        .user!;
  }

  /// Generates a cryptographically secure random nonce, to be included in a
  /// credential request.
  String generateNonce([int length = 32]) {
    const charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = math.Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }

  /// Returns the sha256 hash of [input] in hex notation.
  String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  Future<User> signInWithApple() async {
    // To prevent replay attacks with the credential returned from Apple, we
    // include a nonce in the credential request. When signing in with
    // Firebase, the nonce in the id token returned by Apple, is expected to
    // match the sha256 hash of `rawNonce`.
    final rawNonce = generateNonce();
    final nonce = sha256ofString(rawNonce);

    // Request credential for the currently signed in Apple account.
    final appleCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
      nonce: nonce,
    );

    // Create an `OAuthCredential` from the credential returned by Apple.
    final oauthCredential = OAuthProvider("apple.com").credential(
      idToken: appleCredential.identityToken,
      rawNonce: rawNonce,
    );

    return (await FirebaseAuth.instance.signInWithCredential(oauthCredential))
        .user!;
  }

  Future<bool> doesDocumentExist(String documentName) async {
    try {
      // Reference to the Firestore collection
      CollectionReference usersCollection =
          FirebaseFirestore.instance.collection('users');

      // Get the document reference
      DocumentReference documentRef = usersCollection.doc(documentName);

      // Get the document snapshot
      DocumentSnapshot documentSnapshot = await documentRef.get();

      // Check if the document exists
      return documentSnapshot.exists;
    } catch (e) {
      // Handle any errors that occur
      print('Error checking document existence: $e');
      return false;
    }
  }
}
