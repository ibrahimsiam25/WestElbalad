part of 'phones_data_cubit.dart';

@immutable
sealed class PhonesDataState {}

final class PhonesDataInitial extends PhonesDataState {}

final class PhonesDataLoading extends PhonesDataState {}

final class PhonesDataSuccess extends PhonesDataState {
  final List<PhoneEntites> phonesList;
  PhonesDataSuccess({required this.phonesList});
}

final class PhonesDataFailure extends PhonesDataState {
  final String message;
  PhonesDataFailure({required this.message});
}
