import 'dart:io';
import 'package:bloc_app/app/core/error/failure.dart';
import 'package:bloc_app/app/feature/blog/domain/entities/blog.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class IBlogRepository{
  Future<Either<Failure, Blog>> uploadBlog({
    required File image,
    required String title,
    required String content,
    required String posterId,
    required List<String> topics,
  });
  Future<Either<Failure, List<Blog>>> getAllBlogs();
}