import 'package:bloc_app/app/core/secret/supabase_secret.dart';
import 'package:bloc_app/app/feature/auth_feature/data/datasources/remote/auth_remote_supabase_datasources.dart';
import 'package:bloc_app/app/feature/auth_feature/data/repositories/auth_repository_impl.dart';
import 'package:bloc_app/app/feature/auth_feature/domain/respository/auth_repository.dart';
import 'package:bloc_app/app/feature/auth_feature/domain/usecases/user_sign_up.dart';
import 'package:bloc_app/app/feature/auth_feature/presenation/bloc/auth_bloc_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final servicelocator = GetIt.instance;
Future<void> initDependences() async {
  _initAuth();
  final supabase =  await Supabase.initialize(
    url: SupaBaseSecret.baseUrl,
    anonKey: SupaBaseSecret.apiKey
  );
  servicelocator.registerLazySingleton(() => supabase.client);
}
void _initAuth(){
servicelocator.registerFactory<AuthRemoteDataSource>(() => AuthRemoteSupaBaseDataSourceImpl(servicelocator()));
servicelocator.registerFactory<AuthRepository>(() => AuthRepositoryImpl(servicelocator()));
servicelocator.registerFactory(() => UserSignUp(servicelocator()));
servicelocator.registerLazySingleton(() => AuthBloc(userSignUp: servicelocator()));
}