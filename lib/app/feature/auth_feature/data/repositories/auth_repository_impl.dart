import 'package:bloc_app/app/core/error/exception/server_exception.dart';
import 'package:bloc_app/app/core/error/failure.dart';
import 'package:bloc_app/app/feature/auth_feature/data/datasources/remote/auth_remote_supabase_datasources.dart';
import 'package:bloc_app/app/feature/auth_feature/domain/respository/auth_repository.dart';
import 'package:fpdart/src/either.dart';

class AuthRepositoryImpl implements AuthRepository{
  final AuthRemoteDataSource remoteDataSource;
  const AuthRepositoryImpl(this.remoteDataSource);
  @override
  Future<Either<Failure, String>> loginpWithEmailPassword({required String email, required String password}) {
    // TODO: implement loginpWithEmailPassword
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, String>> singUpWithEmailPassword({required String name, 
  required String email, 
  required String password}) async{
   try {
    final userId = await remoteDataSource.singUpWithEmailPassword(
      name: name, 
      email: email, 
      password: password);
      return right(userId);
   } on ServerException catch (e) {
     return left(Failure(e.message));
   }
  }

}