import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../../core/service/shared_preferences_singleton.dart';
import 'package:west_elbalad/features/used_phones/domian/repos/used_phone_repo.dart';
import 'package:west_elbalad/features/used_phones/domian/entities/used_phone_entities.dart';

part 'fetch_used_phone_state.dart';

class FetchUsedPhoneCubit extends Cubit<FetchUsedPhoneState> {
  FetchUsedPhoneCubit(this.usedPhonesRepo, this.usedPhonesStream)
      : super(FetchUsedPhoneInitial()) {
    // Call fetchPhonesStreamData when the cubit is initialized

    int result = SharedPref.getInt("isFirstTimeForUsedPhone");
    ;
    if (result == -1) {
      print(result);
      SharedPref.setInt("isFirstTimeForUsedPhone", 0);
      fetchPhonesStreamData();
    }

    // Listen to the stream and fetch data on stream changes
    usedPhonesStream.listen((snapshot) {
      fetchPhonesStreamData();
    });
  }

  final UsedPhonesRepo usedPhonesRepo;
  final Stream<QuerySnapshot> usedPhonesStream;

  Future<void> fetchPhonesStreamData() async {
    emit(FetchUsedPhoneDataLoading());
    print("*****************************fetchusedPhonesStreamData**********************");

    // Fetch data from repository
    final result = await usedPhonesRepo.fetchUsedPhonesData();

    result.fold(
      (failure) => emit(FetchUsedPhoneDataFailure(message: failure.message)),
      (phones) => emit(FetchUsedPhoneDataSuccess(usedPhoneList: phones)),
    );
  }
}
