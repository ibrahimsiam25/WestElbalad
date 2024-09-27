import 'dart:io';
import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../../../home/domian/entites/phone_entites.dart';
import 'package:west_elbalad/features/admin/domain/entities/user_informations_entites.dart';
import 'package:west_elbalad/features/used_phones/domian/entities/used_phone_entities.dart';
import 'package:west_elbalad/features/shopping_cart/domian/entites/user_info_for_order_entities.dart';



abstract class AdminRepo {
  Future<Either<Failure, List<UserInformationsEntity>>> fetchAllUsers();
  Future<Either<Failure, List<PhoneEntites>>> fetchNewPhonesData();
  Future<Either<Failure, List<UsedPhonesEntities>>> fetchUsedPhonesData();
  Future<Either<Failure, List<UserInfoForOrderEntities>>> fetchOrdersData();
  Future<Either<Failure, void>> deleteNewPhoneData(String id);
  Future<Either<Failure, void>> deleteUsedPhoneData(String id);
  Future<Either<Failure, void>> deleteOrderData(String id);
  Future<void> uploadPhoneData(File image, Map<String, dynamic> data);
  Future<File?> openImagePickerFromCamera();
  Future<File?> openImagePickerFromGallery();
  Future<Either<Failure, void>> editNewPhonePrice(String phoneId, int newValue);
  Future<Either<Failure, void>> editUsedPhonePrice(String phoneId, int newValue);
  

}
