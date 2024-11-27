import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:west_elbalad/core/errors/failure.dart';
import 'package:west_elbalad/features/user_profile/domian/repos/user_profile_repo.dart';

part 'upload_user_image_state.dart';

class UploadUserImageCubit extends Cubit<UploadUserImageState> {
  UploadUserImageCubit(this.userProfileRepo) : super(UploadUserImageInitial());
  final UserProfileRepo userProfileRepo;

  Future<void> uploadUserImage(File image) async {
    emit(UploadUserImageLoading());
    try {
      await userProfileRepo.uploadUserImage(image);
      emit(UploadUserImageSuccess());
    } on Failure catch (e) {
      emit(UploadUserImageFailure( e.message));
    }
  }
}
