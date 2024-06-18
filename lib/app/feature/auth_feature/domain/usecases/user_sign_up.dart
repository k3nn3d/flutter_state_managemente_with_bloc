import 'package:bloc_app/app/core/error/failure.dart';
import 'package:bloc_app/app/core/usecases/usecase.dart';
import 'package:bloc_app/app/feature/auth_feature/domain/respository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class UserSignUp implements UseCase<String, UserSignUpParams>{
  final AuthRepository authRepository;
  const UserSignUp(this.authRepository);
  
  @override
  Future<Either<Failure, String>> call(UserSignUpParams params) async{
   return await authRepository.singUpWithEmailPassword(
      name: params.name, 
      email: params.email, 
      password: params.password
    );
  }

}
class UserSignUpParams{
  final String name;
  final String email;
  final String password;
  UserSignUpParams({
    required this.name, 
    required this.email, 
    required this.password
    });
  }