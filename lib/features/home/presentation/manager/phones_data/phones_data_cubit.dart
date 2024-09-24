import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:west_elbalad/features/home/domian/repos/home_repo.dart';
import 'package:west_elbalad/features/home/domian/entites/phone_entites.dart';

part 'phones_data_state.dart';

class PhonesDataCubit extends Cubit<PhonesDataState> {
  PhonesDataCubit(this.homeRepo, this.phonesStream) : super(PhonesDataInitial()){
    phonesStream.listen((snapshot){
      fetchPhonesStreamData( snapshot);
    });
  }

  final HomeRepo homeRepo;
 final Stream<QuerySnapshot> phonesStream;

    Future<void> fetchPhonesStreamData(QuerySnapshot snapshot) async {
    emit(PhonesDataLoading());
     print("*****************************fetchPhonesStreamData**********************");
    final result = await homeRepo.fetchPhonesData();

    result.fold(
      (failure) => emit(PhonesDataFailure(message: failure.message)),
      (phones) => emit(PhonesDataSuccess(phonesList: phones)),
    );
  }
}
