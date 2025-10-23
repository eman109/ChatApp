import 'package:chat/core/routing/routing_generation.dart';
import 'package:chat/features/auth/presentation/view/widgets/button.dart';
import 'package:chat/features/auth/presentation/view/widgets/custom_text_field.dart';
import 'package:chat/features/auth/presentation/view_model/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class BlocConsLogin extends StatelessWidget {
  const BlocConsLogin({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passController = TextEditingController();
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text("Login Success")));
          context.push(RouterGeneration.room);
        }
        if (state is AuthError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text("Login Error ${state.e}")));
        }
      },
      builder: (context, state) {
        return Column(
          children: [
            Customtextfield(
              label: "Email",
              hintText: "Enter Email",
              controller: emailController,
            ),
            SizedBox(height: 30.h),
            Customtextfield(
              ispassword: true,
              label: "Password",
              hintText: "Enter Password",
              controller: passController,
            ),
            SizedBox(height: 40.h),
            state is AuthLoading
                ? CircularProgressIndicator()
                :
                Center(
                  child: Primarybutton(
                    onpress: () {
                      context.read<AuthCubit>().loginUser(
                        emailController.text,
                        passController.text,
                      );
                    },
                    buttonText: "Next step",
                  ),
                ),
            SizedBox(height: 100.h),
          ],
        );
      },
    );
  }
}
