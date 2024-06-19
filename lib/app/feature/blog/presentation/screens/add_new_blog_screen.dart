import 'dart:io';

import 'package:bloc_app/app/core/theme/app_color.dart';
import 'package:bloc_app/app/core/utils/pick_image.dart';
import 'package:bloc_app/app/feature/blog/presentation/widgets/blog_editor.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class AddNewBlogScreen extends StatefulWidget {
  const AddNewBlogScreen({super.key});

  @override
  State<AddNewBlogScreen> createState() => _AddNewBlogScreenState();
}

class _AddNewBlogScreenState extends State<AddNewBlogScreen> {
  final _titleController =  TextEditingController();
  final _contentController =  TextEditingController();
  List<String> selectedTopics = [];
  File? image;
  void selectImage () async {
    final pickedImage = await pickImage();
    if(pickedImage != null){
      setState(() {
        image = pickedImage;
      });
    }
  }
  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: (){}, 
            icon: const Icon(Icons.done_rounded)
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              image != null ?
              GestureDetector(
                onTap: () {
                  selectImage();
                },
                child: SizedBox(
                  height: 150,
                  width: double.infinity,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.file(
                      image!,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ):  
              GestureDetector(
                onTap: () {
                  selectImage();
                },
                child: DottedBorder(
                  color: AppColor.borderColor,
                  dashPattern: const [10, 4],
                  radius: const Radius.circular(10),
                  borderType: BorderType.RRect,
                  strokeCap: StrokeCap.round,
                  child: const SizedBox(
                    height: 150,
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.folder_open,
                          size: 40,
                        ),
                        SizedBox(height: 15,),
                        Text(
                          'Select your image',
                          style: TextStyle(
                            fontSize: 15
                          ),
                        ),
                      ],
                    ),
                  )
                ),
              ),
              const SizedBox(height: 20,),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    'Tecnology',
                    'Business',
                    'Programing',
                    'Entrtainment'
                  ].map((e) => Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: GestureDetector(
                      onTap: () {
                        if (selectedTopics.contains(e)) {
                          selectedTopics.remove(e);
                        }else{
                          selectedTopics.add(e);
                        }
                        setState(() {});
                      },
                      child: Chip(
                        label: Text(e),
                        color: selectedTopics.contains(e) ? const MaterialStatePropertyAll(AppColor.gradient1Color) : null,
                        side: const BorderSide(
                          color: AppColor.borderColor 
                          ),
                        ),
                    ),
                  )
                  ).toList(),
                ),
              ),
              const SizedBox(height: 10,),
              BlogEditor(controller: _titleController, hintText: 'Title'),
              const SizedBox(height: 10,),
              BlogEditor(controller: _contentController, hintText: 'Content')
            ],
          ),
        ),
      ),
    );
  }
}