import 'package:chat/core/db/db_service.dart';
import 'package:chat/core/db/failures.dart';
import 'package:chat/core/db/supabase_service.dart';
import 'package:chat/features/auth/data/model/user_info_model.dart';
import 'package:chat/features/room/data/model/message_model.dart';
import 'package:chat/features/room/data/model/rooms_model.dart';
import 'package:dartz/dartz.dart';

abstract class RoomRepo {
  Future<Either<Failures, String>> createRoom(String myId, String anotherid);
  Stream<List<RoomsModel>> getAllRooms();
  Future<Either<Failures, UserInfoModel>> getotherDetail(String userId);
  Future<void> sendMessage(String roomId, String content);
  Stream<List<MessageModel>> getAllMessages(String roomId);
}

class RoomRepoImpl implements RoomRepo {
  DbService dbService;
  SupabaseService supabaseService = SupabaseService();
  RoomRepoImpl(this.dbService);
  @override
  Future<Either<Failures, String>> createRoom(
    String myId,
    String anotherid,
  ) async {
    final sortid = [myId, anotherid]..sort();
    final idRoom =
        "${sortid[0]}-${sortid[1]}";
    RoomsModel room = RoomsModel(
      id: idRoom,
      last_message: "",
      members: sortid,
      unread_message: 0,
    );
    try {
      await supabaseService.client
          .from("rooms")
          .upsert(room.toJson(), onConflict: "id");
      return right("Success!");
    } catch (e) {
      return left(Serverfailure("Failed! $e"));
    }
  }

  @override
  Stream<List<RoomsModel>> getAllRooms() {
    try {
      final streamVar = supabaseService.client
          .from("rooms")
          .stream(primaryKey: ["id"]);

      final allRooms = streamVar.map((event) {
        return event
            .map((event) => RoomsModel.fromJson(event))
            .where(
              (room) => room.members.contains(
                supabaseService.client.auth.currentUser!.id,
              ),
            )
            .toList();
      });
      return allRooms;
    } catch (e) {
      throw Exception(e.toString());
    }
  }


  @override
  Future<Either<Failures, UserInfoModel>> getotherDetail(String userId) async {
    try {
      final data = await dbService.fetchBySingle("user_info", "id", userId);
      final user = UserInfoModel.fromJson(data);
      return right(user);
    } catch (e) {
      return left(Serverfailure("The error is $e"));
    }
  }

  @override
  Future<void> sendMessage(String roomId, String content) async {
    MessageModel message = MessageModel(
      content: content,
      createdAt: DateTime.now(),
      roomId: roomId,
      senderId: supabaseService.client.auth.currentUser!.id,
    );
    try {
      await dbService.insert("message", message.toJson());
      print("Message sent.");
      await dbService.update("rooms", "id", roomId, {"last_message": content});
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Stream<List<MessageModel>> getAllMessages(String roomId) {
    try {
      final stream = supabaseService.client
          .from("message")
          .stream(primaryKey: ["id"])
          .eq("roomId", roomId)
          .order("createdAt", ascending: false);
      return stream.map((e) => e.map((e) => MessageModel.fromJson(e)).toList());
    } catch (e) {
      throw Exception(e.toString());
    }
  }

}

