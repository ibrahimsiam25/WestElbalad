import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:west_elbalad/core/constants/app_consts.dart';
import '../../../../../../core/widgets/custom_show_image.dart';
import '../../../manager/image_picker/image_picker_cubit.dart';
import '../../../../../../core/widgets/show_image_picker_options.dart';

class imagePickerBlocBuilder extends StatelessWidget {
  const imagePickerBlocBuilder({
    super.key,
    required this.radius,
    required this.width,
    required this.height,
    required this.defaultImage,
  });
  final double radius;
  final double width;
  final double height;
  final String defaultImage;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ImagePickerCubit, ImagePickerState>(
      builder: (context, state) {
        if (state is ImagePickerInitial) {
          return InkWell(
              borderRadius: BorderRadius.circular(kRadius88),
              onTap: () {
                showImagePickerOptions(
                  context: context,
                  onCameraPressed: () async {
                    context
                        .read<ImagePickerCubit>()
                        .openImagePickerFromCamera();
                  },
                  onGalleryPressed: () async {
                    context
                        .read<ImagePickerCubit>()
                        .openImagePickerFromGallery();
                  },
                );
              },
              child: CustomShowImage(
                image: context.read<ImagePickerCubit>().image,
                width: width,
                height: height,
                defaultImage: defaultImage,
              ));
        } else {
          return Container();
        }
      },
    );
  }
}
