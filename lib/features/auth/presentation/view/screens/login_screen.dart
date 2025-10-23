import 'package:chat/core/routing/routing_generation.dart';
import 'package:chat/core/styling/app_colors.dart';
import 'package:chat/features/auth/presentation/view/widgets/bloc_cons_login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              alignment: AlignmentDirectional.center,
              children: [
                Image.asset(
                  "assets/images/Frame 1.png",
                  fit: BoxFit.fill,
                  width: 577.15.w,
                  height: 300.h,
                ),
                SizedBox(height: 200.h, width: 200.w),
                Image.asset(
                  "assets/images/PWA plain.png",
                  width: 240.w,
                  height: 90.97.h,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 70.h),
                  Text(
                    textAlign: TextAlign.left,
                    "Login to your account",
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 40.h),
                  BlocConsLogin(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an account?"),
                      InkWell(
                        onTap: () {
                          context.push(RouterGeneration.register);
                        },
                        child: Text(
                          " Sign up",
                          style: TextStyle(color: AppColors.primaryColor),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // TextFormField(decoration: ,)
          ],
        ),
      ),
    );
  }
}
