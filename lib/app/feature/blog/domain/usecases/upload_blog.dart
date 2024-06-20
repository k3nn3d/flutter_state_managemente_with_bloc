import 'dart:io';

import 'package:bloc_app/app/core/error/failure.dart';
import 'package:bloc_app/app/core/usecases/usecase.dart';
import 'package:bloc_app/app/feature/blog/domain/entities/blog.dart';
import 'package:bloc_app/app/feature/blog/domain/repositories/blog_repository.dart';
import 'package:fpdart/fpdart.dart';

class UploadBlog implements UseCase<Blog, UploadBlogParams>{
  final IBlogRepository blogRepository;
  UploadBlog({required this.blogRepository});
  
  @override
  Future<Either<Failure, Blog>> call(UploadBlogParams params) async {
   return await blogRepository.uploadBlog(
      image: params.image, 
      title: params.title, 
      content: params.content, 
      posterId: params.posterId, 
      topics: params.topics
    );
  }
  
}

class UploadBlogParams{
    final File image; 
    final String title; 
    final String content; 
    final String posterId; 
    final List<String> topics;

  UploadBlogParams({
    required this.image, 
    required this.title, 
    required this.content, 
    required this.posterId, 
    required this.topics
  });
}