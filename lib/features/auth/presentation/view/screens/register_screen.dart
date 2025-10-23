import 'package:chat/core/routing/routing_generation.dart';
import 'package:chat/core/styling/app_colors.dart';
import 'package:chat/features/auth/presentation/view/widgets/bloc_cons_reg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Image.asset(
            "assets/images/Frame 1.png",
            fit: BoxFit.fill,
            width: 577.15.w,
            height: 300.h,
          ),
          SizedBox(height: 30.h),
          RegBlocConsumer(),
          SizedBox(height: 25.h),
          SizedBox(height: 30.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Already have an account?"),
              InkWell(
                onTap: () {
                  context.push(RouterGeneration.login);
                },
                child: Text(
                  " LogIn",
                  style: TextStyle(color: AppColors.primaryColor),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
