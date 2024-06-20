import 'package:bloc_app/app/core/error/failure.dart';
import 'package:bloc_app/app/core/usecases/usecase.dart';
import 'package:bloc_app/app/feature/auth_feature/domain/usecases/current_user.dart';
import 'package:bloc_app/app/feature/blog/domain/entities/blog.dart';
import 'package:bloc_app/app/feature/blog/domain/repositories/blog_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetAllBlogs implements UseCase<List<Blog>, NoParams>{
  final IBlogRepository blogRepository;
  GetAllBlogs(this.blogRepository);
  @override
  Future<Either<Failure, List<Blog>>> call(NoParams params) async{
    return await blogRepository.getAllBlogs();
  }
}