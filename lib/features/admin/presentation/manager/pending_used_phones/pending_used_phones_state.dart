part of 'pending_used_phones_cubit.dart';

@immutable
sealed class PendingUsedPhonesState {}

final class PendingUsedPhonesInitial extends PendingUsedPhonesState {}

final class PendingUsedPhonesLoading extends PendingUsedPhonesState {}

final class PendingUsedPhonesSuccess extends PendingUsedPhonesState {
  final List<UsedPhonesEntities> phonesList;
  PendingUsedPhonesSuccess({required this.phonesList});
}

final class PendingUsedPhonesFailure extends PendingUsedPhonesState {
  final String message;
  PendingUsedPhonesFailure({required this.message});
}

final class PendingUsedPhoneApproved extends PendingUsedPhonesState {}

final class PendingUsedPhoneRejected extends PendingUsedPhonesState {}
