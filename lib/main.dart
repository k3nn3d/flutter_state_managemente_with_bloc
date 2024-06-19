import 'package:bloc_app/app/core/common/cubits/user_cubit/app_user_cubit.dart';
import 'package:bloc_app/app/feature/auth_feature/presenation/bloc/auth_bloc_bloc.dart';
import 'package:bloc_app/init_dependences.dart';
import 'package:bloc_app/main_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await initDependences();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create:(_) => servicelocator<AppUserCubit>()
      ),
      BlocProvider(
        create:(_) => servicelocator<AuthBloc>()
      ),
    ],
    child: const MyApp()));
}


