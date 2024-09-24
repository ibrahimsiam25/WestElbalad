import 'dart:async';
import 'dart:developer';
import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../../core/errors/excptions.dart';
import '../../../../../core/utils/app_styles.dart';
import 'package:west_elbalad/core/utils/app_router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:west_elbalad/core/constants/app_colors.dart';
import 'package:west_elbalad/core/constants/app_assets.dart';
import 'package:west_elbalad/core/constants/app_consts.dart';
import 'package:west_elbalad/core/service/firebase_auth_service.dart';

class VerificationViewBody extends StatefulWidget {
  const VerificationViewBody({super.key});

  @override
  State<VerificationViewBody> createState() => _VerificationViewBodyState();
}

class _VerificationViewBodyState extends State<VerificationViewBody> {
  final auth = FirebaseAuthService();
  late Timer wrapperTimer;
  int _timerSeconds = 0;
  Timer? _timer;
  bool _canResendEmail = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
    wrapperTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      FirebaseAuth.instance.currentUser?.reload();
      if (FirebaseAuth.instance.currentUser!.emailVerified == true) {
        timer.cancel();
        GoRouter.of(context).go(AppRouter.kWrapper);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancel the timer when the widget is disposed.
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _timerSeconds = timer.tick;
        if (_timerSeconds >= 60) {
          _canResendEmail = true; // Enable the button when the timer reaches 60
          _timer?.cancel(); // Stop the timer after reaching 60 seconds
        }
      });
    });
  }

  // Function to resend the verification email
  Future<void> _resendEmailVerification() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null && !user.emailVerified) {
        await user.sendEmailVerification();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('تم ارسال بريد التحقق بنجاح')),
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'too-many-requests') {
        log("Too many requests: ${e.message}");
        throw CustomException(
            message:
                'تم ارسال بريد التحقق بالفعل من قبل يرجي محاوله  تسجيل بعد دقيقة.');
      } else if (e.code == 'network-request-failed') {
        log("Network error: ${e.message}");
        throw CustomException(
            message:
                'تعذر إرسال البريد بسبب مشكلة في الاتصال بالشبكة. يرجى التحقق من اتصالك وحاول مرة أخرى.');
      } else {
        log("FirebaseAuthException: ${e.message}");
        throw CustomException(message: 'فشل في إرسال بريد التحقق.');
      }
    } catch (e) {
      log("Unexpected error: ${e.toString()}");
      throw CustomException(
          message: 'حدث خطأ غير متوقع. حاول مرة أخرى لاحقًا.');
    }

    // Reset the timer and button after resending email
    setState(() {
      _timerSeconds = 0;
      _canResendEmail = false;
    });
    _startTimer(); // Restart the timer after resending the email
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: kHorizontalPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 16.0.h),
            Text(
              'التحقق من البريد الالكتروني',
              style: AppStyles.title,
            ),
            Spacer(),
            LottieBuilder.asset(
              AppAssets.verificationLottie,
            ),
            InkWell(
              borderRadius: BorderRadius.circular(kRadius16),
              onTap: _canResendEmail ? _resendEmailVerification : null,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 8.0.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(kRadius16),
                  color: _canResendEmail ? Colors.green : Colors.red,
                ),
                child: Align(
                  child: Text(
                    "اعادة ارسال البريد الالكتروني للتحقق",
                    style: AppStyles.semiBold16.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 8.0.h),
            if (_timerSeconds < 60)
              Text.rich(
                textAlign: TextAlign.center,
                TextSpan(
                  text: 'اعادة ارسال البريد الالكتروني بعد ',
                  style: AppStyles.subtitle,
                  children: [
                    TextSpan(
                      text: '${60 - _timerSeconds} ثانية ',
                      style: AppStyles.semiBold16.copyWith(
                        color: AppColors.red,
                      ),
                    ),
                  ],
                ),
              ),
            Spacer(flex: 2),
          ],
        ),
      ),
    );
  }
}
