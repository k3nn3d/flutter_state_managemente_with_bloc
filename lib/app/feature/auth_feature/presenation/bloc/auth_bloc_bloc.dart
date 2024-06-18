import 'package:bloc_app/app/feature/auth_feature/domain/entities/user_entity.dart';
import 'package:bloc_app/app/feature/auth_feature/domain/usecases/user_sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_bloc_event.dart';
part 'auth_bloc_state.dart';

class AuthBloc extends Bloc<Authevent, AuthState>{
  final UserSignUp _userSignUp;
  AuthBloc({required UserSignUp userSignUp}): _userSignUp = userSignUp,
  super(AuthInitialState()){
    on<AuthSingUpEvent>((event, emit) async {
      emit(AuthLoadingState());
     final res = await _userSignUp(UserSignUpParams(
        name: event.name, 
        email: event.email, 
        password: event.password
        )
      );
      res.fold(
        (failure) => emit(AuthFailureState(failure.message)), 
        (user) => emit(AuthSuccessState(user))
      );
    }
  );
  }
}