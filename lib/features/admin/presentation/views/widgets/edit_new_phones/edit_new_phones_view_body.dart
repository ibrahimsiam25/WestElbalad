import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:west_elbalad/core/constants/app_colors.dart';
import 'package:west_elbalad/core/constants/app_consts.dart';
import 'package:west_elbalad/core/widgets/custom_app_bar.dart';
import 'package:west_elbalad/features/admin/presentation/views/widgets/edit_new_phones/edit_new_phone_data_element.dart';
import 'package:west_elbalad/features/home/domian/entites/phone_entites.dart';

class EditNewPhonesViewBody extends StatefulWidget {
  const EditNewPhonesViewBody({super.key, required this.phonesList});
  final List phonesList;

  @override
  State<EditNewPhonesViewBody> createState() => _EditNewPhonesViewBodyState();
}

class _EditNewPhonesViewBodyState extends State<EditNewPhonesViewBody> {
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
        .cast<PhoneEntites>()
        .where((p) =>
            p.name.toLowerCase().contains(_query) ||
            p.type.toLowerCase().contains(_query))
        .toList();

    return SingleChildScrollView(
      child: Column(
        children: [
          CustomAppBar(title: "المنتجات الجديدة"),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: kHorizontalPadding, vertical: 8.h),
            child: TextField(
              controller: _searchController,
              textDirection: TextDirection.rtl,
              onChanged: (v) => setState(() => _query = v.toLowerCase().trim()),
              decoration: InputDecoration(
                hintText: 'ابحث بالاسم أو النوع...',
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
              child: EditNewPhoneDataElement(phoneEntites: phone),
            );
          }),
        ],
      ),
    );
  }
}
