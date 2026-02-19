import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../../../../core/service/shared_preferences_singleton.dart';
import 'package:west_elbalad/features/used_phones/domian/repos/used_phone_repo.dart';
import 'package:west_elbalad/features/used_phones/domian/entities/used_phone_entities.dart';

part 'fetch_used_phone_state.dart';

class FetchUsedPhoneCubit extends Cubit<FetchUsedPhoneState> {
  FetchUsedPhoneCubit(this.usedPhonesRepo, this.usedPhonesStream)
      : super(FetchUsedPhoneInitial()) {
    int result = SharedPref.getInt('isFirstTimeForUsedPhone');
    if (result == -1) {
      SharedPref.setInt('isFirstTimeForUsedPhone', 0);
      fetchPhonesStreamData();
    }

    usedPhonesStream.listen((_) {
      fetchPhonesStreamData();
    });
  }

  final UsedPhonesRepo usedPhonesRepo;
  final Stream<List<Map<String, dynamic>>> usedPhonesStream;

  Future<void> fetchPhonesStreamData() async {
    emit(FetchUsedPhoneDataLoading());
    final result = await usedPhonesRepo.fetchUsedPhonesData();
    result.fold(
      (failure) => emit(FetchUsedPhoneDataFailure(message: failure.message)),
      (phones) => emit(FetchUsedPhoneDataSuccess(usedPhoneList: phones)),
    );
  }
}
