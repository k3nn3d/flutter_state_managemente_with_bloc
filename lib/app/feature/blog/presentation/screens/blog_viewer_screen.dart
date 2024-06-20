import 'package:bloc_app/app/core/theme/app_color.dart';
import 'package:bloc_app/app/core/utils/calculate_reading_time.dart';
import 'package:bloc_app/app/core/utils/format_date.dart';
import 'package:bloc_app/app/feature/blog/domain/entities/blog.dart';
import 'package:flutter/material.dart';

class BlogViewerScreen extends StatelessWidget {
  final Blog blog;
  const BlogViewerScreen({super.key, required this.blog});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  blog.title,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold
                  ),
                ),
                const SizedBox(height: 20,),
                Text('By ${blog.posterName}', style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16
                  ),
                ),
                const SizedBox(height: 5,),
                Text('${formatrdateBydMMMYYY(blog.updatedAt)} . ${calculateReadingTime(blog.content)} min',
                style: const TextStyle(
                  color: AppColor.greyColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w500
                  ),
                ),
                const SizedBox(height: 20,),
                SizedBox(
                  height: 200,
                  width: double.maxFinite,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(blog.imageUrl, fit: BoxFit.cover,),
                  ),
                ),
                const SizedBox(height: 20,),
                Text(blog.content, style: const TextStyle(
                  fontSize: 16,
                  height: 2
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}