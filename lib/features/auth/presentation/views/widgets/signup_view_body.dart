import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/constants/app_consts.dart';
import 'package:west_elbalad/core/utils/app_styles.dart';
import '../../../../../core/widgets/password_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:west_elbalad/core/constants/app_colors.dart';
import 'package:west_elbalad/core/widgets/custom_button.dart';
import 'package:west_elbalad/core/widgets/custom_text_field.dart';
import 'package:west_elbalad/core/functions/build_message_bar.dart';
import 'package:west_elbalad/features/auth/presentation/cubits/signup_cubits/signup_cubit.dart';
import 'package:west_elbalad/features/auth/presentation/views/widgets/terms_and_conditions.dart';
import 'package:west_elbalad/features/auth/presentation/views/widgets/have_an_account_widget.dart';

class SignupViewBody extends StatefulWidget {
  const SignupViewBody({super.key});

  @override
  State<SignupViewBody> createState() => _SignupViewBodyState();
}

class _SignupViewBodyState extends State<SignupViewBody> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  late String email, userName, password;
  late bool isTermsAccepted = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: kHorizontalPadding),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            autovalidateMode: autovalidateMode,
            child: Column(
              children: [
                SizedBox(height: 16.h),
                Text(
                  "تسجيل حساب جديد",
                  style: AppStyles.title.copyWith(
                    color: AppColors.darkGrey,
                  ),
                ),
                SizedBox(height: 40.0.h),
                //Name
                CustomTextFormField(
                  onSaved: (value) {
                    userName = value!;
                  },
                  hintText: 'الاسم كامل',
                  textInputType: TextInputType.name,
                ),
                SizedBox(height: 8.0.h),
                //Email
                CustomTextFormField(
                    onSaved: (value) {
                      email = value!;
                    },
                    hintText: 'البريد الإلكتروني',
                    textInputType: TextInputType.emailAddress),
                const SizedBox(
                  height: 16,
                ),
                PasswordField(
                  onSaved: (value) {
                    password = value!;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                TermsAndConditionsWidget(
                  onChanged: (value) {
                    isTermsAccepted = value;
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                CustomButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();
                      if (isTermsAccepted) {
                        context
                            .read<SignupCubit>()
                            .createUserWithEmailAndPassword(
                              email,
                              password,
                              userName,
                            );
                      } else {
                      buildMessageBar(
                          context, 'يجب عليك الموافقة على الشروط والإحكام');
                    }
                    }else {
                        setState(() {
                          autovalidateMode = AutovalidateMode.always;
                        });
                      }
                  },
                  text: 'إنشاء حساب جديد',
                ),
                SizedBox(height: 12.0.h),
                const HaveAnAccountWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
