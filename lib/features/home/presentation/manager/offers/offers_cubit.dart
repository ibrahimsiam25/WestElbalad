import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../../domian/repos/home_repo.dart';


part 'offers_state.dart';

class OffersCubit extends Cubit<OffersState> {
  OffersCubit(this.homeRepo) : super(OffersInitial());
    final HomeRepo homeRepo;
  Future<void> loadImagesFromFirebase() async {

      emit(OffersLoading());
          final result = await homeRepo.fetchOffersImagesUrl();

    result.fold(
      (failure) => emit(OffersFailure( failure.message)),
      (phones) => emit(OffersSuccess( phones)),
    );


  }
}
