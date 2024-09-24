import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../../../home/domian/entites/phone_entites.dart';
import 'package:west_elbalad/features/admin/domain/repos/admin_repo.dart';

part 'remove_from_store_state.dart';

class RemoveFromStoreCubit extends Cubit<RemoveFromStoreState> {
  RemoveFromStoreCubit(this.adminRepo) : super(RemoveFromStoreInitial());

  final AdminRepo adminRepo;

  Future<void> fetchPhonesData() async {
    emit(RemoveFromStoreLoading());
    final result = await adminRepo.fetchPhonesData();

    result.fold(
      (failure) => emit(RemoveFromStoreFailure(message: failure.message)),
      (phones) => emit(RemoveFromStoreSuccess(phonesList: phones)),
    );
  }

  Future<void> deletePhoneData(String id) async {
    final result = await adminRepo.deletePhoneData(id);
    result.fold(
      (failure) => emit(RemoveFromStoreFailure(message: failure.message)),
      (Null) {
        fetchPhonesData();
        emit(removePhoneSuccess());
      },
    );
  }
   Future<void> editPrice(String phoneId,int newValue) async {
    final result = await adminRepo.editPrice(phoneId,newValue);
    result.fold(
      (failure) => emit(RemoveFromStoreFailure(message: failure.message)),
      (Null) {
        fetchPhonesData();
        emit( editPriceSuccess());
      },
    );
  }
}
