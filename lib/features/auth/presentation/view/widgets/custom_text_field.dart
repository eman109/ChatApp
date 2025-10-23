import 'package:chat/core/styling/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Customtextfield extends StatefulWidget {
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final String? label;
  final String? Toplabel;
  final String? hintText;
  final Widget? suffix;
  final bool ispassword;
  final Icon? icon;
  final bool readonly;

  const Customtextfield({
    super.key,
    this.controller,
    this.hintText,
    this.label,
    this.validator,
    this.Toplabel,
    this.suffix,
    this.ispassword = false,
    this.icon, this.readonly=false,
  });

  @override
  State<Customtextfield> createState() => _CustomtextfieldState();
}

class _CustomtextfieldState extends State<Customtextfield> {
  bool isObsecure = true;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        SizedBox(
          width: 341.w,
          height: 52.h,
          child: TextFormField(
            readOnly: widget.readonly,
            obscureText: widget.ispassword ? isObsecure : false,
            validator: widget.validator,
            controller: widget.controller,
            decoration: InputDecoration(
              hintStyle: TextStyle(color: AppColors.hintColor),
              labelStyle: TextStyle(color: AppColors.borderColor),
              label: Text("${widget.label}"),
              floatingLabelBehavior: FloatingLabelBehavior.always,
              hintText: widget.hintText,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4.r),
                borderSide: BorderSide(
                  color: AppColors.borderColor,
                  width: 1.w,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4.r),
                borderSide: BorderSide(
                  color: AppColors.borderColor,
                  width: 1.w,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4.r),
                borderSide: BorderSide(
                  color: AppColors.errorBorderColor,
                  width: 1.w,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4.r),
                borderSide: BorderSide(
                  color: AppColors.errorBorderColor,
                  width: 1.w,
                ),
              ),
              suffixIcon:
                  widget.ispassword
                      ? IconButton(
                        onPressed: () {
                          setState(() {
                            isObsecure = !isObsecure;
                          });
                        },
                        icon:
                            isObsecure
                                ? Icon(
                                  Icons.visibility_off_outlined,
                                  color: AppColors.hintColor,
                                )
                                : Icon(
                                  Icons.visibility_off_outlined,
                                  color: AppColors.hintColor,
                                ),
                      )
                      : null,
            ),
          ),
        ),
      ],
    );
  }
}
