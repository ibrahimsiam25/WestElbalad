import 'package:flutter/material.dart';
import 'package:west_elbalad/features/admin/presentation/views/widgets/chose/admin_view_body.dart';

class AdminView extends StatelessWidget {
  const AdminView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: AdminViewBody(),
    );
  }
}