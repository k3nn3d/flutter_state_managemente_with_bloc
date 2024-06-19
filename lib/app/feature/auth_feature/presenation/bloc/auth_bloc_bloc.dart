import 'package:bloc_app/app/core/common/cubits/user_cubit/app_user_cubit.dart';
import 'package:bloc_app/app/feature/auth_feature/domain/entities/user_entity.dart';
import 'package:bloc_app/app/feature/auth_feature/domain/usecases/current_user.dart';
import 'package:bloc_app/app/feature/auth_feature/domain/usecases/user_sign_in.dart';
import 'package:bloc_app/app/feature/auth_feature/domain/usecases/user_sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_bloc_event.dart';
part 'auth_bloc_state.dart';

class AuthBloc extends Bloc<Authevent, AuthState>{
  final UserSignUp _userSignUp;
  final UserSignIn _userSignIn;
  final CurrentUser _currentUser;
  final AppUserCubit _appUserCubit;
  AuthBloc({
    required UserSignUp userSignUp, 
    required UserSignIn userSignIn,
    required CurrentUser currentUser,
    required AppUserCubit appUserCubit
    }): _userSignUp = userSignUp, 
    _userSignIn = userSignIn,
    _currentUser = currentUser,
    _appUserCubit = appUserCubit,

  super(AuthInitialState()){
    on<Authevent>((_, emit) => emit(AuthLoadingState()));
    on<AuthSingUpEvent>((event, emit) => _onAuthSignUpEvent(event, emit));
    on<AuthSingInEvent>((event, emit) => _onAuthLoginEvent(event, emit));
    on<AuthIsUserLoggedInEvent>((event, emit) => _isUserLoggedIn(event, emit));
  }

  void _isUserLoggedIn(AuthIsUserLoggedInEvent event, Emitter<AuthState> emit) async {
     final res = await _currentUser(NoParams());
     res.fold(
      (failure) => emit(AuthFailureState(failure.message)),
      (user)=> _emitAuthSuccess(user, emit)
    );
  }
  void _onAuthLoginEvent(AuthSingInEvent event, Emitter<AuthState> emit)async{
    final res = await _userSignIn(UserSignInParams(
      email: event.email, 
      password: event.password
      )
    );
    res.fold(
      (failure) => emit(AuthFailureState(failure.message)), 
      (user) => _emitAuthSuccess(user, emit)
    );
  }
  
   void _onAuthSignUpEvent(AuthSingUpEvent event, Emitter<AuthState> emit)async{
    final res = await _userSignUp(UserSignUpParams(
      name: event.name, 
      email: event.email, 
      password: event.password
      )
    );
    res.fold(
      (failure) => emit(AuthFailureState(failure.message)), 
      (user) => _emitAuthSuccess(user, emit)
    );
  }
  void _emitAuthSuccess(User user, Emitter<AuthState> emit){
    _appUserCubit.updateUser(user);
    emit(AuthSuccessState(user));
  }

}

