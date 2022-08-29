
import 'package:flutter/material.dart';
import 'package:food_delivery_with_provider_using_firebase_app/services/firebase_auth_method.dart';
import 'package:food_delivery_with_provider_using_firebase_app/widgets/custom_text_field.dart';
import 'package:provider/provider.dart';

class EmailPasswordSignup extends StatefulWidget {
  static String routeName = '/signup-email-password';
  const EmailPasswordSignup({Key? key}) : super(key: key);

  @override
  _EmailPasswordSignupState createState() => _EmailPasswordSignupState();
}

class _EmailPasswordSignupState extends State<EmailPasswordSignup> {
  
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();

  final _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {

    FirebaseAuthMethods firebaseAuthMethods = Provider.of<FirebaseAuthMethods>(context);
    
    Map<String, String> userSignupData = {
    "user_name": userNameController.text.toString(),
    "email": emailController.text.toString(),
    "password": passwordController.text.toString()
    };

    signUp() {
      if (_formKey.currentState!.validate()) {
        print("Form is valid ");
        _formKey.currentState!.save();
        print('User Sign Up Data $userSignupData');
        firebaseAuthMethods.signUpWithEmail(
          userNameController.text.toString(),
          emailController.text.toString(),
          passwordController.text.toString()
        );
      }
    }

    return Scaffold(
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Sign Up",
              style: TextStyle(fontSize: 30),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.08),
            CustomTextField(
              controller: userNameController,
              hintText: 'Enter your user name',
              suffixIcon: Icons.email,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'User name Required';
                }
                return null;
              },
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.03),
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
              suffixIcon: Icons.key,
              obsecureText: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Password Required';
                }
                return null;
              },
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: (){
                signUp();
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.blue),
                textStyle: MaterialStateProperty.all(
                  const TextStyle(color: Colors.white),
                ),
                minimumSize: MaterialStateProperty.all(
                  Size(MediaQuery.of(context).size.width / 2.5, 50),
                ),
              ),
              child: const Text(
                "Sign Up",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}