import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:west_elbalad/core/constants/app_colors.dart';
import 'package:west_elbalad/core/constants/app_consts.dart';
import 'package:west_elbalad/core/utils/app_styles.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({
    super.key,
    required this.onPressedOne,
    required this.onPressedTwo,
    required this.iconOne,
    required this.iconTwo,
    required this.textTwo,

  });

  final void Function() onPressedOne;
  final void Function() onPressedTwo;
  final IconData iconOne;
  final IconData iconTwo;
  final String textTwo;

  @override
  Widget build(BuildContext context) {
    return Material(

 color: Colors.transparent,
    
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(kRadius24),
        topRight: Radius.circular(kRadius24),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.0.w, vertical: 10.0.h),
        child: Row(
          children: [
            Material(
           
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(kRadius24),
                side: const BorderSide(
                  color: AppColors.primary,
                  width: 2,
                ),
              ),
              clipBehavior: Clip.antiAlias,
              child: InkWell(
                onTap: onPressedOne,
                child: Padding(
                  padding: EdgeInsets.all(10.0.w),
                  child: Icon(
                    iconOne,
                    color: AppColors.primary,
                    size: 26.r,
                  ),
                ),
              ),
            ),
            SizedBox(width: 10.0.w),
            Expanded(
              child: SizedBox(
                height: 46.h,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(kRadius24),
                    ),
                    backgroundColor: AppColors.primary,
                    padding: EdgeInsets.symmetric(vertical: 12.0.h),
                    elevation: 0,
                  ),
                  onPressed: onPressedTwo,
                  icon: Icon(iconTwo, color: AppColors.white, size: 20.r),
                  label: Text(
                    textTwo,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppStyles.title.copyWith(
                      color: AppColors.white,
                      fontSize: 15.0.sp,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
