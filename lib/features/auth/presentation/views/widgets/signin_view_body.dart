import 'dart:io';
import 'package:flutter/material.dart';
import 'dont_have_account_widget.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/utils/app_router.dart';
import '../../../../../core/utils/app_styles.dart';
import '../../../../../core/constants/app_assets.dart';
import '../../../../../core/constants/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:west_elbalad/core/constants/app_consts.dart';
import 'package:west_elbalad/core/widgets/custom_button.dart';
import 'package:west_elbalad/core/widgets/password_field.dart';
import 'package:west_elbalad/core/widgets/custom_text_field.dart';
import 'package:west_elbalad/features/auth/presentation/views/widgets/or_divider.dart';
import 'package:west_elbalad/features/auth/presentation/cubits/signin_cubit/signin_cubit.dart';
import 'package:west_elbalad/features/auth/presentation/views/widgets/social_login_button.dart';

class SigninViewBody extends StatefulWidget {
  const SigninViewBody({super.key});

  @override
  State<SigninViewBody> createState() => _SigninViewBodyState();
}

class _SigninViewBodyState extends State<SigninViewBody> {
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  late String email, password;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: kHorizontalPadding,
        ),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            autovalidateMode: autovalidateMode,
            child: Column(
              children: [
                SizedBox(height: 16.h),
                Text(
                  "تسجيل الدخول",
                  style: AppStyles.title.copyWith(
                    color: AppColors.darkGrey,
                  ),
                ),
                SizedBox(height: 40.0.h),
                //Email
                CustomTextFormField(
                  onSaved: (value) {
                    email = value!;
                  },
                  hintText: 'البريد الالكتروني',
                  textInputType: TextInputType.emailAddress,
                ),
                SizedBox(height: 4.0.h),
                //Password
                PasswordField(
                  onSaved: (value) {
                    password = value!;
                  },
                ),
                SizedBox(height: 8.0.h),
                Align(
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                    onTap: () {
                      GoRouter.of(context).push(AppRouter.kforgetPasswordView);
                    },
                    child: Text(
                      'نسيت كلمة المرور؟',
                      style: AppStyles.semiBold16.copyWith(
                        color: AppColors.red,
                        fontSize: 12.sp,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.0.h),
                //Signin
                CustomButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();
                      context.read<SigninCubit>().signin(email, password);
                    } else {
                      autovalidateMode = AutovalidateMode.always;
                      setState(() {});
                    }
                  },
                  text: 'تسجيل دخول',
                ),
                SizedBox(height: 12.0.h),
                const DontHaveAnAccountWidget(),
                SizedBox(height: 20.0.h),
                const OrDivider(),
                SizedBox(height: 20.0.w),
                //Google
                SocialLoginButton(
                  onPressed: () {
                    context.read<SigninCubit>().signinWithGoogle();
                  },
                  image: AppAssets.googleIcon,
                  title: 'التسجيل بواسطة جوجل',
                ),
                //Apple
                if (Platform.isIOS)
                  Column(
                    children: [
                      SizedBox(height: 20.0.w),
                      SocialLoginButton(
                        onPressed: () {
                          context.read<SigninCubit>().signinWithApple();
                        },
                        image: AppAssets.applIcon,
                        title: 'التسجيل بواسطة أبل',
                      ),
                      SizedBox(height: 20.0.w),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
