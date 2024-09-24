import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../admin/domain/repos/admin_repo.dart';
import '../../../../admin/presentation/manager/image_picker/image_picker_cubit.dart';



part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
 ProfileCubit({required this.adminRepo, required this.imagePickerCubit})
      : super(ProfileInitial());
  final AdminRepo adminRepo;
  final ImagePickerCubit imagePickerCubit;
  Future<void> uploadPhoneData(File? image, Map<String, dynamic> data) async {
    emit(ProfileLoading());
    try {
      await adminRepo.uploadPhoneData(image!, data);
      emit(ProfileSuccess());
    } on Failure catch (e) {
      emit(ProfileFailure(message: e.message));
    }
  }
}
