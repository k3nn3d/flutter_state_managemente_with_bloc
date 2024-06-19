import 'package:bloc_app/app/core/error/exception/server_exception.dart';
import 'package:bloc_app/app/core/error/failure.dart';
import 'package:bloc_app/app/feature/auth_feature/data/datasources/remote/auth_remote_supabase_datasources.dart';
import 'package:bloc_app/app/feature/auth_feature/domain/entities/user_entity.dart';
import 'package:bloc_app/app/feature/auth_feature/domain/respository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as sb;

class AuthRepositoryImpl implements AuthRepository{
  final AuthRemoteDataSource remoteDataSource;
  const AuthRepositoryImpl(this.remoteDataSource);
  @override
  Future<Either<Failure, User>> loginpWithEmailPassword({
    required String email, 
    required String password
  }) async {
    return _getUser(
      () async => await remoteDataSource.loginWithEmailPassword(
      email: email, 
      password: password
      ),
    );
  }

  @override
  Future<Either<Failure, User>> singUpWithEmailPassword({required String name, 
  required String email, 
  required String password}) async{
   try {
      return _getUser(
        () async => await remoteDataSource.singUpWithEmailPassword(
          name: name, 
          email: email, 
          password: password
          ),
        );
   } on ServerException catch (e) {
     return left(Failure(e.message));
   }
  }
  
  @override
  Future<Either<Failure, User>> getCurrentUser() async {
    try {
      final user = await remoteDataSource.getCurrentUserData();
      if (user == null) {
        return left(Failure('User not Logged!'));
      }
      return right(user);
    }on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
  
  Future <Either<Failure, User>> _getUser(
    Future<User> Function() fn,
  ) async{
    try {
      final user = await fn();
      return right(user);
    } on sb.AuthException catch(e){
      return left(Failure(e.message));
    } on ServerException catch (e) {
     return left(Failure(e.message));
    }
  }
}