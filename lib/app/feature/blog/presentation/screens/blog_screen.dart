import 'package:bloc_app/app/core/common/widgets/loader.dart';
import 'package:bloc_app/app/core/theme/app_color.dart';
import 'package:bloc_app/app/core/utils/show_snackbar.dart';
import 'package:bloc_app/app/feature/blog/presentation/bloc/blog_bloc.dart';
import 'package:bloc_app/app/feature/blog/presentation/screens/add_new_blog_screen.dart';
import 'package:bloc_app/app/feature/blog/presentation/widgets/blog_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlogScreen extends StatefulWidget {
  const BlogScreen({super.key});

  @override
  State<BlogScreen> createState() => _BlogScreenState();
}

class _BlogScreenState extends State<BlogScreen> {
  @override
  void initState() {
    context.read<BlogBloc>().add(BlogGetAllEvent());
    super.initState();
  }
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
            icon: const Icon(CupertinoIcons.add_circled),
          )
        ],
      ),
      body: BlocConsumer<BlogBloc, BlogState>(
        listener:(context, state) {
          if(state is BlogFailureState){
            showSnackBar(context, state.error);
          }
        },
        builder: (context, state){
          if (state is BlogLoadingState) {
            return const Loader();
          }
          if (state is BlogSuccessDisplayState) {
            return ListView.builder(
              itemCount: state.blogs.length,
              itemBuilder: (context, index){
                final blog = state.blogs[index];
                return BlogCard(
                  blog: blog,
                  color: index % 3 == 0 ?
                   AppColor.gradient1Color : index % 3 == 1 ?
                   AppColor.gradient2Color : AppColor.gradient3Color,
                  );
              }
            );
          }
          return const SizedBox();
        },
        ),
    );
  }
}