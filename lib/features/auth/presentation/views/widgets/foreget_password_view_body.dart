import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:west_elbalad/core/widgets/custom_app_bar.dart';
import '../../../../../core/constants/app_consts.dart';
import '../../../../../core/widgets/custom_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/custom_text_field.dart';

class ForgetPasswordViewBody extends StatefulWidget {
  const ForgetPasswordViewBody({super.key});

  @override
  State<ForgetPasswordViewBody> createState() => _ForgetPasswordViewBodyState();
}

class _ForgetPasswordViewBodyState extends State<ForgetPasswordViewBody> {
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  late String email;
  Future<void> resetPassword(BuildContext context) async {
    final String successMessage =
        'تم إرسال بريد إعادة تعيين كلمة المرور إلى $email';
    final String userNotFoundMessage = 'البريد الإلكتروني غير مسجل';
    final String genericErrorMessage = 'حدث خطأ ما. حاول مرة أخرى لاحقًا';
    final String unexpectedErrorMessage = 'حدث خطأ غير متوقع';

    void showSnackBar(String message) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    }

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      showSnackBar(successMessage);
      Navigator.of(context).pop();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showSnackBar(userNotFoundMessage);
      } else {
        showSnackBar(genericErrorMessage);
      }
    } catch (_) {
      showSnackBar(unexpectedErrorMessage);
    } finally {
      formKey.currentState?.reset();
    }
  }

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: formKey,
        autovalidateMode: autovalidateMode,
        child: Column(
          children: [
            CustomAppBar(
              title: 'اعادة تعيين كلمة المرور',
            ),
            SizedBox(height: 16.h),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: kHorizontalPadding,
              ),
              child: Column(
                children: [
                  CustomTextFormField(
                    onSaved: (value) {
                      email = value!;
                    },
                    hintText: 'البريد الالكتروني',
                    textInputType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: 16.0.h),
                  //Signin
                  CustomButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        formKey.currentState!.save();
                        resetPassword(context);
                      } else {
                        autovalidateMode = AutovalidateMode.always;
                        setState(() {});
                      }
                    },
                    text: 'اعادة تعيين كلمة المرور',
                  ),
                  SizedBox(height: 16.0.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
