import 'package:flutter/material.dart';
import '../../../../../core/utils/app_styles.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/functions/get_image_size.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/custom_back_app_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:west_elbalad/features/home/domian/entites/phone_entites.dart';

class PhoneDetailsViewBody extends StatelessWidget {
  const PhoneDetailsViewBody({
    super.key,
    required this.phone,
  });
  final PhoneEntites phone;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          CustomBackAppBar(),
          SizedBox(height: 24.0.h),
          CachedNetworkImage(
            imageUrl: phone.imageUrl,
          
            imageBuilder: (context, imageProvider) {
              return FutureBuilder<Size>(
                future: getImageSize(
                    imageProvider), 
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final size = snapshot.data!;
                    final aspectRatio = size.width / size.height;
                    return SizedBox(
                      width: MediaQuery.of(context).size.width * .8,
                      child: AspectRatio(
                        aspectRatio: aspectRatio,
                        child: Image(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  } else {
                    return Container(); 
                  }
                },
              );
            },
            errorWidget: (context, url, error) => Icon(
              Icons.error,
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * .8,
            child: Text(phone.name, style: AppStyles.title),
          ),
          SizedBox(height: 8.0.h),
          SizedBox(
            width: MediaQuery.of(context).size.width * .8,
            child: Text(
              '${phone.price} جنية',
              style: AppStyles.title.copyWith(
                color: AppColors.red,
              ),
            ),
          ),
          SizedBox(height: 8.0.h),
          SizedBox(
            width: MediaQuery.of(context).size.width * .8,
            child: Text(phone.description,
                 style: AppStyles.subtitle),
          ),
          SizedBox(height: 4.0.h),
        ],
      ),
    );
  }
}


