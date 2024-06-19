import 'package:bloc_app/app/feature/blog/presentation/screens/add_new_blog_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BlogScreen extends StatelessWidget {
  const BlogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blog App'),
        actions: [
          IconButton(
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> const AddNewBlogScreen()));
            }, 
            icon: const Icon(CupertinoIcons.add_circled))
        ],
      ) ,);
  }
}