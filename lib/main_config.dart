import 'package:bloc_app/app/core/theme/app_theme.dart';
import 'package:bloc_app/app/feature/auth_feature/presenation/screens/login_screen.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Blog App',
      theme: AppTheme().darkModeTheme,
      home:const LoginScreen(),
    );
  }
}