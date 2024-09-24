import 'package:flutter/material.dart';
import 'package:west_elbalad/features/splash/presentation/views/widgets/splash_view_body.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF2F0F4),
      body: SplashViewBody(),
    );
  }
}
