import 'package:bloc_app/app/core/theme/text_style.dart';
import 'package:flutter/material.dart';

class AuthTextField extends StatefulWidget {
  final String title;
  final TextEditingController controller;
  final bool obscureText;
  const AuthTextField({
    this.obscureText = false,
    required this.controller,
    required this.title,
    super.key
    });

  @override
  State<AuthTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: (value){
        if(value!.isEmpty){
          return "The field ${widget.title} is missing!";
        }
        return null;
      },
      obscureText: widget.obscureText,
      decoration: InputDecoration(
        hintText: widget.title,
        hintStyle: AppTextStyle.hintTextStyle1
      ),
    );
  }
}