import 'package:flutter/material.dart';
import 'package:west_elbalad/core/utils/app_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:west_elbalad/core/constants/app_colors.dart';


class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({
    super.key, required this.onPressedOne, required this.onPressedTwo, required this.iconOne, required this.iconTwo, required this.textTwo,
  
  });

final void Function() onPressedOne;
final void Function() onPressedTwo;
final IconData iconOne;
final IconData iconTwo;
final String textTwo;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),  // Adds some padding around the bottom bar
      child: Row(
        children: [
    IconButton(
      onPressed: onPressedOne,
      icon: Container(
        decoration: BoxDecoration(
    border: Border.all(color: AppColors.primary, width: 2),  // Border color and thickness
    borderRadius: BorderRadius.circular(10),  // Rounded corners
        ),
        padding: const EdgeInsets.all(8),  // Adds padding inside the border
        child:  Icon(
  iconOne,
    color: AppColors.primary,
    size: 30,  // Icon size
        ),
      ),
    ),  const SizedBox(width: 10), 
                  Expanded(
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                backgroundColor:AppColors.primary ,  // Set your desired button color
                padding: const EdgeInsets.symmetric(vertical: 15), // Adjusts button height
              ),
              onPressed: onPressedTwo,
              icon:  Icon(iconTwo, color: AppColors.white),
              label:  Text(
                textTwo,
                style: AppStyles.title.copyWith(color: AppColors.white, fontSize: 15.sp),  // Set text size
              ),
            ),
          )
        ],
      ),
    );
  }
}
