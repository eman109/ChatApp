import 'package:chat/core/routing/routing_generation.dart';
import 'package:chat/features/auth/presentation/view/widgets/button.dart';
import 'package:chat/features/auth/presentation/view/widgets/custom_text_field.dart';
import 'package:chat/features/auth/presentation/view_model/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class RegBlocConsumer extends StatelessWidget {
  const RegBlocConsumer({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    TextEditingController nameContoller = TextEditingController();
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text("Register error ${state.e}")));
        }
        if (state is RegSuccess) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text("Registration Success!")));
          context.push(RouterGeneration.room);
        }
      },
      builder: (context, state) {
        return Column(
          children: [
            Customtextfield(
              label: "User Name",
              hintText: "Enter Name",
              controller: nameContoller,
            ),
            SizedBox(height: 25.h),
            Customtextfield(
              label: "Email",
              hintText: "Enter Email",
              controller: emailController,
            ),
            SizedBox(height: 25.h),
            Customtextfield(
              label: "phone Number",
              hintText: "Enter phone number",
              controller: phoneController,
            ),
            SizedBox(height: 25.h),
            Customtextfield(
              ispassword: true,
              label: "Password",
              hintText: "Enter Password",
              controller: passController,
            ),
            SizedBox(height: 20.h),
            state is AuthLoading
                ? CircularProgressIndicator()
                : Center(
                  child: Primarybutton(
                    onpress: () {
                      context.read<AuthCubit>().registerUser(
                        emailController.text,
                        passController.text,
                        nameContoller.text,
                        phoneController.text,
                      );
                    },
                    buttonText: "Create Account",
                  ),
                ),
          ],
        );
      },
    );
  }
}
