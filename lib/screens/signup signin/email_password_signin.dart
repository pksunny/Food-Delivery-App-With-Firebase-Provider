
// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:food_delivery_with_provider_using_firebase_app/routes/routes_name.dart';
import 'package:food_delivery_with_provider_using_firebase_app/services/firebase_auth_method.dart';
import 'package:food_delivery_with_provider_using_firebase_app/widgets/custom_button.dart';
import 'package:food_delivery_with_provider_using_firebase_app/widgets/custom_text_field.dart';
import 'package:provider/provider.dart';

class EmailPasswordSignin extends StatefulWidget {
  static String routeName = '/signup-email-password';
  const EmailPasswordSignin({Key? key}) : super(key: key);

  @override
  _EmailPasswordSigninState createState() => _EmailPasswordSigninState();
}

class _EmailPasswordSigninState extends State<EmailPasswordSignin> {
  
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    FirebaseAuthMethods firebaseAuthMethods = Provider.of<FirebaseAuthMethods>(context);

    Map<String, String> userLoginData = {
      "email": emailController.text.toString(), 
      "password": passwordController.text.toString()
    };

    login() {
    if (_formKey.currentState!.validate()) {
      print("Form is valid ");
      _formKey.currentState!.save();
      print('Data for login $userLoginData');
      firebaseAuthMethods.emailSignIn(emailController.text.toString(),passwordController.text.toString());
    }
  }
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Sign In",
              style: TextStyle(fontSize: 30),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.08),
            CustomTextField(
              controller: emailController,
              hintText: 'Enter your email',
              suffixIcon: Icons.email,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Email Required';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            CustomTextField(
              controller: passwordController,
              hintText: 'Enter your password',
              obsecureText: true,
              suffixIcon: Icons.key,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Password Required';
                }
                return null;
              },
            ),
            const SizedBox(height: 40),
            CustomButton(
              onTap: (){
                login();
              }, 
              text: 'Sign In',
            ),
      
            SizedBox(height: 10,),
            Text("Don't have an account?", style: TextStyle(color: Colors.grey),),
            InkWell(
              onTap: (){
                Navigator.pushNamed(context, RoutesName.emailsignup);
              },
              child: Text('Signup here!', style: TextStyle(color: Colors.teal, fontWeight: FontWeight.bold),)
            ),
          ],
        ),
      ),
    );
  }
}