import 'package:flutter/material.dart';
import '../../../domian/repos/home_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../manager/offers/offers_cubit.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_consts.dart';
import '../../../../../core/service/get_it_service.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';


class OffersList extends StatelessWidget {
  const OffersList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OffersCubit(
        getIt<HomeRepo>(),
      )..loadImagesFromFirebase(),
      child: SizedBox(
        height: 148.0.h,
        child: BlocBuilder<OffersCubit, OffersState>(
          builder: (context, state) {
            if (state is OffersSuccess) {
              return CarouselSlider(
                  options: CarouselOptions(
                    height: 148.0.h,
                    viewportFraction: 0.75,
                    enableInfiniteScroll: true,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 2),
                    autoPlayAnimationDuration:
                        const Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true,
                    scrollDirection: Axis.horizontal,
                  ),
                  items: List.generate(state.imageUrls.length, (index) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(kRadius24),
                      child: CachedNetworkImage(
                        fit: BoxFit.fill,
                        height: 148.0.h,
                        imageUrl: state.imageUrls[index],
                        placeholder: (context, url) => CustomSkeletonizer(
                          height: 148.0.h,
                          aspectRatio: 16 / 9,
                        ),
                        errorWidget: (context, url, error) => Icon(
                          Icons.error,
                        ),
                      ),
                    );
                  }));
            } else if (state is OffersFailure) {
              return Center(child: Text(state.message));
            } else {
              return ListView.builder(
                padding: EdgeInsets.symmetric(
                  horizontal: kHorizontalPadding,
                  vertical: 16.0,
                ),
                scrollDirection: Axis.horizontal,
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: CustomSkeletonizer(
                      height: MediaQuery.of(context).size.height * 0.3,
                      aspectRatio: 1321 / 736,
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}

class CustomSkeletonizer extends StatelessWidget {
  const CustomSkeletonizer({
    super.key,
    required this.height,
    required this.aspectRatio,
  });
  final double height;
  final double aspectRatio;
  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      containersColor: AppColors.lightGrey,
      child: SizedBox(
          height: height,
          child: AspectRatio(
              aspectRatio: aspectRatio,
              child: Container(
                  decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(16), // الزوايا المنحنية
              )))),
    );
  }
}
