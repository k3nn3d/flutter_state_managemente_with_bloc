import 'dart:io';

import 'package:bloc_app/app/core/error/exception/server_exception.dart';
import 'package:bloc_app/app/core/error/failure.dart';
import 'package:bloc_app/app/core/network/connection_checker.dart';
import 'package:bloc_app/app/feature/blog/data/datasource/blog_local_data_source.dart';
import 'package:bloc_app/app/feature/blog/data/datasource/blog_remote_data_source.dart';
import 'package:bloc_app/app/feature/blog/data/models/blog_model.dart';
import 'package:bloc_app/app/feature/blog/domain/entities/blog.dart';
import 'package:bloc_app/app/feature/blog/domain/repositories/blog_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:uuid/uuid.dart';

class BlogRepositoryImpl implements IBlogRepository{
  final IBlogRemoteDataSource blogRemoteDataSource;
  final IBlogLocalDataSource blogLocalDataSource;
  final IConnectionChecker connectionChecker;
  BlogRepositoryImpl({
    required this.blogLocalDataSource, 
    required this.connectionChecker, 
    required this.blogRemoteDataSource
  });

  @override
  Future<Either<Failure, Blog>> uploadBlog({
    required File image, 
    required String title, 
    required String content, 
    required String posterId, 
    required List<String> topics
  }) async {
    try {
      if(!await (connectionChecker.isConnected)){
        return left(Failure('No internet connextion'));
      }
      BlogModel blogModel = BlogModel(
        id: const Uuid().v1(), 
        posterId: posterId, 
        title: title, 
        content: content, 
        imageUrl: '', 
        topics: topics, 
        updatedAt:  DateTime.now(),
      );
      final imageUrl  =  await blogRemoteDataSource.uploadBlogImage(
        image: image, 
        blog: blogModel
      );
      blogModel = blogModel.copyWith(imageUrl: imageUrl);
      final uploadedBlog =  await blogRemoteDataSource.uploadBlog(blogModel);
      return right(uploadedBlog);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
  
  @override
  Future<Either<Failure, List<Blog>>> getAllBlogs() async {
    try {
      if(!await (connectionChecker.isConnected)){
        final blogs = blogLocalDataSource.loadBlogs();
        return right(blogs);
      }
      final blogs = await blogRemoteDataSource.getAllBlogs();
      blogLocalDataSource.uploadLocalBlogs(blogs: blogs);
      return right(blogs);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

}