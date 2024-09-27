part of 'new_phones_cubit.dart';

@immutable
sealed class NewPhonesState {}

final class NewPhonesInitial extends NewPhonesState {}

final class NewPhonesLoading extends NewPhonesState {}

final class removeNewPhoneSuccess extends NewPhonesState {}

final class NewPhonesSuccess extends NewPhonesState {
  final List<PhoneEntites> phonesList;
  NewPhonesSuccess({required this.phonesList});
}

final class NewPhonesFailure extends NewPhonesState {
  final String message;
  NewPhonesFailure({required this.message});
}

final class editNewPhonePriceSuccess extends NewPhonesState {}
