import 'dart:io';


abstract class UserProfileRepo {
  Future<void> uploadUserImage(File image);

}