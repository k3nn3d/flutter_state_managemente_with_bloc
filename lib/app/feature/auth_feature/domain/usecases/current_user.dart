import 'package:bloc_app/app/core/error/failure.dart';
import 'package:bloc_app/app/core/usecases/usecase.dart';
import 'package:bloc_app/app/feature/auth_feature/domain/entities/user_entity.dart';
import 'package:bloc_app/app/feature/auth_feature/domain/respository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';
class CurrentUser implements UseCase<User, NoParams>{
  final AuthRepository authRepository; 
  CurrentUser(this.authRepository);

  @override
  Future<Either<Failure, User>> call(NoParams paurams) async {
   return await authRepository.getCurrentUser();
  }

}
class NoParams{}