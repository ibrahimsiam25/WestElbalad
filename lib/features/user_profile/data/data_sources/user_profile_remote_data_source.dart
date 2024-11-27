import 'dart:io';

import 'package:west_elbalad/core/utils/backend_endpoints.dart';

import '../../../../core/service/data_service.dart';

abstract class UserProfileRemoteDataSource {
  Future<String> uploadImage(File image, String documentId);
  Future<void> addUserimagetoFirestore(String documentId, String imageUrl);
  Future<Map<String, dynamic>> getUserImage(String documentId);
}

class UserProfileRemoteDataSourceImpl extends UserProfileRemoteDataSource {
  final DatabaseService databaseService;

  UserProfileRemoteDataSourceImpl({required this.databaseService});
  @override
  Future<String> uploadImage(File image, String documentId) async {
    String imageUrl = await databaseService.uploadImage(
      image: image,
      path: "${BackendEndpoint.profileImage}/$documentId",
    );
    return imageUrl;
  }

  @override
  Future<void> addUserimagetoFirestore(
      String documentId, String imageUrl) async {
    await databaseService.addDataInSubCollection(
        collection: BackendEndpoint.addUserData,
        docId: documentId,
        subCollection: BackendEndpoint.profileImage,
        subDocId: BackendEndpoint.profileImage,
        data: {"imageUrl": imageUrl});
  }

  @override
  Future<Map<String, dynamic>> getUserImage(String documentId) async {
    return await databaseService.getDataFromSubCollection(
        collection: BackendEndpoint.getUsersData,
        docId: documentId,
        subCollection: BackendEndpoint.profileImage,
        subDocId: BackendEndpoint.profileImage);
  }
}
