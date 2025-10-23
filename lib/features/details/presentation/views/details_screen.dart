import 'package:chat/core/routing/routing_generation.dart';
import 'package:chat/core/styling/app_colors.dart';
import 'package:chat/features/auth/presentation/view/widgets/button.dart';
import 'package:chat/features/auth/presentation/view/widgets/custom_text_field.dart';
import 'package:chat/features/contacts/data/repo/contact_repo.dart';
import 'package:chat/features/details/presentation/cubit/details_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Image.asset(
                "assets/images/Frame 1.png",
                fit: BoxFit.fill,
                width: 577.15.w,
                height: 300.h,
              ),
              Positioned(
                top: 35.sp,
                child: IconButton(
                  onPressed: () {
                    context.push(RouterGeneration.contacts);
                  },
                  icon: Icon(Icons.arrow_back, color: Colors.white),
                ),
              ),
              Positioned.fill(
                top: 70.sp,
                child: Align(
                  alignment: Alignment.center,
                  child: CircleAvatar(
                    radius: 50.r,
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.person, size: 50.sp),
                    ),
                  ),
                ),
              ),
            ],
          ),
          BlocConsumer<DetailsCubit, DetailsState>(
            listener: (context, state) {
              if (state is DetailsError) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.error)));
              }
              if (state is DetailsUpdated) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Information Updated Successfuly!"),
                    backgroundColor: Colors.green,
                  ),
                );
                context.read<DetailsCubit>().getMyInfo();
              }
              if (state is DetailsUpdating) {
                Center(child: CircularProgressIndicator());
              }
            },
            builder: (context, state) {
              return BlocBuilder<DetailsCubit, DetailsState>(
                builder: (context, state) {
                  if (state is DetailsError) {
                    return Text(state.error);
                  }
                  if (state is DetailsLoading) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (state is DetailsSuccess) {
                    nameController.text = state.user.user_name;
                    phoneController.text = state.user.phone_number;
                    //if i wanna change or update my info
                    return Column(
                      children: [
                        Customtextfield(
                          label: "Email",
                          readonly: true,
                          hintText: state.user.email,
                        ),
                        SizedBox(height: 20.h),
                        Customtextfield(
                          controller: nameController,
                          label: "Name",
                        ),
                        SizedBox(height: 20.h),
                        Customtextfield(
                          controller: phoneController,
                          label: "Phone Number",
                        ),
                        SizedBox(height: 40.h),
                        Primarybutton(
                          onpress: () {
                            context.read<DetailsCubit>().updateMyInfo(
                              nameController.text,
                              phoneController.text,
                            );
                          },
                          buttonText: "Update",
                          backgroundColor: AppColors.primaryColor,
                        ),
                      ],
                    );
                  }
                  return Container();
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
