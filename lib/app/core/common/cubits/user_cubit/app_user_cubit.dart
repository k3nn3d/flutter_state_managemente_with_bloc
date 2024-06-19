import 'package:bloc_app/app/feature/auth_feature/domain/entities/user_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'app_user_state.dart';
class AppUserCubit extends Cubit<AppUserState>{
  AppUserCubit(): super(AppUserInitialState());

  void updateUser(User? user){
    if(user == null){
      emit(AppUserInitialState());
    }else{
      emit(AppUserLoggedInState(user));
    }

  }
}