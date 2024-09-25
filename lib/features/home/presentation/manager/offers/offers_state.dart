part of 'offers_cubit.dart';

@immutable
sealed class OffersState {}

final class OffersInitial extends OffersState {}

final class OffersLoading extends OffersState {}

final class OffersSuccess extends OffersState {
  final List<String> imageUrls;

  OffersSuccess(this.imageUrls);
}

final class OffersFailure extends OffersState {
  final String message;

  OffersFailure(this.message);
}
