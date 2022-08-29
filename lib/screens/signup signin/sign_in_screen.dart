// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:food_delivery_with_provider_using_firebase_app/routes/routes_name.dart';
import 'package:food_delivery_with_provider_using_firebase_app/services/firebase_auth_method.dart';
import 'package:food_delivery_with_provider_using_firebase_app/widgets/sign_in_buttons.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {

    FirebaseAuthMethods firebaseAuthMethods = Provider.of<FirebaseAuthMethods>(context);

    return Scaffold(
      backgroundColor: Colors.grey.shade200,

      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              
              SizedBox(height: 150,),
              Text('Sign in to continue', style: TextStyle(color: Colors.grey),),
              Text('Food App', style: TextStyle(fontSize: 50,color: Colors.teal),),

              SizedBox(height: 20,),
              SignInButtons(
                icon: Icons.android_rounded,
                iconSize: 30, 
                text: 'Sign in with google',
                onTap: (){
                  firebaseAuthMethods.googleSignUpWithDB();
                },
              ),
              SizedBox(height: 20,),
              SignInButtons(
                icon: Icons.apple_rounded, 
                iconSize: 30,
                text: 'Sign in with apple',
                onTap: (){},
              ),
              SizedBox(height: 20,),
              SignInButtons(
                icon: Icons.email, 
                iconSize: 30,
                text: 'Sign in with email',
                onTap: (){
                  Navigator.pushNamed(context, RoutesName.emailsignin);
                },
              ),

              SizedBox(height: 20,),
              Text('By signing in you are agrreing our', style: TextStyle(color: Colors.grey),),
              Text('Terms & Policies', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),)
            ],
          ),
        ),
      ),
    );
  }
}