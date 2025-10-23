import 'package:chat/core/routing/routing_generation.dart';
import 'package:chat/features/room/presentation/cubit/room_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class RoomScreen extends StatefulWidget {
  const RoomScreen({super.key});

  @override
  State<RoomScreen> createState() => _RoomScreenState();
}

class _RoomScreenState extends State<RoomScreen> {
  @override
  void initState() {
    super.initState();
    context.read<RoomCubit>().getAllRooms();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push(RouterGeneration.contacts);
        },
        child: Icon(Icons.add),
      ),
      body: Column(
        children: [
          SizedBox(height: 40.h),
          IconButton(
            onPressed: () {
              context.push(RouterGeneration.register);
            },
            icon: Icon(Icons.arrow_back),
          ),
          Expanded(
            child: BlocBuilder<RoomCubit, RoomState>(
              builder: (context, state) {
                if (state is getAllRoomsLoading) {
                  return Center(child: CircularProgressIndicator());
                }
                if (state is getAllRoomsError) {
                  return Text(state.error);
                }
                if (state is getAllRoomsSuccess) {
                  return ListView.builder(
                    itemCount: state.rooms.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () {
                          context.push(
                            RouterGeneration.chat,
                            extra: state.rooms[index],
                          );
                        },
                        title: Text(
                          state.rooms[index].userInfoModel!.user_name,
                        ),
                        subtitle: Text(state.rooms[index].last_message),
                        trailing: Text("${state.rooms[index].unread_message}"),
                      );
                    },
                  );
                }
                return Container();
              },
            ),
          ),
        ],
      ),
    );
  }
}
