import 'package:chat_app/auth/firebase_auth_service.dart';
import 'package:chat_app/pages/chat_room_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatefulWidget {
  static final String routeName = "\login";

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final Color primaryColor = Color(0xff18203d);
  final Color secondaryColor = Color(0xff232c51);

  final Color logoGreen = Color(0xff25bcbb);

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
        backgroundColor: primaryColor,
        body: Form(
          key: _formKey,
          child: Container(
          alignment: Alignment.topCenter,
            margin: EdgeInsets.symmetric(horizontal: 30),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Sign in to CHAT Room and continue',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.openSans(color: Colors.white, fontSize: 28),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Enter your email and password below to continue to the Team and let the begin!',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.openSans(color: Colors.white, fontSize: 14),
                  ),
                  SizedBox(height: 50,),
                  //_buildTextFormField(emailController, Icons.account_circle, 'Email Address'),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(color: secondaryColor, border: Border.all(color: Colors.blue)),
                    child: TextFormField(
                      controller: emailController,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
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
                  SizedBox(height: 20),
                  //_buildTextFormField(passwordController, Icons.lock, 'Password'),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(color: secondaryColor, border: Border.all(color: Colors.blue)),
                    child: TextFormField(
                      controller: passwordController,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
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
                  SizedBox(height: 30),
                  MaterialButton(
                    elevation: 0,
                    minWidth: double.maxFinite,
                    height: 50,
                    onPressed: () {
                      isLogin = true;
                      _loginUser();
                    },
                    color: logoGreen,
                    child: Text('Login',style: TextStyle(color: Colors.white, fontSize: 16)),
                    textColor: Colors.white,
                  ),
                  SizedBox(height: 20),
                  MaterialButton(
                    elevation: 0,
                    minWidth: double.maxFinite,
                    height: 50,
                    onPressed: () {
                      //_signInWithGoogle();
                    },
                    color: Colors.blue,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(FontAwesomeIcons.google),
                        SizedBox(width: 10),
                        Text(
                          'Sign-in using Google',
                          style: TextStyle( color: Colors.white, fontSize: 16 )
                        ),
                      ],
                    ),
                    textColor: Colors.white,
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Not register yet? ',style: TextStyle( color: Colors.white, fontSize: 13 )),
                        TextButton(
                          onPressed: (){
                            isLogin = false;
                            _loginUser();
                          },
                          child: Text('Register'),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(errorMsg,style: TextStyle( color: Colors.red, fontSize: 20 )),
                  ),
                  SizedBox(height: 10),
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
          Navigator.pushReplacementNamed(context, ChatRoomPage.routeName);
        }
      }catch(error){
        setState((){
          errorMsg = error.toString();
        });
        throw error;
      }
    }
  }

  // _signInWithGoogle() async {
  //   final GoogleSignInAccount googleUser = await googleSignIn.signIn();
  //   final GoogleSignInAuthentication googleAuth =
  //   await googleUser.authentication;
  //
  //   final AuthCredential credential = GoogleAuthProvider.getCredential(
  //       idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);
  //
  //   final FirebaseUser user = (await firebaseAuth.signInWithCredential(credential)).user;
  // }

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

  // _buildTextFormField(TextEditingController controller, IconData icon,String labelText) {
  //   return Container(
  //     padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
  //     decoration: BoxDecoration(color: secondaryColor, border: Border.all(color: Colors.blue)),
  //     child: TextFormField(
  //       controller: controller,
  //       style: TextStyle(color: Colors.white),
  //       decoration: InputDecoration(
  //         contentPadding: EdgeInsets.symmetric(horizontal: 10),
  //         labelText: labelText,
  //         labelStyle: TextStyle(color: Colors.white),
  //         icon: Icon(icon, color: Colors.white),
  //         border: InputBorder.none
  //       ),
  //       validator: (value){
  //         if(value==null || value.isEmpty){
  //           return 'Please provide a valid email address.';
  //         }
  //         return null;
  //       },
  //     ),
  //   );
  // }
}