import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:west_elbalad/core/constants/app_colors.dart';
import 'package:west_elbalad/core/constants/app_consts.dart';

class SelectGover extends StatefulWidget {
  const SelectGover({Key? key}) : super(key: key);

  @override
  _SelectGoverState createState() => _SelectGoverState();
}

class _SelectGoverState extends State<SelectGover> {
  String selectedGovernorate = 'المحافظة';

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(kRadius16),
      onTap: showPopupMenu,
      child: Container(
        height: 44.0.h,
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(kRadius16),
          border: Border.all(
            color: Color(0xFFE6E9E9),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(width: 8.0.w),
            Icon(Icons.location_on),
            SizedBox(width: 16.0.w),
            Text(selectedGovernorate),
            Spacer(),
            Icon(Icons.arrow_drop_down),
            SizedBox(width: 16.0.w),
          ],
        ),
      ),
    );
  }

  void showPopupMenu() {
    showMenu<String>(
      color: AppColors.white,
      context: context,
      position: const RelativeRect.fromLTRB(100, 100, 100, 100),
      items: governorates.map((category) {
        return PopupMenuItem<String>(
          value: category,
          child: Text(
            category,
            style: TextStyle(fontSize: 16.sp),
          ),
        );
      }).toList(),
    ).then(
      (value) {
        if (value != null) {
          setState(
            () {
              selectedGovernorate = value;
            },
          );
        }
      },
    );
  }
}
