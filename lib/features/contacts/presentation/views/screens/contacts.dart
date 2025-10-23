import 'package:chat/core/db/supabase_service.dart';
import 'package:chat/core/routing/routing_generation.dart';
import 'package:chat/core/styling/app_colors.dart';
import 'package:chat/features/contacts/presentation/cubit/contacts_cubit.dart';
import 'package:chat/features/room/presentation/cubit/room_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class Contacts extends StatelessWidget {
  const Contacts({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                width: 393.w,
                height: 80.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25),
                  ),
                  color: AppColors.purpleColor,
                ),
              ),
              SizedBox(height: 20.h),

              Positioned(
                top: 35.sp,
                // left: 50.sp,
                right: 120,
                child: Text(
                  "Add Contacts",
                  style: TextStyle(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
              Positioned(
                top: 27.sp,
                right: 10.sp,
                child: IconButton(
                  onPressed: () {
                    context.push(RouterGeneration.details);
                  },
                  icon: Icon(Icons.person, color: Colors.white),
                ),
              ),
              SizedBox(width: 20.w),
              Positioned(
                top: 27.sp,
                child: IconButton(
                  onPressed: () {
                    context.push(RouterGeneration.room);
                  },
                  icon: Icon(Icons.arrow_back, color: Colors.white),
                ),
              ),
            ],
          ),
          BlocBuilder<ContactsCubit, ContactsState>(
            builder: (context, state) {
              if (state is ContactsLoading) {
                return Center(child: CircularProgressIndicator());
              }
              if (state is ContactsError) {
                return Text(state.e);
              }
              if (state is ContactsSuccess) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: state.contacts.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(state.contacts[index].user_name),
                        subtitle: Text(state.contacts[index].email),
                        trailing: IconButton(
                          onPressed: () {
                            context.read<RoomCubit>().createRoom(
                              SupabaseService()
                                  .client
                                  .auth
                                  .currentUser!
                                  .id, //myID
                              state
                                  .contacts[index]
                                  .id, //The person's id i am clicking on
                            );
                          },
                          icon: Icon(Icons.add),
                        ),
                      );
                    },
                  ),
                );
              }
              return Container();
            },
          ),
        ],
      ),
    );
  }
}
