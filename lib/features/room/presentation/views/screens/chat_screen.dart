import 'package:chat/core/db/supabase_service.dart';
import 'package:chat/core/styling/app_colors.dart';
import 'package:chat/features/room/data/model/rooms_model.dart';
import 'package:chat/features/room/presentation/cubit/message_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatScreen extends StatefulWidget {
  final RoomsModel? room;
  const ChatScreen({super.key, required this.room});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController messageController = TextEditingController();
  @override
  void initState() {

    super.initState();
    context.read<MessageCubit>().getAllMessages(widget.room!.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.room!.userInfoModel!.user_name)),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<MessageCubit, MessageState>(
              builder: (context, state) {
                if (state is MessageSentSuccess) {
                  return ListView.builder(
                    reverse: true,
                    itemCount: state.messages.length,
                    itemBuilder: (context, index) {
                      bool isMe =
                          state.messages[index].senderId ==
                          SupabaseService().client.auth.currentUser!.id;

                      return Align(
                        alignment:
                            isMe ? Alignment.centerRight : Alignment.centerLeft,
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                            vertical: 4,
                            horizontal: 8,
                          ),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color:
                                isMe ? AppColors.primaryColor : Colors.blueGrey,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(state.messages[index].content),
                        ),
                      );
                    },
                  );
                }
                return const Center(child: Text("No messages yet"));
              },
            ),
          ),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            color: Colors.grey[200],
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: messageController,
                    decoration: const InputDecoration(
                      hintText: "Type your message here",
                      border: InputBorder.none,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    if (messageController.text.trim().isNotEmpty) {
                      context.read<MessageCubit>().sendMessage(
                        widget.room!.id,
                        messageController.text,
                      );
                      messageController.clear();
                    }
                  },
                  icon: const Icon(Icons.send),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
