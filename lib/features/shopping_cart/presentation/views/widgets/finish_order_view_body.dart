import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/utils/app_styles.dart';
import '../../../../home/data/model/phones_model.dart';
import '../../../../home/domian/entites/phone_entites.dart';
import 'package:west_elbalad/core/constants/app_consts.dart';
import 'package:west_elbalad/core/widgets/custom_button.dart';
import '../../../../../../core/widgets/custom_number_field.dart';
import 'package:west_elbalad/core/widgets/custom_text_field.dart';
import 'package:west_elbalad/core/functions/build_message_bar.dart';
import 'package:west_elbalad/core/functions/calculate_total_price.dart';
import 'package:west_elbalad/core/service/shared_preferences_singleton.dart';
import '../../../../admin/presentation/manager/image_picker/image_picker_cubit.dart';
import '../../../../../core/functions/save_and_get_map_to_list_with_shared_pref.dart';
import 'package:west_elbalad/features/shopping_cart/presentation/manager/finish_order/finish_order_cubit.dart';



class FinishOrderViewBody extends StatefulWidget {
  const FinishOrderViewBody({super.key, });

  @override
  State<FinishOrderViewBody> createState() => _FinishOrderViewBodyState();
}

class _FinishOrderViewBodyState extends State<FinishOrderViewBody> {
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
   late String userName, userPhone, userGovernorate, userLocation;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    int totalPrice= SharedPref.getInt(kTotalPrice);
    return SingleChildScrollView(
      child: Form(
        key: formKey,
        autovalidateMode: autovalidateMode,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: kHorizontalPadding),
          child: Column(
            children: [
              Text("اجمالي سعر الطالبية $totalPrice",style: AppStyles.title,),
              SizedBox(height: 32.0),
              CustomTextFormField(
                onSaved: (value) {
                    userName = value!;
                },
                hintText: "اسم العميل",
                textInputType: TextInputType.text,
              ),
              SizedBox(height: 16.0),
        CustomNumberField(
                onSaved: (value) {
                  userPhone = value!;
                },
                hintText: "رقم الهاتف",
              ),
              SizedBox(height: 16.0),
           CustomTextFormField(
                  onSaved: (value) {
                    userGovernorate = value!;
                },
                hintText: "المحافظة",
                textInputType: TextInputType.text,
              ),
              SizedBox(height: 16.0),
              CustomTextFormField(
                onSaved: (value) {
                  userLocation = value!;
                },
                hintText: "العنوان",
                textInputType: TextInputType.text,
              ), 
              SizedBox(height: 24.0),
              CustomButton(
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                   
                      context.read<FinishOrderCubit>().finishOrder(
                          {

                        "userName": userName,
                        "userPhone": userPhone,
                        "userGovernorate": userGovernorate,
                        "userLocation": userLocation
                      });
                    
                  } else {
                    autovalidateMode = AutovalidateMode.always;
                    setState(() {});
                  }
                },
                text: " تأكيد الطلب ",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
