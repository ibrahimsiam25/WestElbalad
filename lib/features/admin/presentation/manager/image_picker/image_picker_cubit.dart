import 'dart:io';
import 'package:bloc/bloc.dart';
import '../../../domain/repos/admin_repo.dart';
import '../../../../../core/errors/failure.dart';

part 'image_picker_state.dart';

class ImagePickerCubit extends Cubit<ImagePickerState> {
  ImagePickerCubit(this.adminRepo) : super(ImagePickerInitial(null));
  final AdminRepo adminRepo;
  File? image;
  Future<File?> openImagePickerFromCamera() async {
    try {
      image = await adminRepo.openImagePickerFromCamera();
      emit(ImagePickerInitial(image));
      return image;
    } on Failure catch (_) {
      return null;
    }
  }

  Future<File?> openImagePickerFromGallery() async {
    try {
      image = await adminRepo.openImagePickerFromGallery();
      emit(ImagePickerInitial(image));
      return image;
    } on Failure catch (_) {
      return null;
    }
  }
}
