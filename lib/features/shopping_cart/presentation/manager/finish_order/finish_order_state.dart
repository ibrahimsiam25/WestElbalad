part of 'finish_order_cubit.dart';

@immutable
sealed class FinishOrderState {}

final class FinishOrderInitial extends FinishOrderState {}

final class FinishOrderSuccess extends FinishOrderState {
}

final class FinishOrderFailure extends FinishOrderState {  

  final String message;
  FinishOrderFailure(this.message);
}

final class FinishOrderLoading extends FinishOrderState {}
