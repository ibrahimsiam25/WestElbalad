import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../../core/service/shared_preferences_singleton.dart';
import 'package:west_elbalad/features/home/domian/repos/home_repo.dart';
import 'package:west_elbalad/features/home/domian/entites/phone_entites.dart';


part 'phones_data_state.dart';

class PhonesDataCubit extends Cubit<PhonesDataState> {
  PhonesDataCubit(this.homeRepo, this.phonesStream) : super(PhonesDataInitial()) {
    // Call fetchPhonesStreamData when the cubit is initialized
    
 int result =  SharedPref.getInt("isFirstTime") ;
    if (result == -1) {
      print(result);
      SharedPref.setInt("isFirstTime", 0);
  fetchPhonesStreamData();
}



    // Listen to the stream and fetch data on stream changes
    phonesStream.listen((snapshot) {
      fetchPhonesStreamData();
    });
  }

  final HomeRepo homeRepo;
  final Stream<QuerySnapshot> phonesStream;

  Future<void> fetchPhonesStreamData() async {
    emit(PhonesDataLoading());
    print("*****************************fetchPhonesStreamData**********************");
    
    // Fetch data from repository
    final result = await homeRepo.fetchPhonesData();

    result.fold(
      (failure) => emit(PhonesDataFailure(message: failure.message)),
      (phones) => emit(PhonesDataSuccess(phonesList: phones)),
    );
  }
}