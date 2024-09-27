import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:west_elbalad/core/constants/app_assets.dart';
import 'package:west_elbalad/core/constants/app_consts.dart';
import 'package:west_elbalad/core/functions/build_message_bar.dart';
import 'package:west_elbalad/core/widgets/custom_app_bar.dart';
import 'package:west_elbalad/features/admin/presentation/views/widgets/add_in_store/image_picker_bloc_builder.dart';

import '../../../manager/add_in_store/edit_in_store_cubit.dart';
import 'add_in_store_view_body.dart';

class AddInStoreViewBodyBlocConsumer extends StatelessWidget {
  const AddInStoreViewBodyBlocConsumer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddInStoreCubit, AddInStoreState>(
      listener: (context, state) {
        if (state is AddInStoreSuccess) {
          buildMessageBar(context, "تمت اضافةالهاتف بنجاح");
          Navigator.pop(context);
        } else if (state is AddInStoreFailure) {
          buildMessageBar(context, state.message);
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
            inAsyncCall: state is AddInStoreLoading ? true : false,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CustomAppBar(
                    title: "اضافة منتج جديد",
                  ),
                  imagePickerBlocBuilder(
                    radius: kRadius48,
                    width: 100.w,
                    height: 100.h,
                    defaultImage: AppAssets.gallery,
                  ),
                  AddInStoreViewBody(),
                  SizedBox(height: 16.0.h),
                ],
              ),
            ));
      },
    );
  }
}
