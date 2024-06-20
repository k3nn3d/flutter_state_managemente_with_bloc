part of 'blog_bloc.dart';
@immutable
sealed class BlogEvent{}
final class BlogUpLoadEvent extends BlogEvent{
  final File image; 
  final String title; 
  final String content; 
  final String posterId; 
  final List<String> topics;

  BlogUpLoadEvent({
    required this.image, 
    required this.title, 
    required this.content, 
    required this.posterId, 
    required this.topics
  });
}

final class BlogGetAllEvent extends BlogEvent {}