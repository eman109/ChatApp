import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chat/core/db/supabase_service.dart';
import 'package:chat/features/room/data/model/rooms_model.dart';
import 'package:chat/features/room/data/repo/room_repo.dart';
import 'package:meta/meta.dart';

part 'room_state.dart';

class RoomCubit extends Cubit<RoomState> {
  RoomRepo roomRepo;
  RoomCubit(this.roomRepo) : super(RoomInitial());
  createRoom(String myId, String anotherid) async {
    emit(RoomLoading());
    final result = await roomRepo.createRoom(myId, anotherid);
    result.fold(
      (l) => emit(RoomError(l.failuremessage)),
      (r) => emit(RoomSuccess(r)),
    );
  }

  StreamSubscription<List<RoomsModel>>? roomSubscription;

  getAllRooms() {
    emit(getAllRoomsLoading());
    try {
      roomSubscription = roomRepo.getAllRooms().listen((rooms) async {
        List<RoomsModel> roomsWithUsers = [];
        for (var room in rooms) {
          final otherId =
              room.members
                  .where(
                    (id) => id != SupabaseService().client.auth.currentUser!.id,
                  )
                  .first;
          final user = await roomRepo.getotherDetail(otherId);
          user.fold((l) => emit(getAllRoomsError(l.failuremessage)), (r) {
            room.userInfoModel = r;
            roomsWithUsers.add(room);
          });
          }
        emit(getAllRoomsSuccess(rooms));
      });
    } catch (e) {
      emit(getAllRoomsError(e.toString()));
    }
  }
}
