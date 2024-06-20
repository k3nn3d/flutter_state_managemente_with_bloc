import 'package:bloc_app/app/core/common/cubits/user_cubit/app_user_cubit.dart';
import 'package:bloc_app/app/core/network/connection_checker.dart';
import 'package:bloc_app/app/core/secret/supabase_secret.dart';
import 'package:bloc_app/app/feature/auth_feature/data/datasources/remote/auth_remote_supabase_datasources.dart';
import 'package:bloc_app/app/feature/auth_feature/data/repositories/auth_repository_impl.dart';
import 'package:bloc_app/app/feature/auth_feature/domain/respository/auth_repository.dart';
import 'package:bloc_app/app/feature/auth_feature/domain/usecases/current_user.dart';
import 'package:bloc_app/app/feature/auth_feature/domain/usecases/user_sign_in.dart';
import 'package:bloc_app/app/feature/auth_feature/domain/usecases/user_sign_up.dart';
import 'package:bloc_app/app/feature/auth_feature/presenation/bloc/auth_bloc_bloc.dart';
import 'package:bloc_app/app/feature/blog/data/datasource/blog_local_data_source.dart';
import 'package:bloc_app/app/feature/blog/data/datasource/blog_remote_data_source.dart';
import 'package:bloc_app/app/feature/blog/data/repositories/blog_repository.dart';
import 'package:bloc_app/app/feature/blog/domain/repositories/blog_repository.dart';
import 'package:bloc_app/app/feature/blog/domain/usecases/get_all_blogs.dart';
import 'package:bloc_app/app/feature/blog/domain/usecases/upload_blog.dart';
import 'package:bloc_app/app/feature/blog/presentation/bloc/blog_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

final servicelocator = GetIt.instance;
Future<void> initDependences() async {
  _initAuth();
  _initBlog();
  final supabase =  await Supabase.initialize(
    url: SupaBaseSecret.baseUrl,
    anonKey: SupaBaseSecret.apiKey
  );
  final appDocumrntDir = await path_provider.getApplicationCacheDirectory();
  Hive.init(appDocumrntDir.path);
  Hive.openBox('blogs');
  servicelocator.registerLazySingleton(() => supabase.client);
  servicelocator.registerLazySingleton(() => Hive.box('blogs'));
  servicelocator.registerFactory(() => InternetConnection());
  servicelocator.registerLazySingleton(() => AppUserCubit());
  servicelocator.registerFactory<IConnectionChecker>(() => ConnectionCheckerImpl(servicelocator()));
}
void _initAuth(){
  servicelocator..registerFactory<AuthRemoteDataSource>(() => AuthRemoteSupaBaseDataSourceImpl(servicelocator()))
  ..registerFactory<AuthRepository>(() => AuthRepositoryImpl(
    servicelocator(),
    servicelocator()
    )
  )
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
void _initBlog(){
  servicelocator
  ..registerFactory<IBlogRemoteDataSource>(
    () => BlogSupaBaseRemoteDataSourceImpl(
      supabaseClient: servicelocator()
    )
  )..registerFactory<IBlogLocalDataSource>(() => BlogLocalDataSourceImpl(servicelocator()))
  ..registerFactory<IBlogRepository>(
    () => BlogRepositoryImpl(
      blogRemoteDataSource: servicelocator(),
      blogLocalDataSource: servicelocator(),
      connectionChecker: servicelocator(),
    )
  )..registerFactory(
    () => UploadBlog(
      blogRepository: servicelocator()
    ) 
  )..registerFactory(
    () => GetAllBlogs(
      servicelocator()
    ) 
  )..registerLazySingleton(
    () => BlogBloc(
      getAllBlogs: servicelocator(),
      uploadBlog: servicelocator()
    )
  );
}