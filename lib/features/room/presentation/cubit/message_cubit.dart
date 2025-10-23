import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chat/features/room/data/model/message_model.dart';
import 'package:chat/features/room/data/repo/room_repo.dart';
import 'package:meta/meta.dart';

part 'message_state.dart';

class MessageCubit extends Cubit<MessageState> {
  RoomRepo roomRepo;
  MessageCubit(this.roomRepo) : super(MessageInitial());

  sendMessage(String roomId, String content) async {
    try {
      await roomRepo.sendMessage(roomId, content);
      emit(MessageSuccess("message sent successfuly!"));
    } catch (e) {
      emit(MessageError(e.toString()));
    }
    getAllMessages(roomId);
  }

  StreamSubscription<List<MessageModel>>? streamSubscription;
  getAllMessages(roomId) {
    try {} catch (e) {
      emit(MessageSentError(e.toString()));
    }
    streamSubscription = roomRepo.getAllMessages(roomId).listen((messages) {
      emit(MessageSentSuccess(messages));
    });
  }
}
