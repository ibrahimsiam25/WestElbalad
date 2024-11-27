part of 'upload_user_image_cubit.dart';

@immutable
abstract class UploadUserImageState {}

class UploadUserImageInitial extends UploadUserImageState {}

class UploadUserImageSuccess extends UploadUserImageState {}

class UploadUserImageFailure extends UploadUserImageState {
  final String errorMessage;
  UploadUserImageFailure(this.errorMessage);
}

class UploadUserImageLoading extends UploadUserImageState {}
