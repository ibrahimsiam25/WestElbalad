import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:west_elbalad/features/admin/domain/entities/user_informations_entites.dart';

import '../../../../core/errors/failure.dart';
import '../../../home/domian/entites/phone_entites.dart';

abstract class AdminRepo {
  Future<Either<Failure, List<UserInformationsEntity>>> fetchAllUsers(
      {bool isRefreshed = false});
  Future<Either<Failure, List<PhoneEntites>>> fetchPhonesData();
  Future<Either<Failure, void>> deletePhoneData(String id);
  Future<void> uploadPhoneData(File image, Map<String, dynamic> data);
  Future<File?> openImagePickerFromCamera();
  Future<File?> openImagePickerFromGallery();
  Future<Either<Failure, void>> editPrice(String phoneId, int newValue);
}
