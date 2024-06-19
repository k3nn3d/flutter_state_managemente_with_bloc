part of 'auth_bloc_bloc.dart';
@immutable
sealed class Authevent{}
final class AuthSingUpEvent extends Authevent{
  final String email;
  final String name;
  final String password;

  AuthSingUpEvent({
    required this.email, 
    required this.name, 
    required this.password
  });
}

final class AuthSingInEvent extends Authevent{
  final String email;
  final String password;

  AuthSingInEvent({
    required this.email, 
    required this.password
  });
}
final class AuthIsUserLoggedInEvent extends Authevent{

}