part of 'room_cubit.dart';

@immutable
sealed class RoomState {}

final class RoomInitial extends RoomState {}

final class RoomLoading extends RoomState {}

final class RoomSuccess extends RoomState {
  final String message;
  RoomSuccess(this.message);
}

final class RoomError extends RoomState {
  String error;
  RoomError(this.error);
}

final class getAllRoomsLoading extends RoomState {}

final class getAllRoomsSuccess extends RoomState {
  final List<RoomsModel> rooms;
  getAllRoomsSuccess(this.rooms);
}

final class getAllRoomsError extends RoomState {
  final String error;
  getAllRoomsError(this.error);
}
