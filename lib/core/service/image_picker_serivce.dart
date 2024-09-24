import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ImagePickerService {
  final ImagePicker imagePicker = ImagePicker();

  Future<File?> uploadImageFromGallery() async {
    final pickedImage =
        await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      return File(pickedImage.path);
  
    } else {
      return null;
    }
  }

  Future<File?> uploadImageFromCamera() async {
    final pickedImage =
      await imagePicker.pickImage(source: ImageSource.camera);
    if (pickedImage != null) {
     return  File(pickedImage.path);
    
    } else {
      return null;
    }
  }

}