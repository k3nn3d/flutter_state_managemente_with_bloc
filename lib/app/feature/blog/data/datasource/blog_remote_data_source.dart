import 'dart:io';

import 'package:bloc_app/app/core/error/exception/server_exception.dart';
import 'package:bloc_app/app/feature/blog/data/models/blog_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class IBlogRemoteDataSource{
  Future<BlogModel> uploadBlog(BlogModel blog);
   Future<String> uploadBlogImage({
    required File image,
    required BlogModel blog,
   });
   Future<List<BlogModel>> getAllBlogs();
}
class BlogSupaBaseRemoteDataSourceImpl implements IBlogRemoteDataSource{
  final SupabaseClient supabaseClient;
  BlogSupaBaseRemoteDataSourceImpl({required this.supabaseClient});
  @override
  Future<BlogModel> uploadBlog(BlogModel blog) async{
    try {
      final blogsData = await supabaseClient.from('blogs').insert(blog.toJson()).select();
      return BlogModel.formJson(blogsData.first);
    } catch (e) {
      throw ServerException(message:  e.toString());
    }
  }
  
  @override
  Future<String> uploadBlogImage({required File image, required BlogModel blog}) async {
    try {
      await supabaseClient.storage.from('blog_images').upload(
        blog.id,
        image
      );
      return supabaseClient.storage.from('blog_images').getPublicUrl(blog.id);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
  
  @override
  Future<List<BlogModel>> getAllBlogs() async {
    try {
      final blogs = await supabaseClient.from('blogs').select('*, profiles (name)');
      return blogs.map((blog) => BlogModel.formJson(blog).copyWith(posterName: blog['profiles']['name'])).toList();
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

}