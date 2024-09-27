import 'dart:io';
import '../model/user_informations_model.dart';
import '../../../../core/service/data_service.dart';
import '../../../home/domian/entites/phone_entites.dart';
import 'package:west_elbalad/core/constants/app_consts.dart';
import 'package:west_elbalad/core/utils/backend_endpoints.dart';
import 'package:west_elbalad/features/home/data/model/phones_model.dart';
import '../../../shopping_cart/data/model/user_info_for_order_model.dart';
import '../../../shopping_cart/domian/entites/user_info_for_order_entities.dart';
import 'package:west_elbalad/features/used_phones/data/model/used_phone_model.dart';
import 'package:west_elbalad/features/admin/domain/entities/user_informations_entites.dart';
import 'package:west_elbalad/features/used_phones/domian/entities/used_phone_entities.dart';



abstract class UserInformationsRemoteDataSource {
  Future<void> deleteNewPhoneData(String id);
  Future<void> deleteUsedPhoneData(String id);
  Future<void> deleteOrderData(String id);
  Future<List<PhoneEntites>> fetchNewPhonesData();
  Future<List<UsedPhonesEntities>> fetchUsedPhonesData();
  Future<List<UserInfoForOrderEntities>> fetchOrdersData();
  Future<void> editNewPhonePrice(String phoneId, int newValue);
  Future<void> editUsedPhonePrice(String phoneId, int newValue);
  Future<List<UserInformationsEntity>> fetchUsersData();
  Future<String> uploadImage(File image, String documentId);
  Future<void> addPhoneData(Map<String, dynamic> data, String documentId);
}

class UserInformationsRemoteDataSourceImpl
    extends UserInformationsRemoteDataSource {
  final DatabaseService databaseService;

  UserInformationsRemoteDataSourceImpl({required this.databaseService});

  @override
  Future<List<UserInformationsEntity>> fetchUsersData() async {
    final List<Map<String, dynamic>> usersData =
        await databaseService.fetchAllDocuments(BackendEndpoint.addUserData);
    final List<UserInformationsEntity> usersList = usersData.map((data) {
      return UserInformationsModel.fromMap(data);
    }).toList();

    return usersList;
  }

  @override
  Future<List<PhoneEntites>> fetchNewPhonesData() async {
    final List<Map<String, dynamic>> phonesData =
        await databaseService.fetchAllDocuments(BackendEndpoint.newPhone);
    final List<PhoneEntites> phonesList = phonesData.map((data) {
      return PhoneModel.fromMap(data);
    }).toList();
    return phonesList;
  }

  @override
  Future<List<UsedPhonesEntities>> fetchUsedPhonesData() async {
    final List<Map<String, dynamic>> phonesData =
        await databaseService.fetchAllDocuments(BackendEndpoint.usedPhones);
    final List<UsedPhonesEntities> phonesList = phonesData.map((data) {
      return UsedPhoneModel.fromMap(data);
    }).toList();
    return phonesList;
  }
  @override
  Future<List<UserInfoForOrderEntities>> fetchOrdersData()async {
   final List<Map<String, dynamic>> ordersData =
        await databaseService.fetchAllDocuments(BackendEndpoint.orders);
    final List<UserInfoForOrderEntities> ordersList = ordersData.map((data) {
      return UserInfoForOrderModel.fromMap(data);
    }).toList();
     
    return ordersList;
   
  }
  @override
  Future<String> uploadImage(File image, String documentId) async {
    String imageUrl = await databaseService.uploadImage(
      image: image,
      path: "phones/$documentId",
    );
    return imageUrl;
  }

  @override
  Future<void> addPhoneData(
      Map<String, dynamic> data, String documentId) async {
    await databaseService.addData(
        documentId: documentId, path: BackendEndpoint.addPhone, data: data);
  }

  @override
  Future<void> deleteNewPhoneData(String id) async {
    await databaseService.deleteDocument(
      documentId: id,
      collectionName: BackendEndpoint.newPhone,
    );
    bool imageExists = await databaseService.checkIfImageExists("phones/$id");
    if (imageExists) {
      await databaseService.deleteImageFromStorage("phones/$id");
    }
  }

  Future<void> deleteUsedPhoneData(String id) async {
    await databaseService.deleteDocument(
      documentId: id,
      collectionName: BackendEndpoint.usedPhones,
    );
    bool imageExists = await databaseService.checkIfImageExists("phones/$id");
    if (imageExists) {
      await databaseService.deleteImageFromStorage("phones/$id");
    }
  }
@override
  Future<void> deleteOrderData(String id) async{
    await databaseService.deleteDocument(
      documentId: id,
      collectionName: BackendEndpoint.orders,
    );
  }
  @override
  Future<void> editNewPhonePrice(String phoneId, int newValue) async {
    await databaseService.updateFieldValue(
        collectionName: BackendEndpoint.newPhone,
        docId: phoneId,
        fieldName: BackendEndpoint.priceOfNewPhone,
        newValue: newValue);
  }

  @override
  Future<void> editUsedPhonePrice(String phoneId, int newValue) async {
    await databaseService.updateFieldValue(
        collectionName: BackendEndpoint.usedPhones,
        docId: phoneId,
        fieldName: BackendEndpoint.priceOfUsedPhone,
        newValue: newValue);
  }
  
  
  

}
