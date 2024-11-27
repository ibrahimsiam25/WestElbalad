import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:west_elbalad/core/manager/fetch_user_image/fetch_user_image_cubit.dart';
import 'package:west_elbalad/core/widgets/custom_progress_indicator.dart';
import 'package:west_elbalad/features/user_profile/presentation/views/widgets/user_profile_view_body.dart';

import '../../../../../core/constants/app_assets.dart';

class UserProfileViewBodyBlocBuilder extends StatelessWidget {
  const UserProfileViewBodyBlocBuilder({super.key, this.imageUrl});
final String? imageUrl;
  @override
  Widget build(BuildContext context) {
    return UserProfileViewBody(
              online: imageUrl != null, defaultImage: imageUrl??AppAssets.profile);
  }
}
