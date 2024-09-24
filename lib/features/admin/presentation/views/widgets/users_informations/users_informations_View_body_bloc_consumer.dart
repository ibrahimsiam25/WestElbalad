import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:west_elbalad/core/widgets/custom_error_widget.dart';
import '../../../../../../core/widgets/custom_progress_indicator.dart';
import '../../../manager/user_informations/user_informations_cubit.dart';
import 'package:west_elbalad/features/admin/presentation/views/widgets/users_informations/users_informations_view_body.dart';


class UsersInformationsViewBodyBlocConsumer extends StatelessWidget {
  const UsersInformationsViewBodyBlocConsumer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserInformationsCubit, UserInformationsState>(
      listener: (context, state) {

      },
    builder: (context, state) {
     if (state is UserInformationsSuccess) {
           return  UsersInformationsViewBody(usersInformationList:state.userInformations);
        }else if (state is UserInformationsFailure) {
          return  CustomErrorWidget(text:state.message );
        } else{
          return const CustomProgressIndicator();
        }
       
      }
    );
  }
}

