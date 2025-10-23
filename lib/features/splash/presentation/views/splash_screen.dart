import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:chat/core/routing/routing_generation.dart';
import 'package:chat/features/auth/presentation/view/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      context.go(RouterGeneration.login);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Image.asset("assets/images/PWA.png", width: 333.w, height: 125.h),
      nextScreen: LoginScreen(),
      animationDuration: const Duration(milliseconds: 1000),
      splashTransition: SplashTransition.fadeTransition,
    );
  }
}
