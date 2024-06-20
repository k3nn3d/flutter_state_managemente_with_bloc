import 'package:bloc_app/app/feature/blog/data/models/blog_model.dart';
import 'package:hive/hive.dart';

abstract interface class IBlogLocalDataSource{
  void uploadLocalBlogs({ required List<BlogModel> blogs});
  List<BlogModel> loadBlogs();
}

class BlogLocalDataSourceImpl implements IBlogLocalDataSource{
  final Box box;
  BlogLocalDataSourceImpl(this.box);
  
  @override
  List<BlogModel> loadBlogs() {
    List<BlogModel> blogs = [];
    for (var i = 0; i < box.length; i++) {
      blogs.add(BlogModel.formJson(box.get(i.toString())));
    }
    return blogs;
  }

  @override
  void uploadLocalBlogs({required List<BlogModel> blogs}) {
    box.clear();
    for (var i = 0; i < blogs.length; i++) {
      box.put(i.toString(), blogs[i].toJson());
    }
  }

}