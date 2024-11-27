part of 'fetch_user_image_cubit.dart';

@immutable
abstract class FetchUserImageState {}

class FetchUserImageInitial extends FetchUserImageState {}

class FetchUserImageSuccess extends FetchUserImageState {
  final String imageUrl;
  FetchUserImageSuccess(this.imageUrl);
}

class FetchUserImageFailure extends FetchUserImageState {
  final String message;
  FetchUserImageFailure({required this.message});
}

class FetchUserImageLoading extends FetchUserImageState {}
