import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:west_elbalad/core/constants/app_colors.dart';
import 'package:west_elbalad/core/constants/app_consts.dart';
import 'package:west_elbalad/core/widgets/custom_app_bar.dart';
import 'package:west_elbalad/features/admin/presentation/views/widgets/edit_used_phones/edit_used_phone_data_element.dart';
import 'package:west_elbalad/features/used_phones/domian/entities/used_phone_entities.dart';

class EditUsedPhoneViewBody extends StatefulWidget {
  const EditUsedPhoneViewBody({super.key, required this.phonesList});
  final List phonesList;

  @override
  State<EditUsedPhoneViewBody> createState() => _EditUsedPhoneViewBodyState();
}

class _EditUsedPhoneViewBodyState extends State<EditUsedPhoneViewBody> {
  final TextEditingController _searchController = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filtered = widget.phonesList
        .cast<UsedPhonesEntities>()
        .where((p) =>
            p.name.toLowerCase().contains(_query) ||
            p.type.toLowerCase().contains(_query) ||
            p.userName.toLowerCase().contains(_query))
        .toList();

    return SingleChildScrollView(
      padding: EdgeInsets.only(bottom: 30.0.h),
      child: Column(
        children: [
          CustomAppBar(title: "المنتجات المستعملة"),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: kHorizontalPadding, vertical: 8.h),
            child: TextField(
              controller: _searchController,
              textDirection: TextDirection.rtl,
              onChanged: (v) => setState(() => _query = v.toLowerCase().trim()),
              decoration: InputDecoration(
                hintText: 'ابحث بالاسم أو النوع أو اسم البائع...',
                hintTextDirection: TextDirection.rtl,
                prefixIcon: const Icon(Icons.search, color: AppColors.primary),
                suffixIcon: _query.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          setState(() => _query = '');
                        },
                      )
                    : null,
                filled: true,
                fillColor: Colors.grey.shade100,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          ...List.generate(filtered.length, (index) {
            final phone = filtered[index];
            return Padding(
              padding: EdgeInsets.only(
                right: kHorizontalPadding,
                left: kHorizontalPadding,
                bottom: kVerticalPadding,
              ),
              child: EditUsedPhoneDataElement(phoneEntites: phone),
            );
          }),
        ],
      ),
    );
  }
}
