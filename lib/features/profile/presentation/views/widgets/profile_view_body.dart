import 'package:flutter/material.dart';
import '../../../../../core/constants/app_consts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/custom_text_field.dart';
import 'package:west_elbalad/features/profile/presentation/views/widgets/select_governorate.dart';

class ProfileViewBody extends StatelessWidget {
  const ProfileViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: kHorizontalPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //Name
              CustomTextFormField(
                initialValue: 'ابراهيم فتحي ابراهيم ابراهيم',
                prefixIcon: Icon(
                  Icons.person,
                ),
                textInputType: TextInputType.name,
              ),
              SizedBox(height: 8.0.h),
              //Email
              CustomTextFormField(
                initialValue: 'ibrahimfathi@gmail.com',
                prefixIcon: Icon(
                  Icons.mail,
                ),
                textInputType: TextInputType.emailAddress,
              ),
              SizedBox(height: 8.0.h),
              //Phone
              CustomTextFormField(
                initialValue: '01015757898',
                prefixIcon: Icon(
                  Icons.phone,
                ),
                textInputType: TextInputType.number,
              ),
              SizedBox(height: 8.0.h),
              //Governorate
              SelectGover(),
              SizedBox(height: 8.0.h),
              //Address
              CustomTextFormField(
                hintText: 'العنوان',
                prefixIcon: Icon(
                  Icons.location_city,
                ),
                textInputType: TextInputType.name,
              ),
              SizedBox(height: 16.0.h),
            ],
          ),
        ),
      ),
    );
  }
}
