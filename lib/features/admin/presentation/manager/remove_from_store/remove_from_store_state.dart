part of 'remove_from_store_cubit.dart';

@immutable
sealed class RemoveFromStoreState {}

final class RemoveFromStoreInitial extends RemoveFromStoreState {}
final class RemoveFromStoreLoading extends RemoveFromStoreState {}
final class removePhoneSuccess extends RemoveFromStoreState {}
final class RemoveFromStoreSuccess extends RemoveFromStoreState {

   final List<PhoneEntites> phonesList;
  RemoveFromStoreSuccess({required this.phonesList});
}
final class RemoveFromStoreFailure extends RemoveFromStoreState {

  final String message;
  RemoveFromStoreFailure({required this.message});
}

final class editPriceSuccess extends RemoveFromStoreState {

}
