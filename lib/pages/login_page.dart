import 'package:chat_app/auth/firebase_auth_service.dart';
import 'package:chat_app/auth/google_sign_in_button.dart';
import 'package:chat_app/pages/chat_room_page.dart';
import 'package:chat_app/utils/custom_color.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'home_page.dart';

class LoginPage extends StatefulWidget {
  static const String routeName = "\login";

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isLogin = true;
  String errorMsg = '';

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        backgroundColor: CustomColors.primaryColor,
        body: Form(
          key: _formKey,
          child: Container(
          alignment: Alignment.topCenter,
            margin: const EdgeInsets.symmetric(horizontal: 30),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Sign in to Chat Room and continue',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.openSans(color: Colors.white, fontSize: 28),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Enter your email and password below to continue to the Team and let the begin!',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.openSans(color: Colors.white, fontSize: 14),
                  ),
                  const SizedBox(height: 50,),
                  //_buildTextFormField(emailController, Icons.account_circle, 'Email Address'),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(color: CustomColors.secondaryColor, border: Border.all(color: Colors.blue)),
                    child: TextFormField(
                      controller: emailController,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 10),
                          labelText: 'Email Address',
                          labelStyle: TextStyle(color: Colors.white),
                          icon: Icon(Icons.account_circle, color: Colors.white),
                          border: InputBorder.none
                      ),
                      validator: (value){
                        if(value==null || value.isEmpty){
                          return 'Please provide a valid email address.';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  //_buildTextFormField(passwordController, Icons.lock, 'Password'),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(color: CustomColors.secondaryColor, border: Border.all(color: Colors.blue)),
                    child: TextFormField(
                      controller: passwordController,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 10),
                          labelText: 'Password',
                          labelStyle: TextStyle(color: Colors.white),
                          icon: Icon(Icons.lock, color: Colors.white),
                          border: InputBorder.none
                      ),
                      validator: (value){
                        if(value==null || value.isEmpty){
                          return 'Please provide a valid password.';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 30),
                  MaterialButton(
                    elevation: 0,
                    minWidth: double.maxFinite,
                    height: 50,
                    onPressed: () {
                      isLogin = true;
                      _loginUser();
                    },
                    color: CustomColors.logoGreen,
                    child: const Text('Login',style: TextStyle(color: Colors.white, fontSize: 16)),
                    textColor: Colors.white,
                  ),
                  const SizedBox(height: 20),
                  FutureBuilder(
                    future: FirebaseAuthService.initializeFirebase(context: context),
                    builder: (context, snapshot) {
                      //print(snapshot.connectionState);
                      if (snapshot.hasError) {
                        return const Text('Error initializing Firebase');
                      } else if (snapshot.connectionState == ConnectionState.done) {
                        return GoogleSignInButton();
                      }
                      return const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          CustomColors.firebaseOrange,
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Not register yet? ',style: TextStyle( color: Colors.white, fontSize: 13 )),
                        TextButton(
                          onPressed: (){
                            isLogin = false;
                            _loginUser();
                          },
                          child: const Text('Register'),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(errorMsg,style: const TextStyle( color: Colors.red, fontSize: 20 )),
                  ),
                  const SizedBox(height: 5),
                  Align(alignment: Alignment.bottomCenter,child: _buildFooterLogo())
                ],
              ),
          ),
        )
      )
    );
  }

  void _loginUser() async{
    if(_formKey.currentState!.validate()){
      final email = emailController.text;
      final password = passwordController.text;

      try{
        String? uid;
        if(isLogin){
          uid = await FirebaseAuthService.loginUser(email,password);
        }else{
          uid = await FirebaseAuthService.registerUser(email,password);
        }
        if(uid != null){
          //Navigator.pushReplacementNamed(context, ChatRoomPage.routeName);
          Navigator.pushReplacementNamed(context, HomePage.routeName);
        }
      } on FirebaseException catch(error){
        setState((){
          errorMsg = error.message!;
        });
        rethrow;
      }
    }
  }

  _buildFooterLogo() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Image.asset(
          'images/pqc.png',
          height: 40,
        ),
        Text('Team & Co. Ltd',
            textAlign: TextAlign.center,
            style: GoogleFonts.openSans(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold)),
      ],
    );
  }
}