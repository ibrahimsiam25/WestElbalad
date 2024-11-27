import 'dart:io';
import 'dart:developer';
import '../errors/excptions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:west_elbalad/core/service/data_service.dart';

class FireStoreService implements DatabaseService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseStorage storage = FirebaseStorage.instance;

  @override
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

  @override
  Future<Map<String, dynamic>> getData(
      {required String path, required String docuementId}) async {
    var data = await firestore.collection(path).doc(docuementId).get();
    return data.data() as Map<String, dynamic>;
  }

  @override
  Future<void> addDataInSubCollection({
    required String collection,
    required String docId,
    required String subCollection,
    required String subDocId,
    required Map<String, dynamic> data,
  }) async {
    try {
      await firestore
          .collection(collection)
          .doc(docId)
          .collection(subCollection)
          .doc(subDocId)
          .set(data);
    } on FirebaseException catch (e) {
      // Handle Firestore-specific errors
      switch (e.code) {
        case 'permission-denied':
          log("Permission denied: ${e.message}");
          throw CustomException(
            message: 'ليس لديك صلاحية للوصول إلى هذه البيانات.',
          );
        case 'network-request-failed':
          log("Network error: ${e.message}");
          throw CustomException(
            message:
                'تعذر الوصول إلى البيانات بسبب مشكلة في الشبكة. يرجى التحقق من اتصالك.',
          );
        default:
          log("FirebaseException: ${e.message}");
          throw CustomException(
            message: 'حدث خطأ أثناء إضافة البيانات إلى Firestore.',
          );
      }
    } catch (e) {
      // Handle any other exceptions
      log("Unexpected error: ${e.toString()}");
      throw CustomException(
        message: 'حدث خطأ غير متوقع. حاول مرة أخرى لاحقًا.',
      );
    }
  }

  @override
  Future<bool> checkIfDataExists(
      {required String path, required String docuementId}) async {
    var data = await firestore.collection(path).doc(docuementId).get();
    return data.exists;
  }

  @override
  Future<List<Map<String, dynamic>>> fetchAllDocuments(
      String collectionName) async {
    try {
      final querySnapshot = await firestore.collection(collectionName).get();

      final documents = querySnapshot.docs.map((doc) => doc.data()).toList();
      return documents;
    } on FirebaseException catch (e) {
      // Handle Firestore-specific errors
      switch (e.code) {
        case 'permission-denied':
          log("Permission denied: ${e.message}");
          throw CustomException(
            message: 'ليس لديك صلاحية للوصول إلى هذه البيانات.',
          );
        case 'network-request-failed':
          log("Network error: ${e.message}");
          throw CustomException(
            message:
                'تعذر الوصول إلى البيانات بسبب مشكلة في الشبكة. يرجى التحقق من اتصالك.',
          );
        default:
          log("FirebaseException: ${e.message}");
          throw CustomException(
            message: 'حدث خطأ أثناء جلب البيانات من Firestore.',
          );
      }
    } catch (e) {
      // Handle any other exceptions
      log("Unexpected error: ${e.toString()}");
      throw CustomException(
        message: 'حدث خطأ غير متوقع. حاول مرة أخرى لاحقًا.',
      );
    }
  }

  @override
  Future<String> uploadImage(
      {required File image, required String path}) async {
    try {
      var refStorage = storage.ref(path);
      await refStorage.putFile(image);
      var url = await refStorage.getDownloadURL();
      return url;
    } on FirebaseException catch (e) {
      switch (e.code) {
        case 'permission-denied':
          log("Permission denied: ${e.message}");
          throw CustomException(
            message: 'ليس لديك صلاحية للوصول إلى هذه البيانات.',
          );
        case 'network-request-failed':
          log("Network error: ${e.message}");
          throw CustomException(
            message:
                'تعذر الوصول إلى البيانات بسبب مشكلة في الشبكة. يرجى التحقق من اتصالك.',
          );
        default:
          log("FirebaseException: ${e.message}");
          throw CustomException(
            message: 'حدث خطأ أثناء جلب البيانات من Firestore.',
          );
      }
    } catch (e) {
      // Handle any other exceptions
      log("Unexpected error: ${e.toString()}");
      throw CustomException(
        message: 'حدث خطأ غير متوقع. حاول مرة أخرى لاحقًا.',
      );
    }
  }

  @override
  Future<void> deleteDocument(
      {required String collectionName, required String documentId}) async {
    try {
      // Delete the document from the specified collection
      await firestore.collection(collectionName).doc(documentId).delete();
      print(
          "Document deleted successfully from $collectionName. Document ID: $documentId");
      log("Document with ID: $documentId successfully deleted from $collectionName.");
    } on FirebaseException catch (e) {
      // Handle Firestore-specific errors
      log("Error deleting document: ${e.message}");
      switch (e.code) {
        case 'permission-denied':
          throw CustomException(
            message: 'ليس لديك صلاحية لحذف هذه البيانات.',
          );
        case 'not-found':
          throw CustomException(
            message: 'المستند غير موجود.',
          );
        default:
          throw CustomException(
            message: 'حدث خطأ أثناء حذف المستند.',
          );
      }
    } catch (e) {
      // Handle any other errors
      log("Unexpected error: ${e.toString()}");
      throw CustomException(
        message: 'حدث خطأ غير متوقع. حاول مرة أخرى لاحقًا.',
      );
    }
  }

  @override
  Future<void> deleteImageFromStorage(String imagePath) async {
    try {
      // Create a reference to the file to delete
      Reference storageReference =
          FirebaseStorage.instance.ref().child(imagePath);

      // Delete the file
      await storageReference.delete();

      print('File deleted successfully');
    } on FirebaseException catch (e) {
      // Handle Firebase-specific errors
      print('Failed to delete file: ${e.message}');
      throw CustomException(message: 'تعذر حذف الصورة: ${e.message}');
    } catch (e) {
      // Handle other potential errors
      print('An unexpected error occurred: $e');
      throw CustomException(message: 'حدث خطأ غير متوقع أثناء حذف الصورة.');
    }
  }

  @override
  Future<bool> checkIfImageExists(String imagePath) async {
    try {
      Reference storageReference = storage.ref().child(imagePath);

      // Try to fetch the download URL (or use storageReference.getMetadata() for metadata)
      await storageReference.getDownloadURL();

      // If successful, the image exists
      return true;
    } on FirebaseException catch (e) {
      // Handle the case where the image does not exist
      if (e.code == 'object-not-found') {
        print('Image does not exist in Firebase Storage.');
        return false;
      } else {
        // Handle other Firebase exceptions
        print('FirebaseException: ${e.message}');
        return false;
      }
    } catch (e) {
      // Handle any other unexpected errors
      print('An unexpected error occurred: $e');
      return false;
    }
  }

  @override
  Future<void> updateFieldValue({
    required String collectionName,
    required String docId,
    required String fieldName,
    required dynamic newValue,
  }) async {
    try {
      // Reference the document in the specified collection
      DocumentReference docRef =
          FirebaseFirestore.instance.collection(collectionName).doc(docId);

      // Update the specific field with the new value
      await docRef.update({fieldName: newValue});

      log("Field updated successfully in $collectionName/$docId: $fieldName = $newValue");
    } on FirebaseException catch (e) {
      // Handle Firestore-specific errors
      switch (e.code) {
        case 'permission-denied':
          log("Permission denied: ${e.message}");
          throw CustomException(
            message: 'ليس لديك صلاحية لتحديث هذه البيانات.',
          );
        case 'not-found':
          log("Document not found: ${e.message}");
          throw CustomException(
            message: 'لم يتم العثور على المستند.',
          );
        case 'network-request-failed':
          log("Network error: ${e.message}");
          throw CustomException(
            message:
                'تعذر تحديث البيانات بسبب مشكلة في الشبكة. يرجى التحقق من اتصالك.',
          );
        default:
          log("FirebaseException: ${e.message}");
          throw CustomException(
            message: 'حدث خطأ أثناء تحديث البيانات في Firestore.',
          );
      }
    } catch (e) {
      // Handle any other exceptions
      log("Unexpected error: ${e.toString()}");
      throw CustomException(
        message: 'حدث خطأ غير متوقع. حاول مرة أخرى لاحقًا.',
      );
    }
  }
  
  @override
  Future<Map<String, dynamic>> getDataFromSubCollection({required String collection, required String docId, required String subCollection, required String subDocId}) async{
    var data = await firestore
    .collection(collection)
    .doc(docId)
    .collection(subCollection)
    .doc(subDocId)
    .get();
    return data.data() as Map<String, dynamic>;
  }
}
