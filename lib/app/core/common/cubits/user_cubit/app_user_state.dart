
part of 'app_user_cubit.dart';

@immutable
sealed class AppUserState{}
final class AppUserInitialState implements AppUserState{}
final class AppUserLoggedInState implements AppUserState{
  final User user;
  AppUserLoggedInState(this.user);
}