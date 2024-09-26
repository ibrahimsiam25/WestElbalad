import 'dart:io';

abstract class DatabaseService {
  Future<void> addData({required String path,required Map<String, dynamic> data,String? documentId});
  Future<Map<String, dynamic>> getData({required String path,required String docuementId,});
  Future<void> addDataInSubCollection({required String collection,required String docId,required String subCollection,required Map<String, dynamic> data,});
  Future<void> deleteDocument({required String collectionName, required String documentId});
  Future<List<Map<String, dynamic>>> fetchAllDocuments(String collectionName);
  Future<bool> checkIfDataExists({required String path, required String docuementId});
  Future<String> uploadImage({required File image, required String path});
  Future<void> deleteImageFromStorage(String imagePath);
  Future<bool> checkIfImageExists(String imagePath);
  Future<void> updateFieldValue({required String collectionName,required String docId,required String fieldName,required dynamic newValue,});
}
