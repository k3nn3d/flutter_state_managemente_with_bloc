import 'package:bloc_app/app/core/error/failure.dart';
import 'package:bloc_app/app/core/usecases/usecase.dart';
import 'package:bloc_app/app/feature/auth_feature/domain/entities/user_entity.dart';
import 'package:bloc_app/app/feature/auth_feature/domain/respository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class UserSignIn implements UseCase<User, UserSignInParams>{
  final AuthRepository authRepository;
  const UserSignIn(this.authRepository);
  
  @override
  Future<Either<Failure, User>> call(UserSignInParams params) async{
   return await authRepository.loginpWithEmailPassword(
      email: params.email, 
      password: params.password
    );
  }
 
}
class UserSignInParams{
  final String email;
  final String password;
  UserSignInParams({
    required this.email, 
    required this.password
    });
  }