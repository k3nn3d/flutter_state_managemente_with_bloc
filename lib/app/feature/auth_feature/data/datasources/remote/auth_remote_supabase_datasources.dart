import 'package:bloc_app/app/core/error/exception/server_exception.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthRemoteDataSource{
 Future<String> singUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }); 
  Future<String> loginWithEmailPassword({
    required String email,
    required String password,
  }); 
}
class AuthRemoteSupaBaseDataSourceImpl implements AuthRemoteDataSource{
  final SupabaseClient supabaseClient;
  AuthRemoteSupaBaseDataSourceImpl(this.supabaseClient);
  @override
  Future<String> loginWithEmailPassword({required String email, required String password}) {
    // TODO: implement loginWithEmailPassword
    throw UnimplementedError();
  }

  @override
  Future<String> singUpWithEmailPassword({required String name,
   required String email,
  required String password})async {
    try {
      final response = await supabaseClient.auth.signUp(password: password, email: email, data:{
        'name' : name
        }
      );
      if (response.user == null) {
        throw ServerException(message: "User is null!");
      }
      return response.user!.id;
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

}