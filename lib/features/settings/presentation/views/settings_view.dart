import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:west_elbalad/core/widgets/custom_app_bar.dart';
import 'package:west_elbalad/features/settings/presentation/views/widgets/settings_view_body.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0.h),
        child: CustomAppBar(
          title: "الاعدادات",
          backButton: false,
        ),
      ),
      body: SettingsViewBody(),
    );
  }
}
