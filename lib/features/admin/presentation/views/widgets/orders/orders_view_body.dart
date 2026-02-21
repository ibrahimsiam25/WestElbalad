import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:west_elbalad/core/constants/app_colors.dart';
import 'package:west_elbalad/core/constants/app_consts.dart';
import 'package:west_elbalad/core/widgets/custom_app_bar.dart';
import 'package:west_elbalad/features/admin/presentation/views/widgets/orders/orders_phone_data_element.dart';
import 'package:west_elbalad/features/shopping_cart/data/model/user_info_for_order_model.dart';

class OrdersViewBody extends StatefulWidget {
  const OrdersViewBody({super.key, required this.ordersList});
  final List ordersList;

  @override
  State<OrdersViewBody> createState() => _OrdersViewBodyState();
}

class _OrdersViewBodyState extends State<OrdersViewBody> {
  final TextEditingController _searchController = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filtered = widget.ordersList
        .cast<UserInfoForOrderModel>()
        .where((o) =>
            o.userName.toLowerCase().contains(_query) ||
            o.userPhone.toLowerCase().contains(_query) ||
            o.authUserName.toLowerCase().contains(_query))
        .toList();

    return SingleChildScrollView(
      padding: EdgeInsets.only(bottom: 30.0.h),
      child: Column(
        children: [
          CustomAppBar(title: "الطلبات"),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: kHorizontalPadding, vertical: 8.h),
            child: TextField(
              controller: _searchController,
              textDirection: TextDirection.rtl,
              onChanged: (v) => setState(() => _query = v.toLowerCase().trim()),
              decoration: InputDecoration(
                hintText: 'ابحث باسم العميل أو رقم الهاتف...',
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
            final order = filtered[index];
            return Padding(
              padding: EdgeInsets.only(
                right: kHorizontalPadding,
                left: kHorizontalPadding,
                bottom: kVerticalPadding,
              ),
              child: OrderDataElement(orderEntities: order),
            );
          }),
        ],
      ),
    );
  }
}
