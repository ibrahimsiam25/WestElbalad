import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
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
  bool _isLoading = false;
  late String email;

  Future<void> resetPassword(BuildContext context) async {
    void showSnackBar(String message) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(message)));
    }

    setState(() => _isLoading = true);
    try {
      await Supabase.instance.client.auth.resetPasswordForEmail(email);
      showSnackBar('تم إرسال بريد إعادة تعيين كلمة المرور إلى $email');
      if (mounted) Navigator.of(context).pop();
    } on AuthException catch (e) {
      final msg = e.message.toLowerCase();
      if (msg.contains('user not found') || msg.contains('unable to find')) {
        showSnackBar('البريد الإلكتروني غير مسجل');
      } else if (msg.contains('rate limit') || msg.contains('too many')) {
        showSnackBar('تم إرسال البريد مسبقاً. يرجى المحاولة بعد دقيقة.');
      } else {
        showSnackBar('حدث خطأ ما. حاول مرة أخرى لاحقًا');
      }
    } catch (_) {
      showSnackBar('حدث خطأ غير متوقع');
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
        formKey.currentState?.reset();
      }
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
                      if (_isLoading) return;
                      if (formKey.currentState!.validate()) {
                        formKey.currentState!.save();
                        resetPassword(context);
                      } else {
                        autovalidateMode = AutovalidateMode.always;
                        setState(() {});
                      }
                    },
                    text: _isLoading
                        ? 'جاري الإرسال...'
                        : 'اعادة تعيين كلمة المرور',
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
