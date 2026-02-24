import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:west_elbalad/core/constants/app_colors.dart';
import 'package:west_elbalad/core/constants/app_consts.dart';
import 'package:west_elbalad/core/service/get_it_service.dart';
import 'package:west_elbalad/core/utils/app_styles.dart';
import 'package:west_elbalad/core/widgets/custom_app_bar.dart';
import 'package:west_elbalad/core/widgets/show_delete_confirmation_dialog.dart';
import 'package:west_elbalad/features/admin/domain/entities/offer_entity.dart';
import 'package:west_elbalad/features/admin/domain/repos/admin_repo.dart';
import 'package:west_elbalad/features/admin/presentation/manager/manage_offers/manage_offers_cubit.dart';
import 'package:west_elbalad/core/manager/image_picker/image_picker_cubit.dart';

class ManageOffersView extends StatelessWidget {
  const ManageOffersView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => ManageOffersCubit(getIt<AdminRepo>())..fetchOffers(),
        ),
        BlocProvider(
          create: (_) => ImagePickerCubit(getIt<AdminRepo>()),
        ),
      ],
      child: const _ManageOffersBody(),
    );
  }
}

class _ManageOffersBody extends StatelessWidget {
  const _ManageOffersBody();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ManageOffersCubit, ManageOffersState>(
        listener: (context, state) {
          if (state is ManageOffersActionSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('تمت العملية بنجاح ✅'),
                backgroundColor: Colors.green,
              ),
            );
          } else if (state is ManageOffersFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          final List<OfferEntity> offers;
          final bool isActionLoading;

          if (state is ManageOffersSuccess) {
            offers = state.offers;
            isActionLoading = false;
          } else if (state is ManageOffersActionLoading) {
            offers = state.offers;
            isActionLoading = true;
          } else if (state is ManageOffersLoading) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          } else if (state is ManageOffersFailure) {
            return Scaffold(
              body: Column(
                children: [
                  const CustomAppBar(title: 'إدارة العروض'),
                  Center(
                    child: Text(state.message,
                        style: const TextStyle(color: Colors.red)),
                  ),
                ],
              ),
            );
          } else {
            offers = [];
            isActionLoading = false;
          }

          return Stack(
            children: [
              SingleChildScrollView(
                padding: EdgeInsets.only(bottom: 100.h),
                child: Column(
                  children: [
                    const CustomAppBar(title: 'إدارة العروض'),
                    SizedBox(height: 8.h),
                    if (offers.isEmpty)
                      Padding(
                        padding: EdgeInsets.all(40.w),
                        child: Text(
                          'لا توجد عروض حالياً\nاضغط + لإضافة صورة عرض جديدة',
                          textAlign: TextAlign.center,
                          style: AppStyles.semiBold16
                              .copyWith(color: AppColors.darkGrey),
                        ),
                      )
                    else
                      ...List.generate(offers.length, (i) {
                        final offer = offers[i];
                        return Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: kHorizontalPadding, vertical: 6.h),
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(kRadius24),
                                child: CachedNetworkImage(
                                  imageUrl: offer.imageUrl,
                                  width: double.infinity,
                                  height: 160.h,
                                  fit: BoxFit.cover,
                                  placeholder: (_, __) => Container(
                                    height: 160.h,
                                    color: AppColors.lightGrey,
                                  ),
                                  errorWidget: (_, __, ___) =>
                                      const Icon(Icons.broken_image),
                                ),
                              ),
                              Positioned(
                                top: 8.h,
                                left: 8.w,
                                child: GestureDetector(
                                  onTap: () {
                                    showDeleteConfirmationDialog(
                                      context,
                                      'هل تريد حذف هذه الصورة؟',
                                      () => context
                                          .read<ManageOffersCubit>()
                                          .deleteOffer(offer.id),
                                    );
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.red.withAlpha(220),
                                      shape: BoxShape.circle,
                                    ),
                                    padding: EdgeInsets.all(6.r),
                                    child: Icon(
                                      Icons.delete_rounded,
                                      color: Colors.white,
                                      size: 20.r,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                  ],
                ),
              ),
              // Loading overlay while add/delete is running
              if (isActionLoading)
                const Positioned.fill(
                  child: ColoredBox(
                    color: Colors.black26,
                    child: Center(child: CircularProgressIndicator()),
                  ),
                ),
              // Add offer FAB
              Positioned(
                bottom: 24.h,
                left: kHorizontalPadding,
                right: kHorizontalPadding,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14.r)),
                  ),
                  icon: Icon(Icons.add_photo_alternate_rounded,
                      color: Colors.white, size: 22.r),
                  label: Text(
                    'إضافة صورة عرض',
                    style: AppStyles.semiBold16.copyWith(color: Colors.white),
                  ),
                  onPressed:
                      isActionLoading ? null : () => _pickAndUpload(context),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Future<void> _pickAndUpload(BuildContext context) async {
    final File? image = await showModalBottomSheet<File?>(
      context: context,
      builder: (_) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library_rounded),
              title: const Text('من المعرض'),
              onTap: () async {
                final f = await context
                    .read<ImagePickerCubit>()
                    .openImagePickerFromGallery();
                if (context.mounted) Navigator.pop(context, f);
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt_rounded),
              title: const Text('من الكاميرا'),
              onTap: () async {
                final f = await context
                    .read<ImagePickerCubit>()
                    .openImagePickerFromCamera();
                if (context.mounted) Navigator.pop(context, f);
              },
            ),
          ],
        ),
      ),
    );
    if (image != null && context.mounted) {
      context.read<ManageOffersCubit>().addOffer(image);
    }
  }
}
