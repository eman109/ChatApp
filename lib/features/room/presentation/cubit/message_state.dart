part of 'message_cubit.dart';

@immutable
sealed class MessageState {}

final class MessageInitial extends MessageState {}

final class MessageSuccess extends MessageState {
  final String message;
  MessageSuccess(this.message);
}

final class MessageError extends MessageState {
  final String error;
  MessageError(this.error);
}

final class MessageSentError extends MessageState {
  final String error;
  MessageSentError(this.error);
}

final class MessageSentSuccess extends MessageState {
  final List<MessageModel> messages;
  MessageSentSuccess(this.messages);
}
