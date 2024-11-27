import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:west_elbalad/core/widgets/custom_button.dart';
import 'package:west_elbalad/features/user_profile/presentation/manager/upload_user_image/upload_user_image_cubit.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_consts.dart';
import '../../../../../core/functions/build_message_bar.dart';
import '../../../../../core/functions/get_user.dart';
import '../../../../../core/manager/fetch_user_image/fetch_user_image_cubit.dart';
import '../../../../../core/utils/app_styles.dart';
import '../../../../../core/widgets/custom_app_bar.dart';
import '../../../../../core/manager/image_picker/image_picker_cubit.dart';
import '../../../../admin/presentation/views/widgets/add_in_store/image_picker_bloc_builder.dart';

class UserProfileViewBody extends StatelessWidget {
  const UserProfileViewBody({
    super.key,
    required this.online,
    required this.defaultImage,
  });
  final bool online;
  final String defaultImage;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          CustomAppBar(title: "الملف الشخصي"),
          imagePickerBlocBuilder(
            radius: kRadius48,
            width: 150.w,
            height: 150.h,
            online: online,
            defaultImage: defaultImage,
          ),
          SizedBox(height: 16.0.h),
          Text(getUser().name, style: AppStyles.title),
          Text(getUser().email, style: AppStyles.title),
          SizedBox(height: 16.0.h),
          Visibility(
            visible: true,
            child: SizedBox(
              width: 300.w,
              child: CustomButton(
                onPressed: () {
                  if (context.read<ImagePickerCubit>().image != null) {
                    context.read<UploadUserImageCubit>().uploadUserImage(
                        context.read<ImagePickerCubit>().image!);
                      
                  } else {
                    buildMessageBar(
                        context, "الرجاءاختيار صورة جديدة للملف الشخصي");
                  }
                },
                text: "حفظ صورة الملف الشخصي",
                backgroundColor: AppColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
