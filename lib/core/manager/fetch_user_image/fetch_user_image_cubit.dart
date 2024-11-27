import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:west_elbalad/core/utils/backend_endpoints.dart';
import 'package:west_elbalad/features/user_profile/domian/repos/user_profile_repo.dart';

import '../../errors/failure.dart';
import '../../functions/get_user.dart';

part 'fetch_user_image_state.dart';

class FetchUserImageCubit extends Cubit<FetchUserImageState> {
  FetchUserImageCubit(this.userProfileRepo) : super(FetchUserImageInitial());
  final UserProfileRepo userProfileRepo ;

  Future<void> fetchUserImage() async {
    emit(FetchUserImageLoading());
    try {
      final image = await userProfileRepo.getUserImage(getUser().uId);
      emit(FetchUserImageSuccess(image[BackendEndpoint.imageUrl]));
    } on Failure catch (e) {
      emit(FetchUserImageFailure(message: e.message));
    }
  }
}
