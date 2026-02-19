import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/manager/fetch_user_image/fetch_user_image_cubit.dart';
import '../../../../../core/utils/app_router.dart';
import '../../../../../core/utils/app_styles.dart';
import '../../../../../core/functions/get_user.dart';
import '../../../../../core/constants/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:west_elbalad/core/constants/app_assets.dart';
import 'package:west_elbalad/core/widgets/custom_clippath.dart';

class CustomHomeAppBar extends StatelessWidget {
  const CustomHomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: CustomClipperPath(),
      child: Container(
        height: 180.0.h,
        color: AppColors.primary,
        child: Center(
          child: ListTile(
            trailing: Container(
              width: 45.0.w,
              height: 45.0.w,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.white,
              ),
              child: InkWell(
                onTap: () {
                  GoRouter.of(context).push(AppRouter.kShoppingCartView);
                },
                child: Icon(
                  Icons.shopping_cart,
                  size: 25.r,
                  color: AppColors.primary,
                ),
              ),
            ),
            leading: BlocBuilder<FetchUserImageCubit, FetchUserImageState>(
              builder: (context, state) {
                if (state is FetchUserImageSuccess &&
                    state.imageUrl.isNotEmpty &&
                    Uri.tryParse(state.imageUrl)?.host.isNotEmpty == true) {
                  return GestureDetector(
                    onTap: () {
                      GoRouter.of(context).push(AppRouter.kUserProfileView,
                          extra: state.imageUrl);
                    },
                    child: CircleAvatar(
                      radius: 25.0.r,
                      backgroundImage: NetworkImage(state.imageUrl),
                    ),
                  );
                } else {
                  return GestureDetector(
                    onTap: () {
                      GoRouter.of(context).push(AppRouter.kUserProfileView);
                    },
                    child: Image.asset(
                      AppAssets.profile,
                    ),
                  );
                }
              },
            ),
            title: Text(
              "صباح الخير !..",
              style: AppStyles.semiBold16.copyWith(color: AppColors.white),
            ),
            subtitle: Text(getUser().name,
                style: AppStyles.title.copyWith(color: AppColors.white)),
          ),
        ),
      ),
    );
  }
}
