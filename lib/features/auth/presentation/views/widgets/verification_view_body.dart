import 'dart:async';
import 'dart:developer';
import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../../core/utils/app_styles.dart';
import 'package:west_elbalad/core/utils/app_router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:west_elbalad/core/constants/app_colors.dart';
import 'package:west_elbalad/core/constants/app_assets.dart';
import 'package:west_elbalad/core/constants/app_consts.dart';

class VerificationViewBody extends StatefulWidget {
  const VerificationViewBody({super.key});

  @override
  State<VerificationViewBody> createState() => _VerificationViewBodyState();
}

class _VerificationViewBodyState extends State<VerificationViewBody> {
  late Timer _pollTimer;
  int _timerSeconds = 0;
  Timer? _countdownTimer;
  bool _canResendEmail = false;

  String get _pendingEmail =>
      Supabase.instance.client.auth.currentUser?.email ?? '';

  @override
  void initState() {
    super.initState();
    _startCountdown();
    // Poll every 5 seconds to check if email has been confirmed
    _pollTimer = Timer.periodic(const Duration(seconds: 5), (_) async {
      await Supabase.instance.client.auth.refreshSession();
      final user = Supabase.instance.client.auth.currentUser;
      if (user?.emailConfirmedAt != null) {
        _pollTimer.cancel();
        if (mounted) {
          GoRouter.of(context).go(AppRouter.kWrapper);
        }
      }
    });
  }

  @override
  void dispose() {
    _pollTimer.cancel();
    _countdownTimer?.cancel();
    super.dispose();
  }

  void _startCountdown() {
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _timerSeconds = timer.tick;
        if (_timerSeconds >= 60) {
          _canResendEmail = true;
          _countdownTimer?.cancel();
        }
      });
    });
  }

  Future<void> _resendEmailVerification() async {
    try {
      if (_pendingEmail.isNotEmpty) {
        await Supabase.instance.client.auth.resend(
          type: OtpType.signup,
          email: _pendingEmail,
        );
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('?? ????? ???? ?????? ?????')),
          );
        }
      }
    } on AuthException catch (e) {
      final msg = e.message.toLowerCase();
      log('AuthException resend: ${e.message}');
      String errorMsg;
      if (msg.contains('rate limit') || msg.contains('too many')) {
        errorMsg =
            '?? ????? ???? ?????? ?????? ?? ???. ???? ???????? ??? ?????.';
      } else {
        errorMsg = '??? ?? ????? ???? ??????.';
      }
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(errorMsg)));
      }
    } catch (e) {
      log('Unexpected error resendEmail: ${e.toString()}');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('??? ??? ??? ?????. ???? ??? ???? ??????.')),
        );
      }
    }
    setState(() {
      _timerSeconds = 0;
      _canResendEmail = false;
    });
    _startCountdown();
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
              '?????? ?? ?????? ??????????',
              style: AppStyles.title,
            ),
            const Spacer(),
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
                    '????? ????? ?????? ?????????? ??????',
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
                  text: '????? ????? ?????? ?????????? ??? ',
                  style: AppStyles.subtitle,
                  children: [
                    TextSpan(
                      text: '${60 - _timerSeconds} ????? ',
                      style: AppStyles.semiBold16.copyWith(
                        color: AppColors.red,
                      ),
                    ),
                  ],
                ),
              ),
            const Spacer(flex: 2),
          ],
        ),
      ),
    );
  }
}
