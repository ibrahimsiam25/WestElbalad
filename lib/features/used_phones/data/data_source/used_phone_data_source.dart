import 'dart:io';
import '../model/used_phone_model.dart';
import '../../../../core/service/data_service.dart';
import '../../../../core/utils/backend_endpoints.dart';
import 'package:west_elbalad/features/used_phones/domian/entities/used_phone_entities.dart';





abstract class UsedPhoneRemoteDataSource {
  Future<List<UsedPhonesEntities>> fetchUsedPhonesData();
Future<String> uploadImage(File image, String documentId);
  Future<void> addPhoneData(Map<String, dynamic> data, String documentId);

}

class UsedPhoneRemoteDataSourceImpl extends UsedPhoneRemoteDataSource {
  final DatabaseService databaseService;
  UsedPhoneRemoteDataSourceImpl({required this.databaseService});
  @override
  Future<List<UsedPhonesEntities>> fetchUsedPhonesData() async {
    var phonesData =
        await databaseService.fetchAllDocuments(BackendEndpoint.usedPhones);
    final List<UsedPhonesEntities> usedPhoneList = phonesData.map((data) {
      return UsedPhoneModel.fromMap(data);
    }).toList();

    return usedPhoneList;
  }
  
  @override
  Future<String> uploadImage(File image, String documentId) async {
    String imageUrl = await databaseService.uploadImage(
      image: image,
      path: "${BackendEndpoint.usedPhones}/$documentId",
    );
    return imageUrl;
  }

  @override
  Future<void> addPhoneData(
      Map<String, dynamic> data, String documentId) async {
    await databaseService.addData(
        documentId: documentId, path: BackendEndpoint.usedPhones, data: data);
  }

}
