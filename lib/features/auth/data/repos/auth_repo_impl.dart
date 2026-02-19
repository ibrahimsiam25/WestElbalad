import 'dart:convert';
import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supa;
import '../../../../core/errors/failure.dart';
import '../../../../core/errors/excptions.dart';
import '../../presentation/views/signin_view.dart';
import '../../../../core/constants/app_consts.dart';
import '../../../../core/service/data_service.dart';
import '../../../../core/utils/backend_endpoints.dart';
import '../../presentation/views/verification_view.dart';
import '../../../../core/service/supabase_auth_service.dart';
import '../../../../core/service/shared_preferences_singleton.dart';
import 'package:west_elbalad/features/auth/data/models/user_model.dart';
import 'package:west_elbalad/features/auth/domain/repos/auth_repo.dart';
import 'package:west_elbalad/features/auth/domain/entites/user_entity.dart';
import 'package:west_elbalad/features/auth/presentation/views/widgets/sign_up_successfully.dart';

class AuthRepoImpl extends AuthRepo {
  final SupabaseAuthService supabaseAuthService;
  final DatabaseService databaseService;

  AuthRepoImpl({
    required this.databaseService,
    required this.supabaseAuthService,
  });

  @override
  Future<Either<Failure, UserEntity>> createUserWithEmailAndPassword(
      String email, String password, String name) async {
    try {
      final supaUser = await supabaseAuthService.signUpWithEmailAndPassword(
        email: email,
        password: password,
      );
      var userEntity = UserEntity(name: name, email: email, uId: supaUser.id);
      await SharedPref.setString('user_name', name);
      return right(userEntity);
    } on CustomException catch (e) {
      return left(ServerFailure(e.message));
    } catch (e) {
      log('Exception in createUserWithEmailAndPassword: $e');
      return left(ServerFailure('حدث خطأ ما. الرجاء المحاولة مرة اخرى.'));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signinWithEmailAndPassword(
      String email, String password) async {
    try {
      final supaUser = await supabaseAuthService.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (supaUser.emailConfirmedAt == null) {
        await SharedPref.setString('pending_verification_email', email);
        return left(ServerFailure('الايميل مسجل من قبل ولاكن لم يتحقق منه'));
      }
      bool isUserExist = await _doesUserExist(supaUser.id);
      if (isUserExist) {
        final data = await databaseService.getData(
            path: BackendEndpoint.getUsersData, docuementId: supaUser.id);
        final fullUser = UserModel.fromJson(data);
        await saveUserData(user: fullUser);
        return right(fullUser);
      } else {
        final userEntity = UserModel.fromSupabaseUser(
          supaUser,
          name: SharedPref.getString('user_name'),
        );
        await saveUserData(user: userEntity);
        return right(userEntity);
      }
    } on CustomException catch (e) {
      return left(ServerFailure(e.message));
    } catch (e) {
      log('Exception in signinWithEmailAndPassword: $e');
      return left(ServerFailure('حدث خطأ ما. الرجاء المحاولة مرة اخرى.'));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signinWithGoogle() async {
    try {
      final supaUser = await supabaseAuthService.signInWithGoogle();
      final name = supaUser.userMetadata?['full_name'] as String? ??
          supaUser.userMetadata?['name'] as String? ??
          '';
      var userEntity = UserModel.fromSupabaseUser(supaUser, name: name);
      bool isUserExist = await databaseService.checkIfDataExists(
          path: BackendEndpoint.isUserExists, docuementId: supaUser.id);
      if (isUserExist) {
        final data = await databaseService.getData(
            path: BackendEndpoint.getUsersData, docuementId: supaUser.id);
        final fullUser = UserModel.fromJson(data);
        await saveUserData(user: fullUser);
        return right(fullUser);
      } else {
        await addUserData(user: userEntity);
        await saveUserData(user: userEntity);
        return right(userEntity);
      }
    } on CustomException catch (e) {
      return left(ServerFailure(e.message));
    } catch (e) {
      log('Exception in signinWithGoogle: $e');
      return left(ServerFailure('حدث خطأ ما. الرجاء المحاولة مرة اخرى.'));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signinWithApple() async {
    try {
      final supaUser = await supabaseAuthService.signInWithApple();
      final name = supaUser.userMetadata?['full_name'] as String? ??
          supaUser.userMetadata?['name'] as String? ??
          '';
      var userEntity = UserModel.fromSupabaseUser(supaUser, name: name);
      await addUserData(user: userEntity);
      await saveUserData(user: userEntity);
      return right(userEntity);
    } on CustomException catch (e) {
      return left(ServerFailure(e.message));
    } catch (e) {
      log('Exception in signinWithApple: $e');
      return left(ServerFailure('حدث خطأ ما. الرجاء المحاولة مرة اخرى.'));
    }
  }

  @override
  Future addUserData({required UserEntity user}) async {
    await databaseService.addData(
      path: BackendEndpoint.addUserData,
      data: UserModel.fromEntity(user).toMap(),
      documentId: user.uId,
    );
  }

  @override
  Future<UserEntity> getUserData({required String uid}) async {
    var userData = await databaseService.getData(
        path: BackendEndpoint.getUsersData, docuementId: uid);
    return UserModel.fromJson(userData);
  }

  @override
  Future saveUserData({required UserEntity user}) async {
    var jsonData = jsonEncode(UserModel.fromEntity(user).toMap());
    await SharedPref.setString(kUserInformationsSharPref, jsonData);
  }
}

// ─── Wrapper ──────────────────────────────────────────────────────────────────

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<supa.AuthState>(
        stream: supa.Supabase.instance.client.auth.onAuthStateChange,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(
                child: Text('حدث خطأ ما. الرجاء المحاولة مرة اخرى.'));
          } else {
            final supaUser =
                supa.Supabase.instance.client.auth.currentUser;
            if (supaUser == null) return SigninView();
            if (supaUser.emailConfirmedAt != null) {
              String name = SharedPref.getString('user_name');
              var userEntity = UserEntity(
                name: name,
                email: supaUser.email ?? '',
                uId: supaUser.id,
              );
              _addUserToDb(
                table: BackendEndpoint.addUserData,
                documentId: supaUser.id,
                data: UserModel.fromEntity(userEntity).toMap(),
              );
              return SignUpSuccessfully();
            }
            return VerificationView();
          }
        },
      ),
    );
  }
}

// ─── Global helpers (Supabase) ────────────────────────────────────────────────

String _supaTable(String collection) =>
    collection == 'usedPhones' ? 'used_phones' : collection;

Future<void> _addUserToDb({
  required String table,
  required Map<String, dynamic> data,
  String? documentId,
}) async {
  try {
    await supa.Supabase.instance.client
        .from(_supaTable(table))
        .upsert(data);
  } catch (e) {
    log('Error in _addUserToDb: $e');
  }
}

Future<bool> _doesUserExist(String userId) async {
  try {
    final response = await supa.Supabase.instance.client
        .from('users')
        .select('uId')
        .eq('uId', userId)
        .maybeSingle();
    return response != null;
  } catch (e) {
    log('Error in _doesUserExist: $e');
    return false;
  }
}
