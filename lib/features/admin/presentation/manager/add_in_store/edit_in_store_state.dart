part of 'edit_in_store_cubit.dart';

@immutable
sealed class AddInStoreState {}

final class AddInStoreInitial extends AddInStoreState {}
final class AddInStoreLoading extends AddInStoreState {}
final class AddInStoreSuccess extends AddInStoreState {}

final class AddInStoreFailure extends AddInStoreState {
  final String message;
  AddInStoreFailure({required this.message});
}
