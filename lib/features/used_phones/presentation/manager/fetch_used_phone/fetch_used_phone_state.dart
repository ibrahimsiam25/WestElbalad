part of 'fetch_used_phone_cubit.dart';

@immutable
sealed class FetchUsedPhoneState {}

final class FetchUsedPhoneInitial extends FetchUsedPhoneState {}
final class FetchUsedPhoneDataLoading extends FetchUsedPhoneState {}

final class FetchUsedPhoneDataSuccess extends FetchUsedPhoneState {
  final List<UsedPhonesEntities> usedPhoneList;
 FetchUsedPhoneDataSuccess({required this.usedPhoneList});
}

final class FetchUsedPhoneDataFailure extends FetchUsedPhoneState {
  final String message;
 FetchUsedPhoneDataFailure({required this.message});
}

