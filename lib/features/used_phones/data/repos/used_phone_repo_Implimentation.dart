import 'dart:io';
import 'dart:developer';
import 'package:dartz/dartz.dart';
import '../../domian/repos/used_phone_repo.dart';
import 'package:west_elbalad/core/errors/failure.dart';
import 'package:west_elbalad/core/errors/excptions.dart';
import 'package:west_elbalad/core/functions/get_user.dart';
import '../../../../core/service/image_picker_serivce.dart';
import '../../../../core/functions/generate_unique_id.dart';
import 'package:west_elbalad/features/used_phones/data/model/used_phone_model.dart';
import 'package:west_elbalad/features/used_phones/domian/entities/used_phone_entities.dart';
import 'package:west_elbalad/features/used_phones/data/data_source/used_phone_data_source.dart';


class UsedPhoneRepoImplimentation extends UsedPhonesRepo  {
  final UsedPhoneRemoteDataSource usedPhoneRemoteDataSource;
final ImagePickerService imagePickerService;
  UsedPhoneRepoImplimentation({required this.imagePickerService, 
      required this.usedPhoneRemoteDataSource});

  @override
  Future<Either<Failure, List<UsedPhonesEntities>>> fetchUsedPhonesData(
     ) async {
    List<UsedPhonesEntities> UsedPhonesData;
    try {
      UsedPhonesData = await usedPhoneRemoteDataSource.fetchUsedPhonesData();
        return right(UsedPhonesData);
      
    } on CustomException catch (e) {
      return left(ServerFailure(e.message));
    } catch (e) {
      log(
        'Exception in AuthRepoImpl.fetchAllPhones: ${e.toString()}',
      );
      return left(
        ServerFailure(
          'حدث خطأ ما. الرجاء المحاولة مرة اخرى.',
        ),
      );
    }
  }
    @override
  Future<void> uploadPhoneData(File image, Map<String, dynamic> data) async {
    String documentId = generateUniqueId();
    String imageUrl =
        await usedPhoneRemoteDataSource.uploadImage(image, documentId);

    UsedPhonesEntities usedPhonesEntities= UsedPhonesEntities(
      id: documentId,
      authUserId:getUser().uId ,
      authUserName: getUser().name,
      authUserEmail: getUser().email,
      userName: data["userName"].toLowerCase(),
      userPhone: data["userPhone"].toLowerCase(),
      userGovernorate: data["userGovernorate"].toLowerCase(),
      userLocation: data["userLocation"].toLowerCase(),
      type: data["phoneType"].toLowerCase(),
      name: data["phoneName"].toLowerCase(),
      description: data["phoneDescription"].toLowerCase(),
      imageUrl: imageUrl,
      price: int.parse(data["phonePrice"]),

    );


    await usedPhoneRemoteDataSource.addPhoneData(
        UsedPhoneModel.fromEntity(usedPhonesEntities).toMap(), documentId);
  }

  @override
  Future<File?> openImagePickerFromCamera() {
    return imagePickerService.uploadImageFromCamera();
  }

  @override
  Future<File?> openImagePickerFromGallery() {
    return imagePickerService.uploadImageFromGallery();
  }

  }
  


