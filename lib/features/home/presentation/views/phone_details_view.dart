import 'package:flutter/material.dart';
import 'package:west_elbalad/features/home/domian/entites/phone_entites.dart';
import 'package:west_elbalad/features/home/presentation/views/widgets/phone_details_view_body.dart';

class PhoneDetailsView extends StatelessWidget {
  const PhoneDetailsView({super.key, required this.phoneEntites,});
 final PhoneEntites phoneEntites;
  @override
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: PhoneDetailsViewBody(phone: phoneEntites,),
    );
  }
}