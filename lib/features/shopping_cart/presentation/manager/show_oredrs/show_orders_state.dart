part of 'show_orders_cubit.dart';

@immutable
sealed class ShowOrdersState {}

final class ShowOrdersInitial extends ShowOrdersState {}
final class ShowOrdersLoading extends ShowOrdersState {}
final class ShowOrdersFailed extends ShowOrdersState {}
final class ShowOrdersSuccess extends ShowOrdersState {
  final List<PhoneEntites> orders;
  ShowOrdersSuccess(this.orders);
}
