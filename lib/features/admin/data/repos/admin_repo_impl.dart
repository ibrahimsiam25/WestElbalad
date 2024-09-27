import 'dart:io';
import 'dart:developer';
import 'package:dartz/dartz.dart';
import '../../../../core/errors/excptions.dart';
import '../../../home/data/model/phones_model.dart';
import 'package:west_elbalad/core/errors/failure.dart';
import '../../../home/domian/entites/phone_entites.dart';
import '../../../../core/functions/generate_unique_id.dart';
import '../../../../core/service/image_picker_serivce.dart';
import 'package:west_elbalad/features/admin/domain/repos/admin_repo.dart';
import 'package:west_elbalad/features/admin/domain/entities/user_informations_entites.dart';
import 'package:west_elbalad/features/used_phones/domian/entities/used_phone_entities.dart';
import 'package:west_elbalad/features/shopping_cart/domian/entites/user_info_for_order_entities.dart';
import 'package:west_elbalad/features/admin/data/data_sources/user_informations_local_data_source.dart';
import 'package:west_elbalad/features/admin/data/data_sources/user_informations_remote_data_source.dart';



class AdminRepoImpl extends AdminRepo {
  final ImagePickerService imagePickerService;
  final UserInformationsRemoteDataSource userInformationsRemoteDataSource;
  final UserInformationsLocalDataSource userInformationsLocalDataSource;
  AdminRepoImpl({
    required this.userInformationsRemoteDataSource,
    required this.userInformationsLocalDataSource,
    required this.imagePickerService,
  });

  @override
  Future<Either<Failure, List<UserInformationsEntity>>> fetchAllUsers(
      {bool isRefreshed = false}) async {
    try {
      List<UserInformationsEntity> usersList;

      if (isRefreshed) {
        print(
            "*****************User ***********Fetching data from user remote data source due to refresh");
        usersList = await userInformationsRemoteDataSource.fetchUsersData();
        return right(usersList);
      }

      usersList = await userInformationsLocalDataSource.fetchUsersData();

      if (usersList.isNotEmpty) {
        print(
            "*******************User********** information exists in local data source");
        return right(usersList);
      }

      print(
          "*********************User********** information does not exist in local data source, fetching from remote");
      usersList = await userInformationsRemoteDataSource.fetchUsersData();
      return right(usersList);
    } on CustomException catch (e) {
      return left(ServerFailure(e.message));
    } catch (e) {
      log('Exception in fetchAllUsers: ${e.toString()}');
      return left(
        ServerFailure('حدث خطأ ما. الرجاء المحاولة مرة أخرى.'),
      );
    }
  }

  @override
  Future<void> uploadPhoneData(File image, Map<String, dynamic> data) async {
    String documentId = generateUniqueId();
    String imageUrl =
        await userInformationsRemoteDataSource.uploadImage(image, documentId);

    PhoneEntites phoneEntites = PhoneEntites(
      id: documentId,
      type: data["phoneType"].toLowerCase(),
      name: data["phoneName"].toLowerCase(),
      description: data["phoneDescription"].toLowerCase(),
      imageUrl: imageUrl,
      price: int.parse(data["phonePrice"]),
    );

    await userInformationsRemoteDataSource.addPhoneData(
        PhoneModel.fromEntity(phoneEntites).toMap(), documentId);
  }

  @override
  Future<File?> openImagePickerFromCamera() {
    return imagePickerService.uploadImageFromCamera();
  }

  @override
  Future<File?> openImagePickerFromGallery() {
    return imagePickerService.uploadImageFromGallery();
  }

  @override
  Future<Either<Failure, List<PhoneEntites>>> fetchNewPhonesData() async {
    try {
      List<PhoneEntites> phoneList =
          await userInformationsRemoteDataSource.fetchNewPhonesData();
      print(
          "******************fetchPhonesData AdminRepoImpl**********************");
      return right(phoneList);
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
  Future<Either<Failure, List<UsedPhonesEntities>>>
      fetchUsedPhonesData() async {
    try {
      List<UsedPhonesEntities> phoneList =
          await userInformationsRemoteDataSource.fetchUsedPhonesData();
      print(
          "******************fetchPhonesData AdminRepoImpl**********************");
      return right(phoneList);
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
  Future<Either<Failure, void>> deleteNewPhoneData(String id) async {
    try {
      await userInformationsRemoteDataSource.deleteNewPhoneData(id);
      return right(null);
    } on CustomException catch (e) {
      return left(ServerFailure(e.message));
    } catch (e) {
      return left(
        ServerFailure(
          'حدث خطأ ما. الرجاء المحاولة مرة اخرى.',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, void>> deleteUsedPhoneData(String id) async {
    try {
      await userInformationsRemoteDataSource.deleteUsedPhoneData(id);
      return right(null);
    } on CustomException catch (e) {
      return left(ServerFailure(e.message));
    } catch (e) {
      return left(
        ServerFailure(
          'حدث خطأ ما. الرجاء المحاولة مرة اخرى.',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, void>> editNewPhonePrice(
      String phoneId, int newValue) async {
    try {
      await userInformationsRemoteDataSource.editNewPhonePrice(
          phoneId, newValue);
      return right(null);
    } on CustomException catch (e) {
      return left(ServerFailure(e.message));
    } catch (e) {
      return left(
        ServerFailure(
          'حدث خطأ ما. الرجاء المحاولة مرة اخرى.',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, void>> editUsedPhonePrice(
      String phoneId, int newValue) async {
    try {
      await userInformationsRemoteDataSource.editUsedPhonePrice(
          phoneId, newValue);
      return right(null);
    } on CustomException catch (e) {
      return left(ServerFailure(e.message));
    } catch (e) {
      return left(
        ServerFailure(
          'حدث خطأ ما. الرجاء المحاولة مرة اخرى.',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, void>> deleteOrderData(String id) async{
    try {
    await  userInformationsRemoteDataSource.deleteOrderData(id);
      return right(null);
    } on CustomException catch (e) {
      return left(ServerFailure(e.message));
    } catch (e) {
      return left(
        ServerFailure(
          'حدث خطأ ما. الرجاء المحاولة مرة اخرى.',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<UserInfoForOrderEntities>>> fetchOrdersData()async {
    try {
      List<UserInfoForOrderEntities> ordersList =
        await  userInformationsRemoteDataSource.fetchOrdersData();
      print(
          "******************fetch ordersData AdminRepoImpl**********************");
      return right(ordersList);
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
  }

