import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:west_elbalad/core/constants/app_colors.dart';
import 'package:west_elbalad/core/widgets/custom_button.dart';
import 'package:west_elbalad/features/user_profile/presentation/manager/upload_user_image/upload_user_image_cubit.dart';

import '../../../../../core/constants/app_consts.dart';
import '../../../../../core/functions/build_message_bar.dart';
import '../../../../../core/functions/get_user.dart';
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
    final user = getUser();
    return ListView(
      children: [
        // Gradient header
        Container(
          width: double.infinity,
          padding: EdgeInsets.only(top: 50.h, bottom: 30.h),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.primary.withOpacity(0.15),
                Colors.white,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            children: [
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Container(
                    width: 110.r,
                    height: 110.r,
                    padding: const EdgeInsets.all(
                        3), // Add padding for border separation
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.primary,
                        width: 2.0,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withOpacity(0.2),
                          blurRadius: 16,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ClipOval(
                      child: imagePickerBlocBuilder(
                        radius: kRadius48,
                        width: 104.r, // Adjusted for padding
                        height: 104.r,
                        online: online,
                        defaultImage: defaultImage,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 28.r,
                      height: 28.r,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                      child: Icon(Icons.camera_alt_rounded,
                          color: Colors.white, size: 14.r),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12.h),
              Text(
                user.name,
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.black,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                user.email,
                style: TextStyle(
                  fontSize: 12.sp,
                  color: AppColors.darkGrey,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [
              _InfoTile(
                icon: Icons.person_outline_rounded,
                label: 'الاسم',
                value: user.name,
                color: AppColors.primary,
              ),
              SizedBox(height: 10.h),
              _InfoTile(
                icon: Icons.email_outlined,
                label: 'البريد الإلكتروني',
                value: user.email,
                color: const Color(0xFF1877F2),
              ),
              SizedBox(height: 24.h),
              CustomButton(
                onPressed: () {
                  if (context.read<ImagePickerCubit>().image != null) {
                    context.read<UploadUserImageCubit>().uploadUserImage(
                        context.read<ImagePickerCubit>().image!);
                  } else {
                    buildMessageBar(
                        context, 'الرجاء اختيار صورة جديدة للملف الشخصي');
                  }
                },
                text: 'حفظ صورة الملف الشخصي',
                backgroundColor: AppColors.primary,
              ),
              SizedBox(height: 24.h),
            ],
          ),
        ),
      ],
    );
  }
}

class _InfoTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _InfoTile({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 40.r,
            height: 40.r,
            decoration: BoxDecoration(
              color: color.withOpacity(0.12),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(icon, color: color, size: 20.r),
          ),
          SizedBox(width: 14.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 11.sp,
                  color: AppColors.darkGrey,
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                value,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.black,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
