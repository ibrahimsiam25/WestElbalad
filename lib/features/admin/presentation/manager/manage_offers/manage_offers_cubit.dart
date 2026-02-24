import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:west_elbalad/core/service/get_it_service.dart';
import 'package:west_elbalad/features/admin/domain/entities/offer_entity.dart';
import 'package:west_elbalad/features/admin/domain/repos/admin_repo.dart';
import 'package:west_elbalad/features/home/presentation/manager/offers/offers_cubit.dart';

part 'manage_offers_state.dart';

class ManageOffersCubit extends Cubit<ManageOffersState> {
  ManageOffersCubit(this.adminRepo) : super(ManageOffersInitial());

  final AdminRepo adminRepo;

  List<OfferEntity> _currentOffers = [];

  Future<void> fetchOffers() async {
    emit(ManageOffersLoading());
    final result = await adminRepo.fetchOffers();
    result.fold(
      (failure) => emit(ManageOffersFailure(message: failure.message)),
      (offers) {
        _currentOffers = offers;
        emit(ManageOffersSuccess(offers: offers));
      },
    );
  }

  Future<void> addOffer(File image) async {
    emit(ManageOffersActionLoading(offers: _currentOffers));
    final result = await adminRepo.addOffer(image);
    result.fold(
      (failure) {
        emit(ManageOffersSuccess(offers: _currentOffers));
        emit(ManageOffersFailure(message: failure.message));
      },
      (_) {
        _refreshOffersList();
        emit(ManageOffersActionSuccess());
        fetchOffers();
      },
    );
  }

  Future<void> deleteOffer(String id) async {
    emit(ManageOffersActionLoading(offers: _currentOffers));
    final result = await adminRepo.deleteOffer(id);
    result.fold(
      (failure) {
        emit(ManageOffersSuccess(offers: _currentOffers));
        emit(ManageOffersFailure(message: failure.message));
      },
      (_) {
        _refreshOffersList();
        emit(ManageOffersActionSuccess());
        fetchOffers();
      },
    );
  }

  /// Reload the shared OffersCubit so home & UsedPhones see the latest offers.
  void _refreshOffersList() {
    getIt<OffersCubit>().loadImagesFromFirebase();
  }
}
