import 'package:bloc_app/app/core/error/exception/server_exception.dart';
import 'package:bloc_app/app/core/error/failure.dart';
import 'package:bloc_app/app/core/network/connection_checker.dart';
import 'package:bloc_app/app/feature/auth_feature/data/datasources/remote/auth_remote_supabase_datasources.dart';
import 'package:bloc_app/app/feature/auth_feature/data/models/user_model.dart';
import 'package:bloc_app/app/feature/auth_feature/domain/entities/user_entity.dart';
import 'package:bloc_app/app/feature/auth_feature/domain/respository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as sb;

class AuthRepositoryImpl implements AuthRepository{
  final AuthRemoteDataSource remoteDataSource;
  final IConnectionChecker connectionChecker;
  const AuthRepositoryImpl(this.remoteDataSource, this.connectionChecker);
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
      if (!await (connectionChecker.isConnected)) {
       
        final session = remoteDataSource.currentUsersession;
        if (session == null) {
          return left(Failure('User not Logged!'));
        }
        return right(UserModel(
          id: session.user.id, 
          email: session.user.email ?? '', 
          name: '',
          )
        );
      }
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
      if (!await (connectionChecker.isConnected)) {
        return left(Failure('No internet connetion!'));
      }
      final user = await fn();
      return right(user);
    } on sb.AuthException catch(e){
      return left(Failure(e.message));
    } on ServerException catch (e) {
     return left(Failure(e.message));
    }
  }
}