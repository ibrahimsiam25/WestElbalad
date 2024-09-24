import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:west_elbalad/features/admin/domain/repos/admin_repo.dart';
import 'package:west_elbalad/features/admin/domain/entities/user_informations_entites.dart';

part 'user_informations_state.dart';

class UserInformationsCubit extends Cubit<UserInformationsState> {
  UserInformationsCubit(this.adminRepo) : super(UserInformationsInitial());
  final AdminRepo adminRepo;
  Future<void> fetchUserInformations({bool isRefreshed = false}) async {
    emit(UserInformationsLoading());

    final result = await adminRepo.fetchAllUsers(isRefreshed: isRefreshed);
    result.fold(
      (failure) => emit(UserInformationsFailure(message: failure.message)),
      (userInformations) =>
          emit(UserInformationsSuccess(userInformations: userInformations)),
    );
  }
}
