part of 'orders_cubit.dart';

@immutable
sealed class OrdersState {}

final class OrdersInitial extends OrdersState {}

final class OrdersLoading extends OrdersState {}

final class OrdersFailure extends OrdersState {
  final String message;
  OrdersFailure({required this.message});
}

final class OrdersRemoveSuccess extends OrdersState {}

final class OrdersSuccess extends OrdersState {
  final List<UserInfoForOrderEntities> ordersList;
  OrdersSuccess({required this.ordersList});
}
