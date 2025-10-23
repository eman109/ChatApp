part of 'details_cubit.dart';

@immutable
sealed class DetailsState {}

final class DetailsInitial extends DetailsState {}

final class DetailsLoading extends DetailsState {}

final class DetailsSuccess extends DetailsState {
  UserInfoModel user;
  DetailsSuccess(this.user);
}

final class DetailsError extends DetailsState {
  String error;
  DetailsError(this.error);
}

final class DetailsUpdating extends DetailsState {}

final class DetailsUpdated extends DetailsState {
  final String message;
  DetailsUpdated(this.message);
}

final class ImageDetailsLoading extends DetailsState {}

final class ImageDetailsError extends DetailsState {
  String error;
  ImageDetailsError(this.error);
}

final class ImageDetailsSuccess extends DetailsState {
  String image;
  ImageDetailsSuccess(this.image);
}

