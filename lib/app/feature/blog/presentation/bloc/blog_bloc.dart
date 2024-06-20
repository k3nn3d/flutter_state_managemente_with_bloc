import 'dart:io';
import 'package:bloc_app/app/feature/auth_feature/domain/usecases/current_user.dart';
import 'package:bloc_app/app/feature/blog/domain/entities/blog.dart';
import 'package:bloc_app/app/feature/blog/domain/usecases/get_all_blogs.dart';
import 'package:bloc_app/app/feature/blog/domain/usecases/upload_blog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'blog_event.dart';
part 'blog_state.dart';
class BlogBloc extends Bloc<BlogEvent, BlogState>{
  final UploadBlog _uploadBlog;
  final GetAllBlogs _getAllBlogs;
  BlogBloc({
    required UploadBlog uploadBlog, 
    required GetAllBlogs getAllBlogs
  }): _uploadBlog = uploadBlog,
   _getAllBlogs = getAllBlogs,
   super(BlogInitialState()){
    on<BlogEvent>((event, emit) => emit(BlogLoadingState()));
    on<BlogUpLoadEvent>(_onBlogUpload);
    on<BlogGetAllEvent>(_onBlogGetAll);
  }
  void _onBlogUpload(
    BlogUpLoadEvent event, 
    Emitter<BlogState> emit
  ) async{
    final res = await _uploadBlog(UploadBlogParams(
      image: event.image, 
      title: event.title, 
      content: event.content, 
      posterId: event.posterId, 
      topics: event.topics
      )
    );
    res.fold(
      (failure) => emit(BlogFailureState(failure.message)),
      (blog) => emit(BlogUploadSuccessState(blog))
    );
  }
  void _onBlogGetAll(
    BlogGetAllEvent event, 
    Emitter<BlogState> emit
  ) async{
    final res = await _getAllBlogs(NoParams());
    res.fold(
      (failure) => emit(BlogFailureState(failure.message)),
      (blogs) => emit(BlogSuccessDisplayState(blogs))
    );
  }
}