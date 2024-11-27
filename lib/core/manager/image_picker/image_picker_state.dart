part of 'image_picker_cubit.dart';

sealed class ImagePickerState {}

final class ImagePickerInitial extends ImagePickerState {
  File? image;

  ImagePickerInitial(this.image);
}
