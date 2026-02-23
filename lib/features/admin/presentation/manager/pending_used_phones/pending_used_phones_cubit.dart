import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:west_elbalad/features/admin/domain/repos/admin_repo.dart';
import 'package:west_elbalad/features/used_phones/domian/entities/used_phone_entities.dart';

part 'pending_used_phones_state.dart';

class PendingUsedPhonesCubit extends Cubit<PendingUsedPhonesState> {
  PendingUsedPhonesCubit(this.adminRepo) : super(PendingUsedPhonesInitial());

  final AdminRepo adminRepo;

  Future<void> fetchPendingUsedPhones() async {
    emit(PendingUsedPhonesLoading());
    final result = await adminRepo.fetchPendingUsedPhones();
    result.fold(
      (failure) => emit(PendingUsedPhonesFailure(message: failure.message)),
      (phones) => emit(PendingUsedPhonesSuccess(phonesList: phones)),
    );
  }

  Future<void> approveUsedPhone(String id) async {
    final result = await adminRepo.approveUsedPhone(id);
    result.fold(
      (failure) => emit(PendingUsedPhonesFailure(message: failure.message)),
      (_) {
        emit(PendingUsedPhoneApproved());
        fetchPendingUsedPhones();
      },
    );
  }

  Future<void> rejectUsedPhone(String id) async {
    final result = await adminRepo.rejectUsedPhone(id);
    result.fold(
      (failure) => emit(PendingUsedPhonesFailure(message: failure.message)),
      (_) {
        emit(PendingUsedPhoneRejected());
        fetchPendingUsedPhones();
      },
    );
  }
}
