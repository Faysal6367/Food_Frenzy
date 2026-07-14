import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_frenzy/constant/app_color.dart';

class MyTextField extends StatefulWidget {
  final double width;
  final String text;
  final IconData icon;
  final bool check; // if true, show eye icon for password toggle
  final TextEditingController controller;

  const MyTextField({
    super.key,
    required this.width,
    required this.text,
    required this.icon,
    required this.controller,
    required this.check,
  });

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  final _formKey = GlobalKey<FormState>();
  bool _obSecure = true;

  @override
  void initState() {
    super.initState();
    // if field is not a password field, ensure it's not obscure
    if (!widget.check) _obSecure = false;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width.w,
      child: Form(
        key: _formKey,
        child: TextFormField(
          controller: widget.controller,
          obscureText: _obSecure,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            prefixIcon: Icon(widget.icon, color: Colors.black),
            // only show suffix icon when 'check' is true (password-style field)
            suffixIcon: widget.check
                ? InkWell(
              borderRadius: BorderRadius.circular(30.sp),
              onTap: () {
                setState(() => _obSecure = !_obSecure);
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                child: Icon(
                  _obSecure ? Icons.visibility_off : Icons.visibility,
                  color: AppColor.mainColor,
                  size: 22.sp,
                ),
              ),
            )
                : null,
            labelText: widget.text,
            labelStyle: TextStyle(color: Colors.black, fontSize: 14.sp),
            floatingLabelBehavior: FloatingLabelBehavior.auto,
            contentPadding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 16.w),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black),
              borderRadius: BorderRadius.all(Radius.circular(30.sp)),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black26),
              borderRadius: BorderRadius.all(Radius.circular(30.sp)),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(30.sp)),
            ),
          ),
          validator: (value) {
            // More friendly validation: treat empty as invalid
            if (value == null || value.trim().isEmpty) {
              return 'This field can\'t be empty';
            }
            return null;
          },
        ),
      ),
    );
  }
}
