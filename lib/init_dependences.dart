import 'package:bloc_app/app/core/common/cubits/user_cubit/app_user_cubit.dart';
import 'package:bloc_app/app/core/secret/supabase_secret.dart';
import 'package:bloc_app/app/feature/auth_feature/data/datasources/remote/auth_remote_supabase_datasources.dart';
import 'package:bloc_app/app/feature/auth_feature/data/repositories/auth_repository_impl.dart';
import 'package:bloc_app/app/feature/auth_feature/domain/respository/auth_repository.dart';
import 'package:bloc_app/app/feature/auth_feature/domain/usecases/current_user.dart';
import 'package:bloc_app/app/feature/auth_feature/domain/usecases/user_sign_in.dart';
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
  servicelocator.registerLazySingleton(() => AppUserCubit());
}
void _initAuth(){
  servicelocator..registerFactory<AuthRemoteDataSource>(() => AuthRemoteSupaBaseDataSourceImpl(servicelocator()))
  ..registerFactory<AuthRepository>(() => AuthRepositoryImpl(servicelocator()))
  ..registerFactory(() => UserSignUp(servicelocator()))
  ..registerFactory(() => UserSignIn(servicelocator()))
  ..registerFactory(() => CurrentUser(servicelocator()))
  ..registerLazySingleton(() => AuthBloc(
    userSignUp: servicelocator(), 
    userSignIn: servicelocator(), 
    currentUser: servicelocator(),
    appUserCubit: servicelocator()
    )
  );
}