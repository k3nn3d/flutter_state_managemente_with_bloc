import 'package:bloc_app/app/core/theme/app_color.dart';
import 'package:bloc_app/app/core/theme/text_style.dart';
import 'package:bloc_app/app/feature/auth_feature/presenation/screens/sign_up_screen.dart';
import 'package:bloc_app/app/feature/auth_feature/presenation/widgets/auth_gradient_button.dart';
import 'package:bloc_app/app/feature/auth_feature/presenation/widgets/auth_textfiled.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>(); 
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Padding(
        padding:const EdgeInsets.all(15.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text("Sign In",
                style:AppTextStyle.titleStyle1
              ),
              const SizedBox(height: 30,),
              AuthTextField(title: "Email", controller: _emailController),
              const SizedBox(height: 10,),
              AuthTextField(title: "Password", controller: _passwordController, obscureText: true,),
              const SizedBox(height: 10,),
              AuthGradientButton(onPressed: (){
                _formKey.currentState?.validate();
              }, title: "Sign In"),
              const SizedBox(height: 30,),
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const SignUpScreen()));
                },
                child: RichText(text: TextSpan(
                  style: Theme.of(context).textTheme.titleMedium,
                  text: "Don't have an account?",
                  children: [
                    TextSpan(text:" Sign Up",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(color: AppColor.gradient2Color )),
                  ]),
                ),
              ),
            ]
          ,),
        ),
      ) 
    ,);
  }
}