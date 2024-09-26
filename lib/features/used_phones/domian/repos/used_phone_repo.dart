import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:west_elbalad/core/errors/failure.dart';
import 'package:west_elbalad/features/used_phones/domian/entities/used_phone_entities.dart';


abstract class UsedPhonesRepo {
  Future<Either<Failure, List<UsedPhonesEntities>>> fetchUsedPhonesData();
  Future<void> uploadPhoneData(File image, Map<String, dynamic> data);
  Future<File?> openImagePickerFromCamera();
  Future<File?> openImagePickerFromGallery();
  
}
