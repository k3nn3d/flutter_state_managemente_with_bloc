import 'package:bloc_app/app/core/utils/calculate_reading_time.dart';
import 'package:bloc_app/app/feature/blog/domain/entities/blog.dart';
import 'package:bloc_app/app/feature/blog/presentation/screens/blog_viewer_screen.dart';
import 'package:flutter/material.dart';

class BlogCard extends StatelessWidget {
  final Blog blog;
  final Color color;
  const BlogCard({
    super.key, 
    required this.blog, 
    required this.color
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => BlogViewerScreen(
            blog: blog 
            ),
          ),
       );
      },
      child: Container(
        height: 200,
        margin: const EdgeInsets.all(16).copyWith(bottom: 4),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: 
                      blog.topics
                    .map((e) => Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Chip(
                        label: Text(e),
                        ),
                    )
                    ).toList(),
                  ),
                ),
                Text(
                  blog.title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22
                    ),
                ),
              ],
            ),
            Text('${calculateReadingTime(blog.content)} min')
          ],
        ),
      ),
    );
  }
}