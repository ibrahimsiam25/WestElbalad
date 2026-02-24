part of 'manage_offers_cubit.dart';

@immutable
sealed class ManageOffersState {}

final class ManageOffersInitial extends ManageOffersState {}

final class ManageOffersLoading extends ManageOffersState {}

final class ManageOffersSuccess extends ManageOffersState {
  final List<OfferEntity> offers;
  ManageOffersSuccess({required this.offers});
}

final class ManageOffersFailure extends ManageOffersState {
  final String message;
  ManageOffersFailure({required this.message});
}

final class ManageOffersActionLoading extends ManageOffersState {
  final List<OfferEntity> offers; // keep showing list while action runs
  ManageOffersActionLoading({required this.offers});
}

final class ManageOffersActionSuccess extends ManageOffersState {}
