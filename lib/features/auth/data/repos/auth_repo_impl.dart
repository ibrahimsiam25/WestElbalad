import 'dart:convert';
import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/errors/excptions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../presentation/views/signin_view.dart';
import '../../../../core/constants/app_consts.dart';
import '../../../../core/service/data_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../core/utils/backend_endpoints.dart';
import '../../presentation/views/verification_view.dart';
import '../../../../core/service/firebase_auth_service.dart';
import '../../../../core/service/supabase_auth_service.dart';
import '../../../../core/service/shared_preferences_singleton.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supa;
import 'package:west_elbalad/features/auth/data/models/user_model.dart';
import 'package:west_elbalad/features/auth/domain/repos/auth_repo.dart';
import 'package:west_elbalad/features/auth/domain/entites/user_entity.dart';
import 'package:west_elbalad/features/auth/presentation/views/widgets/sign_up_successfully.dart';

class AuthRepoImpl extends AuthRepo {
  final FirebaseAuthService firebaseAuthService;
  final SupabaseAuthService supabaseAuthService;
  final DatabaseService databaseService;

  AuthRepoImpl({
    required this.databaseService,
    required this.firebaseAuthService,
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
      var userEntity = UserEntity(
        name: name,
        email: email,
        uId: supaUser.id,
      );
      await SharedPref.setString('user_name', name);
      return right(userEntity);
    } on CustomException catch (e) {
      return left(ServerFailure(e.message));
    } catch (e) {
      log(
        'Exception in AuthRepoImpl.createUserWithEmailAndPassword: ${e.toString()}',
      );
      return left(
        ServerFailure('??? ??? ??. ?????? ???????? ??? ????.'),
      );
    }
  }

  Future<void> deleteUser(User? user) async {
    if (user != null) {
      await firebaseAuthService.deleteUser();
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
        return left(ServerFailure('??????? ???? ?? ??? ????? ?? ????? ???'));
      }
      bool isUserExist = await doesDocumentExist(supaUser.id);
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
      log(
        'Exception in AuthRepoImpl.signinWithEmailAndPassword: ${e.toString()}',
      );
      return left(
        ServerFailure('??? ??? ??. ?????? ???????? ??? ????.'),
      );
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
      log('Exception in AuthRepoImpl.signinWithGoogle ${e.toString()}');
      return left(ServerFailure('حدث خطأ ما. الرجاء المحاولة مرة اخرى.'));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signinWithApple() async {
    User? user;
    try {
      user = await firebaseAuthService.signInWithApple();
      var userEntity = UserModel.fromFirebaseUser(user);
      await addUserData(user: userEntity);
      await saveUserData(user: userEntity);
      return right(userEntity);
    } catch (e) {
      await deleteUser(user);
      log('Exception in AuthRepoImpl.signinWithApple: ${e.toString()}');
      return left(ServerFailure('??? ??? ??. ?????? ???????? ??? ????.'));
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
                child: Text('??? ??? ??. ?????? ???????? ??? ????.'));
          } else {
            final supaUser = supa.Supabase.instance.client.auth.currentUser;
            if (supaUser == null) {
              return SigninView();
            }
            if (supaUser.emailConfirmedAt != null) {
              String name = SharedPref.getString('user_name');
              var userEntity = UserEntity(
                name: name,
                email: supaUser.email ?? '',
                uId: supaUser.id,
              );
              addData(
                path: BackendEndpoint.addUserData,
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

FirebaseFirestore firestore = FirebaseFirestore.instance;

Future<void> addData(
    {required String path,
    required Map<String, dynamic> data,
    String? documentId}) async {
  if (documentId != null) {
    firestore.collection(path).doc(documentId).set(data);
  } else {
    await firestore.collection(path).add(data);
  }
}

Future<bool> doesDocumentExist(String documentName) async {
  try {
    CollectionReference usersCollection =
        FirebaseFirestore.instance.collection('users');
    DocumentReference documentRef = usersCollection.doc(documentName);
    DocumentSnapshot documentSnapshot = await documentRef.get();
    return documentSnapshot.exists;
  } catch (e) {
    print('Error checking document existence: $e');
    return false;
  }
}
