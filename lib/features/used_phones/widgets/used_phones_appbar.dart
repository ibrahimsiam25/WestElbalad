import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:west_elbalad/core/constants/app_assets.dart';
import 'package:west_elbalad/core/constants/app_colors.dart';
import 'package:west_elbalad/core/constants/app_consts.dart';
import 'package:west_elbalad/core/utils/app_styles.dart';
import 'package:west_elbalad/features/admin/presentation/views/add_in_store_view.dart';

class HomeAppbar extends StatelessWidget {
  const HomeAppbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(kRadius48),
          bottomRight: Radius.circular(kRadius48),
        ),
      ),
      child: Column(
        children: [
          SafeArea(child: SizedBox(height: 16.0.h)),
          Align(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: 24.0.w),
                SizedBox(
                  width: 48.0.w,
                  child: Center(
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const AddInStoreView(),
                            settings: RouteSettings(arguments: 'مستعمل'),
                          ),
                        );
                      },
                      child: Image.asset(
                        width: 28.0.w,
                        height: 28.0.w,
                        AppAssets.add,
                      ),
                    ),
                  ),
                ),
                Spacer(),
                Text(
                  'الأجهزة المستعملة',
                  style: AppStyles.title,
                ),
                Spacer(),
                SizedBox(width: 72.0.w),
              ],
            ),
          ),
          SizedBox(height: 16.0.h),
        ],
      ),
    );
  }
}
