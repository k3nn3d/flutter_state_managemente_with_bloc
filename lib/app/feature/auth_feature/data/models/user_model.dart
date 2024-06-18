import 'package:bloc_app/app/feature/auth_feature/domain/entities/user_entity.dart';

class UserModel extends User{
  UserModel({
    required super.id, 
    required super.email, 
    required super.name
  });
  factory UserModel.fromJson(Map<String, dynamic> map){
    return UserModel(
      id: map["id"] ?? "", 
      email: map["email"] ?? "", 
      name: map["name"] ?? ""
    );
  }

}