import 'package:bloc_app/app/core/theme/app_color.dart';
import 'package:flutter/material.dart';

class AuthGradientButton extends StatelessWidget {
  final Function() onPressed;
  final String title;
  const AuthGradientButton({
    required this.onPressed,
    required this.title,
    super.key
    });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        gradient: const LinearGradient(
          colors: [
            AppColor.gradient1Color,
            AppColor.gradient2Color,
           // AppColor.gradient3Color
          ],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        
        style: ElevatedButton.styleFrom(
          fixedSize: const Size(395, 55),
          backgroundColor: AppColor.transparentColor,
          elevation: 0
        ),
        child: Text(title),
      ),
    );
  }
}