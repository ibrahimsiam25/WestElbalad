import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:west_elbalad/features/admin/domain/repos/admin_repo.dart';
import 'package:west_elbalad/features/used_phones/domian/entities/used_phone_entities.dart';

part 'used_phones_state.dart';

class EditUsedPhonesCubit extends Cubit<EditUsedPhonesState> {
  EditUsedPhonesCubit(this.adminRepo) : super(EditUsedPhonesInitial());

  final AdminRepo adminRepo;

  Future<void> fetchUsedPhonesData() async {
    emit(EditUsedPhonesLoading());
    final result = await adminRepo.fetchUsedPhonesData();

    result.fold(
      (failure) => emit(EditUsedPhonesFailure(message: failure.message)),
      (phones) => emit(EditUsedPhonesSuccess(phonesList: phones)),
    );
  }

  Future<void> deleteUsedPhoneData(String id) async {
    final result = await adminRepo.deleteUsedPhoneData(id);
    result.fold(
      (failure) => emit(EditUsedPhonesFailure(message: failure.message)),
      (Null) {
        fetchUsedPhonesData();
        emit(removeEditUsedPhonesuccess());
      },
    );
  }

  Future<void> editUsedPhonesPrice(String phoneId, int newValue) async {
    final result = await adminRepo.editUsedPhonePrice(phoneId, newValue);
    result.fold(
      (failure) => emit(EditUsedPhonesFailure(message: failure.message)),
      (Null) {
        fetchUsedPhonesData();
        emit(editUsedPhonePriceSuccess());
      },
    );
  }
}
