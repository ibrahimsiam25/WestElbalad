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
import '../../../../core/service/shared_preferences_singleton.dart';
import 'package:west_elbalad/features/auth/data/models/user_model.dart';
import 'package:west_elbalad/features/auth/domain/repos/auth_repo.dart';
import 'package:west_elbalad/features/auth/domain/entites/user_entity.dart';
import 'package:west_elbalad/features/auth/presentation/views/widgets/sign_up_successfully.dart';

class AuthRepoImpl extends AuthRepo {
  final FirebaseAuthService firebaseAuthService;
  final DatabaseService databaseService;

  AuthRepoImpl(
      {required this.databaseService, required this.firebaseAuthService});
  @override
  Future<Either<Failure, UserEntity>> createUserWithEmailAndPassword(
      String email, String password, String name) async {
    User? user;
    try {
      user = await firebaseAuthService.createUserWithEmailAndPassword(
          email: email, password: password);
      var userEntity = UserEntity(
        name: name,
        email: email,
        uId: user.uid,
      );
      SharedPref.setString('user_name',name);

      return right(userEntity);
    } on CustomException catch (e) {
      return left(ServerFailure(e.message));
    } catch (e) {
      log(
        'Exception in AuthRepoImpl.createUserWithEmailAndPassword: ${e.toString()}',
      );
      return left(
        ServerFailure(
          'حدث خطأ ما. الرجاء المحاولة مرة اخرى.',
        ),
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
      var user = await firebaseAuthService.signInWithEmailAndPassword(
          email: email, password: password);
          bool isUserExist = await doesDocumentExist(user.uid);
          if (!isUserExist) {
            await sendEmailVerification(user);
            return left(ServerFailure('الايميل مسجل من قبل ولاكن لم يتحقق منه'));
          } else {
             var userEntity = UserModel.fromFirebaseUser(user);
                return right(
        userEntity,
      );
          }
     
      
   
    } on CustomException catch (e) {
      return left(ServerFailure(e.message));
    } catch (e) {
      log(
        'Exception in AuthRepoImpl.signinWithEmailAndPassword: ${e.toString()}',
      );
      return left(
        ServerFailure(
          'حدث خطأ ما. الرجاء المحاولة مرة اخرى.',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signinWithGoogle() async {
    User? user;
    try {
      user = await firebaseAuthService.signInWithGoogle();

      var userEntity = UserModel.fromFirebaseUser(user);
      var isUserExist = await databaseService.checkIfDataExists(
          path: BackendEndpoint.isUserExists, docuementId: user.uid);
      if (isUserExist) {
        await getUserData(uid: user.uid);
      } else {
        await addUserData(user: userEntity);
      }
      return right(userEntity);
    } catch (e) {
      await deleteUser(user);
      log(
        'Exception in AuthRepoImpl.signinWithGoogle ${e.toString()}',
      );
      return left(
        ServerFailure(
          'حدث خطأ ما. الرجاء المحاولة مرة اخرى.',
        ),
      );
    }
  }



  @override
  Future<Either<Failure, UserEntity>> signinWithApple() async {
    User? user;
    try {
      user = await firebaseAuthService.signInWithApple();

      var userEntity = UserModel.fromFirebaseUser(user);
      await addUserData(user: userEntity);
      return right(userEntity);
    } catch (e) {
      await deleteUser(user);
      log(
        'Exception in AuthRepoImpl.createUserWithEmailAndPassword: ${e.toString()}',
      );
      return left(
        ServerFailure(
          'حدث خطأ ما. الرجاء المحاولة مرة اخرى.',
        ),
      );
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
    await SharedPref.setString(kUserData, jsonData);
  }
}

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Center(
                  child: Text('حدث خطأ ما. الرجاء المحاولة مرة اخرى.'));
            } else {
              if (snapshot.data == null) {
                return SigninView();
              } else {
                if (snapshot.data?.emailVerified == true) {
                String name =  SharedPref.getString('user_name');
                   var userEntity = UserEntity(
        name: name,
        email: UserModel.fromFirebaseUser(snapshot.data!).email,
        uId:UserModel.fromFirebaseUser(snapshot.data!).uId,
      );
                  addData(
                    path: BackendEndpoint.addUserData,
                    documentId: snapshot.data!.uid,
                    data: UserModel.fromEntity(userEntity).toMap(),
                  );

                  return SignUpSuccessfully();
                }
                return VerificationView();
              }
            }
          }),
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

  Future<void> sendEmailVerification(User user) async {

    try {
      await user.sendEmailVerification();
      log('Verification email sent to ${user.email}');
    }on FirebaseAuthException catch (e) {
    if (e.code == 'too-many-requests') {
      log("Too many requests: ${e.message}");
      throw CustomException(message: 'تم ارسال بريد التحقق بالفعل من قبل. يرجى المحاولة مرة أخرى في وقت لاحق.');
    } else if (e.code == 'network-request-failed') {
      log("Network error: ${e.message}");
      throw CustomException(message: 'تعذر إرسال البريد بسبب مشكلة في الاتصال بالشبكة. يرجى التحقق من اتصالك وحاول مرة أخرى.');
    } else {
      log("FirebaseAuthException: ${e.message}");
      throw CustomException(message: 'فشل في إرسال بريد التحقق.');
    }
  } catch (e) {
    log("Unexpected error: ${e.toString()}");
    throw CustomException(message: 'حدث خطأ غير متوقع. حاول مرة أخرى لاحقًا.');
  }
  }