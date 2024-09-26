import 'add_used_phone_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:west_elbalad/core/constants/app_assets.dart';
import 'package:west_elbalad/core/constants/app_consts.dart';
import 'package:west_elbalad/core/functions/build_message_bar.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:west_elbalad/features/used_phones/presentation/manager/add_used_phone/add_used_phone_cubit.dart';
import 'package:west_elbalad/features/admin/presentation/views/widgets/add_in_store/image_picker_bloc_builder.dart';


class AddUsedPhoneViewBodyBlocConsumer extends StatelessWidget {
  const AddUsedPhoneViewBodyBlocConsumer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddUsedPhoneCubit, AddUsedPhoneState>(
      listener: (context, state) {
        if (state is AddUsedPhoneSuccess) {
          buildMessageBar(context, "تمت اضافةالهاتف المستعمل بنجاح");
          Navigator.pop(context);
        } else if (state is AddUsedPhoneFailure) {
          buildMessageBar(context, state.message);
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
            inAsyncCall: state is AddUsedPhoneLoading ? true : false,
            child: SingleChildScrollView(
              child: Column(
                children: [
                    SizedBox(height: 100.0.h),
                  imagePickerBlocBuilder(
                      radius: kRadius48,
                      width: 150.w,
                      height: 150.h,
                      defaultImage: AppAssets.gallery),
                  AddInStoreViewBody(),
                  SizedBox(height: 16.0.h),
                ],
              ),
            ));
      },
    );
  }
}
