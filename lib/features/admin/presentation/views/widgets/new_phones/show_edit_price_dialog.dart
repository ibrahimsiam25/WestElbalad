import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:west_elbalad/core/constants/app_colors.dart';
import 'package:west_elbalad/core/constants/app_consts.dart';
import 'package:west_elbalad/core/utils/app_styles.dart';

void showEditPriceDialog({
  required BuildContext context,
  required Function(int price) onPriceSaved,
}) {
  final TextEditingController _controller = TextEditingController();

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(
          'تعديل سعر الهاتف',
          textAlign: TextAlign.center,
          style: AppStyles.title,
        ),
        contentPadding: EdgeInsets.only(
            top: 20.0.h, right: 16.0.w, left: 16.0.w, bottom: 8.0.h),
        content: SizedBox(
          height: 40.0.h,
          child: TextField(
            controller: _controller,
            keyboardType: TextInputType.number, // Only accept numbers
            decoration: InputDecoration(
              hintText: 'أدخل السعر',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(kRadius24),
              ),
            ),
          ),
        ),
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(kRadius24),
              ),
              backgroundColor: AppColors.red,
              padding: EdgeInsets.only(bottom: 4.0.h),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              'رجوع',
              style: AppStyles.semiBold16.copyWith(
                color: AppColors.white,
              ),
            ),
          ),
          TextButton(
            style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(kRadius24),
              ),
              backgroundColor: AppColors.lightGreen,
              padding: EdgeInsets.only(bottom: 4.0.h),
            ),
            onPressed: () {
              final String input = _controller.text;
              if (input.isEmpty) {
                // Show a message if the text field is empty
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('يرجى إدخال سعر صحيح')),
                );
              } else {
                final int? price = int.tryParse(input);
                if (price != null) {
                  onPriceSaved(price);
                  Navigator.of(context).pop();
                } else {
                  // Show a message if the input is not a valid integer
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('يرجى إدخال رقم صحيح')),
                  );
                }
              }
            },
            child: Text(
              "حفظ",
              style: AppStyles.semiBold16.apply(
                color: AppColors.white,
              ),
            ),
          ),
        ],
      );
    },
  );
}
