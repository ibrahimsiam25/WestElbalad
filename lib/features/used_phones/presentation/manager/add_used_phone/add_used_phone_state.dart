part of 'add_used_phone_cubit.dart';

@immutable
sealed class AddUsedPhoneState {}

final class AddUsedPhoneInitial extends AddUsedPhoneState {}
final class AddUsedPhoneLoading extends AddUsedPhoneState {}
final class AddUsedPhoneSuccess extends AddUsedPhoneState {}
final class AddUsedPhoneFailure extends AddUsedPhoneState {
  final String message;

  AddUsedPhoneFailure({required this.message});
}
