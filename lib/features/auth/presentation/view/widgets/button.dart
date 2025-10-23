import 'package:chat/core/styling/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Primarybutton extends StatelessWidget {
  final String? buttonText;
  final Widget? widget;
  final Function()? onpress;
  final Color? backgroundColor;
  final double? width;
  final double? height;
  final double? fontsize;
  final FontWeight? fontweight;
  const Primarybutton({
    super.key,
    this.widget,
    this.onpress,
    this.backgroundColor,
    this.width,
    this.height,
    this.buttonText,
    this.fontsize,
    this.fontweight,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onpress,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        fixedSize: Size(width ?? 165.w, height ?? 40.h),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.double_arrow_sharp, color: Colors.white),
          SizedBox(width: 2.w),
          Text(
            "$buttonText",
            style: TextStyle(
              fontSize: fontsize,
              fontWeight: fontweight,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

