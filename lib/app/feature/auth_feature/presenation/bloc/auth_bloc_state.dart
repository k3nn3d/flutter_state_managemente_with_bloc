part of 'auth_bloc_bloc.dart';
@immutable
sealed class AuthState{
  const AuthState();
}
final class AuthInitialState extends AuthState{}
final class AuthLoadingState extends AuthState{}
final class AuthSuccessState extends AuthState{
  final String uid;
  const AuthSuccessState(this.uid);
}

final class AuthFailureState extends AuthState{
  final String message;
  const AuthFailureState(this.message);
}