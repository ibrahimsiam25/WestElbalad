import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:west_elbalad/core/constants/app_consts.dart';
import 'package:west_elbalad/core/functions/build_message_bar.dart';
import 'package:west_elbalad/core/widgets/custom_button.dart';
import 'package:west_elbalad/core/widgets/custom_text_field.dart';

import '../../../../../../core/widgets/custom_number_field.dart';
import '../../../manager/add_in_store/edit_in_store_cubit.dart';
import '../../../../../../core/manager/image_picker/image_picker_cubit.dart';

class AddInStoreViewBody extends StatefulWidget {
  const AddInStoreViewBody({super.key});

  @override
  State<AddInStoreViewBody> createState() => _AddInStoreViewBodyState();
}

class _AddInStoreViewBodyState extends State<AddInStoreViewBody> {
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  late String phoneType, phoneName, phoneDescription, phonePrice;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: formKey,
        autovalidateMode: autovalidateMode,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: kHorizontalPadding),
          child: Column(
            children: [
              SizedBox(height: 12.0.h),
              CustomTextFormField(
                onSaved: (value) {
                  phoneType = value!;
                },
                hintText: "اسم الشركة",
                textInputType: TextInputType.text,
              ),
              SizedBox(height: 6.0.h),
              CustomTextFormField(
                onSaved: (value) {
                  phoneName = value!;
                },
                hintText: "نوع الهاتف",
                textInputType: TextInputType.text,
              ),
              SizedBox(height: 6.0.h),
              CustomNumberField(
                onSaved: (value) {
                  phonePrice = value!;
                },
                hintText: "سعر الهاتف",
              ),
              SizedBox(height: 6.0.h),
              CustomTextFormField(
                onSaved: (value) {
                  phoneDescription = value!;
                },
                hintText: "موصفات الهاتف",
                textInputType: TextInputType.text,
              ),
              SizedBox(height: 12.0.h),
              CustomButton(
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                    if (context.read<ImagePickerCubit>().image != null) {
                      context.read<AddInStoreCubit>().uploadPhoneData(
                          context.read<ImagePickerCubit>().image, {
                        "phoneType": phoneType,
                        "phoneName": phoneName,
                        "phoneDescription": phoneDescription,
                        "phonePrice": phonePrice
                      });
                    } else {
                      buildMessageBar(context, "يجب تحديد صورة للهاتف");
                    }
                  } else {
                    autovalidateMode = AutovalidateMode.always;
                    setState(() {});
                  }
                },
                text: "اضافة الهاتف",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
