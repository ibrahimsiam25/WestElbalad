part of 'user_informations_cubit.dart';

@immutable
sealed class UserInformationsState {}

final class UserInformationsInitial extends UserInformationsState {}
final class UserInformationsSuccess extends UserInformationsState {
  final List<UserInformationsEntity> userInformations;

  UserInformationsSuccess({required this.userInformations});
}
final class UserInformationsFailure extends UserInformationsState {
  final String message;
  UserInformationsFailure({required this.message});
}
final class UserInformationsLoading   extends UserInformationsState {}
