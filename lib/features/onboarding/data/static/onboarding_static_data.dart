import 'package:flutter/material.dart';
import '../model/onboarding_model.dart';
import 'package:west_elbalad/core/constants/app_colors.dart';
import 'package:west_elbalad/core/constants/app_assets.dart';


List<OnboardingModel> onboardingList = [
  OnboardingModel(
    image: AppAssets.onboarding1,
    title: 'احدث الهواتف بين يديك',
    subtitle: 'استمتع بتشكيلة واسعة من أحدث الهواتف الذكية بأفضل الأسعار.',
    backgroundColor: AppColors.primary,
    textColor: Colors.white, // Bright magenta
  ),
  OnboardingModel(
    image: AppAssets.onboarding2,
    title: 'خدمات الصيانة الموثوقة',
    subtitle: 'نقدم لك خدمة تصليح محترفة لكل أنواع الهواتف بأسرع وقت.',
    backgroundColor: Colors.white,
    textColor: Colors.black, // Bright amber
  ),
  OnboardingModel(
    image: AppAssets.onboarding3,
    title: 'التقسيط أصبح أسهل',
    subtitle: 'امتلك هاتف أحلامك الآن وادفع على دفعات ميسرة دون أي تعقيدات.',
    backgroundColor :Color(0xFF7C4DFF), // Bright green
     textColor: Colors.white,
  ),
  OnboardingModel(
    image: AppAssets.onboarding4,
    title: 'عروض مميزة',
    subtitle: 'استفد من أفضل العروض والخصومات على الهواتف الذكية.',
    backgroundColor: Color(0xFFBD40A6),
     textColor: Colors.white, // Bright purple
  ),
    OnboardingModel(
    image: AppAssets.onboarding4,
    title: "",
    subtitle: '',
    backgroundColor: Colors.white, 
     textColor: Colors.white,// Bright purple
  )
];