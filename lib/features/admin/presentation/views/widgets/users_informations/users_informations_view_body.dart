import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:west_elbalad/core/constants/app_colors.dart';
import 'package:west_elbalad/core/constants/app_consts.dart';
import 'package:west_elbalad/core/widgets/custom_app_bar.dart';
import 'package:west_elbalad/features/admin/domain/entities/user_informations_entites.dart';
import 'package:west_elbalad/features/admin/presentation/views/widgets/users_informations/user_data_element.dart';

class UsersInformationsViewBody extends StatefulWidget {
  const UsersInformationsViewBody(
      {super.key, required this.usersInformationList});
  final List<UserInformationsEntity> usersInformationList;

  @override
  State<UsersInformationsViewBody> createState() =>
      _UsersInformationsViewBodyState();
}

class _UsersInformationsViewBodyState extends State<UsersInformationsViewBody> {
  final TextEditingController _searchController = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filtered = widget.usersInformationList
        .where((u) =>
            u.name.toLowerCase().contains(_query) ||
            u.email.toLowerCase().contains(_query))
        .toList();

    return Column(
      children: [
        CustomAppBar(title: 'عرض المستخدمين'),
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: kHorizontalPadding, vertical: 8.h),
          child: TextField(
            controller: _searchController,
            textDirection: TextDirection.rtl,
            onChanged: (v) => setState(() => _query = v.toLowerCase().trim()),
            decoration: InputDecoration(
              hintText: 'ابحث بالاسم أو البريد الإلكتروني...',
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
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.symmetric(
                horizontal: kHorizontalPadding, vertical: 8.0.h),
            itemCount: filtered.length,
            itemBuilder: (context, index) {
              final user = filtered[index];
              return UserDataElement(user: user);
            },
          ),
        ),
      ],
    );
  }
}
