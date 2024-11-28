import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:west_elbalad/core/manager/fetch_user_image/fetch_user_image_cubit.dart';
import 'package:west_elbalad/features/user_profile/presentation/manager/upload_user_image/upload_user_image_cubit.dart';
import 'package:west_elbalad/features/user_profile/presentation/views/widgets/user_profile_view_body.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/functions/build_message_bar.dart';
import '../../../../core/service/get_it_service.dart';
import '../../../../core/manager/image_picker/image_picker_cubit.dart';
import '../../domian/repos/user_profile_repo.dart';

class UserProfileView extends StatelessWidget {
  const UserProfileView({super.key, this.imageUrl});
  final String? imageUrl;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) => UploadUserImageCubit(
                    getIt.get<UserProfileRepo>(),
                  )),
          BlocProvider(
            create: (context) => getIt<ImagePickerCubit>(),
          ),
        ],
        child: BlocConsumer<UploadUserImageCubit, UploadUserImageState>(
          listener: (context, state) {
            if (state is UploadUserImageSuccess) {
              context.read<FetchUserImageCubit>().fetchUserImage();
              buildMessageBar(context, "تم تحديث الصورة بنجاح");
              Navigator.pop(context);
            }
            if (state is UploadUserImageFailure) {
              buildMessageBar(context, state.errorMessage);
            }
          },
          builder: (context, state) {
            return ModalProgressHUD(
                inAsyncCall: state is UploadUserImageLoading ? true : false,
                child: UserProfileViewBody(
                    online: imageUrl != null,
                    defaultImage: imageUrl ?? AppAssets.profile));
          },
        ),
      ),
    );
  }
}
