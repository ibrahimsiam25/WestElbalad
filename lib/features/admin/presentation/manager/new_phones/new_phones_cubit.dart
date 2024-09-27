import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:west_elbalad/features/admin/domain/repos/admin_repo.dart';

import '../../../../home/domian/entites/phone_entites.dart';

part 'new_phones_state.dart';

class NewPhonesCubit extends Cubit<NewPhonesState> {
  NewPhonesCubit(this.adminRepo) : super(NewPhonesInitial());

  final AdminRepo adminRepo;

  Future<void> fetchNewPhonesData() async {
    emit(NewPhonesLoading());
    final result = await adminRepo.fetchNewPhonesData();

    result.fold(
      (failure) => emit(NewPhonesFailure(message: failure.message)),
      (phones) => emit(NewPhonesSuccess(phonesList: phones)),
    );
  }

  Future<void> deleteNewPhoneData(String id) async {
    final result = await adminRepo.deleteNewPhoneData(id);
    result.fold(
      (failure) => emit(NewPhonesFailure(message: failure.message)),
      (Null) {
        fetchNewPhonesData();
        emit(removeNewPhoneSuccess());
      },
    );
  }

  Future<void> editPrice(String phoneId, int newValue) async {
    final result = await adminRepo.editNewPhonePrice(phoneId, newValue);
    result.fold(
      (failure) => emit(NewPhonesFailure(message: failure.message)),
      (Null) {
        fetchNewPhonesData();
        emit(editNewPhonePriceSuccess());
      },
    );
  }
}
