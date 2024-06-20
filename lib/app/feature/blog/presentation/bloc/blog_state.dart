part of 'blog_bloc.dart';
@immutable
sealed class BlogState{}
final class BlogInitialState extends BlogState{}

final class BlogLoadingState extends BlogState{}

final class BlogUploadSuccessState extends BlogState{
  final Blog blog;
  BlogUploadSuccessState(this.blog);
}
final class BlogSuccessDisplayState extends BlogState{
  final List<Blog> blogs;
  BlogSuccessDisplayState(this.blogs);
}

final class BlogFailureState extends BlogState{
  final String error;
  BlogFailureState(this.error);
}