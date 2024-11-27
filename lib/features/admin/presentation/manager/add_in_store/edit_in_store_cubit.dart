import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../../core/manager/image_picker/image_picker_cubit.dart';
import 'package:west_elbalad/features/admin/domain/repos/admin_repo.dart';

part 'edit_in_store_state.dart';

class AddInStoreCubit extends Cubit<AddInStoreState> {
  AddInStoreCubit({required this.adminRepo, required this.imagePickerCubit})
      : super(AddInStoreInitial());
  final AdminRepo adminRepo;
  final ImagePickerCubit imagePickerCubit;
  Future<void> uploadPhoneData(File? image, Map<String, dynamic> data) async {
    emit(AddInStoreLoading());
    try {
      await adminRepo.uploadPhoneData(image!, data);
      emit(AddInStoreSuccess());
    } on Failure catch (e) {
      emit(AddInStoreFailure(message: e.message));
    }
  }
}
