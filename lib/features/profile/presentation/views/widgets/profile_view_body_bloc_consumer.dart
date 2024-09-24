import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:west_elbalad/core/widgets/custom_app_bar.dart';
import '../../manager/cubit/profile_cubit.dart';
import '../../../../../core/constants/app_assets.dart';
import 'package:west_elbalad/core/constants/app_consts.dart';
import '../../../../../core/functions/build_message_bar.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:west_elbalad/features/profile/presentation/views/widgets/profile_view_body.dart';
import 'package:west_elbalad/features/admin/presentation/views/widgets/add_in_store/image_picker_bloc_builder.dart';

class ProfileViewBodyBlocConsumer extends StatelessWidget {
  const ProfileViewBodyBlocConsumer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is ProfileSuccess) {
          buildMessageBar(context, "تم تحديث الملف الشخصي بنجاح");
          Navigator.pop(context);
        } else if (state is ProfileFailure) {
          buildMessageBar(context, state.message);
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: state is ProfileLoading ? true : false,
          child: SingleChildScrollView(
            child: Column(
              children: [
                CustomAppBar(
                  title: 'الملف الشخصي',
                  backButton: false,
                ),
                SizedBox(height: 40.0.h),
                imagePickerBlocBuilder(
                  radius: kRadius48,
                  width: 180,
                  height: 180,
                  defaultImage: AppAssets.avatar,
                ),
                SizedBox(height: 32.0.h),
                ProfileViewBody(),
              ],
            ),
          ),
        );
      },
    );
  }
}
