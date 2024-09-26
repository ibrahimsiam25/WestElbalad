import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../../../../core/errors/failure.dart';
import 'package:west_elbalad/features/used_phones/domian/repos/used_phone_repo.dart';
import '../../../../admin/presentation/manager/image_picker/image_picker_cubit.dart';



part 'add_used_phone_state.dart';

class AddUsedPhoneCubit extends Cubit<AddUsedPhoneState> {
  AddUsedPhoneCubit(this.usedPhonesRepo, this.imagePickerCubit) : super(AddUsedPhoneInitial());

    final  UsedPhonesRepo usedPhonesRepo;
  final ImagePickerCubit imagePickerCubit;
  Future<void> uploadPhoneData(File? image, Map<String, dynamic> data) async {
    emit(AddUsedPhoneLoading());
    try {
      await usedPhonesRepo.uploadPhoneData(image!, data);
      emit(AddUsedPhoneSuccess());
    } on Failure catch (e) {
      emit(AddUsedPhoneFailure(message: e.message));
    }
  }
}
