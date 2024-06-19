import 'package:bloc_app/app/core/common/cubits/user_cubit/app_user_cubit.dart';
import 'package:bloc_app/app/core/theme/app_theme.dart';
import 'package:bloc_app/app/feature/auth_feature/presenation/bloc/auth_bloc_bloc.dart';
import 'package:bloc_app/app/feature/auth_feature/presenation/screens/login_screen.dart';
import 'package:bloc_app/app/feature/blog/presentation/screens/blog_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    context.read<AuthBloc>().add(AuthIsUserLoggedInEvent());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Blog App',
      theme: AppTheme().darkModeTheme,
      home: BlocSelector<AppUserCubit, AppUserState, bool>(
        selector: (state) => state is AppUserLoggedInState,
        builder: (context, isLoggedin) {
          if (isLoggedin) {
            return const BlogScreen();
          }
          return const LoginScreen();
        }
      ),
    );
  }
}