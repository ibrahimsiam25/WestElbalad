part of 'used_phones_cubit.dart';

@immutable
sealed class EditUsedPhonesState {}

final class EditUsedPhonesInitial extends EditUsedPhonesState {}

final class EditUsedPhonesLoading extends EditUsedPhonesState {}

final class removeEditUsedPhonesuccess extends EditUsedPhonesState {}

final class EditUsedPhonesSuccess extends EditUsedPhonesState {
  final List<UsedPhonesEntities> phonesList;
  EditUsedPhonesSuccess({required this.phonesList});
}

final class EditUsedPhonesFailure extends EditUsedPhonesState {
  final String message;
  EditUsedPhonesFailure({required this.message});
}

final class editUsedPhonePriceSuccess extends EditUsedPhonesState {}
