import 'dart:io';


abstract class UserProfileRepo {
  Future<void> uploadUserImage(File image);
 Future<Map<String, dynamic>> getUserImage(String documentId);
}