import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/custom_color.dart';
import '../pages/home_page.dart';
import 'firebase_auth_service.dart';
import 'google_sign_in_button.dart';
import 'forget_password.dart';
import 'signup.dart';

class AuthDialog extends StatefulWidget {
  //const AuthDialog({Key? key}) : super(key: key);
  static const String routeName = "\auth_dialog";

  @override
  _AuthDialogState createState() => _AuthDialogState();
}

class _AuthDialogState extends State<AuthDialog> {
  final _loginFormKey = GlobalKey<FormState>();

  late TextEditingController emailController;
  late FocusNode textFocusNodeEmail;
  bool _isEditingEmail = false;

  late TextEditingController passwordController;
  late FocusNode textFocusNodePassword;
  bool _isEditingPassword = false;

  bool _isRegistering = false;
  bool _isLoggingIn = false;

  bool isLogin = true;
  String errorMsg = '';

  String? loginStatus;
  Color loginStringColor = Colors.green;

  String? _validateEmail(String? value) {
    value = value!.trim();

    if (emailController.text.isNotEmpty) {
      if (value.isEmpty) {
        return 'Email can\'t be empty';
      } else if (!value.contains(
          RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
              r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
              r"{0,253}[a-zA-Z0-9])?)*$"))) {
        return 'Enter a correct email address';
      }
    }

    return null;
  }

  String? _validatePassword(String? value) {
    value = value!.trim();
    RegExp regex = new RegExp(
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
    //print(value);
    if (passwordController.text.isNotEmpty) {
      if (value.isEmpty) {
        return 'Password can\'t be empty';
      } else if (value.length < 6) {
        return 'Length of password should be greater than 6';
      } else {
        if (!regex.hasMatch(value))
          return 'Enter valid password';
        else
          return null;
      }
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    emailController.text = '';
    passwordController.text = '';
    textFocusNodeEmail = FocusNode();
    textFocusNodePassword = FocusNode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: CustomColors.primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            width: 400,
            color: CustomColors.primaryColor,
            child: Form(
              key: _loginFormKey,
              autovalidateMode: AutovalidateMode.always,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Login',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.openSans(
                          color: Colors.white, fontSize: 28),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Enter your email and password below to continue to the Team and let the begin!',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.openSans(
                          color: Colors.white, fontSize: 14),
                    ),
                    const SizedBox(height: 50),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                          color: CustomColors.secondaryColor,
                          border: Border.all(color: Colors.blue)),
                      child: TextFormField(
                        controller: emailController,
                        validator: _validateEmail,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 10),
                            labelText: 'Email Address',
                            labelStyle:
                                GoogleFonts.openSans(color: Colors.white),
                            icon:
                                Icon(Icons.account_circle, color: Colors.white),
                            border: InputBorder.none),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                          color: CustomColors.secondaryColor,
                          border: Border.all(color: Colors.blue)),
                      child: TextFormField(
                        controller: passwordController,
                        validator: _validatePassword,
                        style: GoogleFonts.openSans(color: Colors.white),
                        decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 10),
                            labelText: 'Password',
                            labelStyle:
                                GoogleFonts.openSans(color: Colors.white),
                            icon: Icon(Icons.lock, color: Colors.white),
                            border: InputBorder.none),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {
                              isLogin = false;
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ForgetPasswordScreen(),
                                ),
                              );
                            },
                            child: const Text('Forget Password'),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 5),
                    MaterialButton(
                      elevation: 0,
                      minWidth: double.maxFinite,
                      height: 50,
                      onPressed: () {
                        isLogin = true;
                        _loginUser();
                      },
                      color: CustomColors.logoGreen,
                      child: Text('Login',
                          style: GoogleFonts.openSans(
                              color: Colors.white, fontSize: 16)),
                      textColor: Colors.white,
                    ),
                    const SizedBox(height: 20),
                    FutureBuilder(
                      future: FirebaseAuthService.initializeFirebase(
                          context: context),
                      builder: (context, snapshot) {
                        //print(snapshot.connectionState);
                        if (snapshot.hasError) {
                          return const Text('Error initializing Firebase');
                        } else if (snapshot.connectionState ==
                            ConnectionState.done) {
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
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Don\'t have an account',
                              style: GoogleFonts.openSans(
                                  color: Colors.white, fontSize: 14),
                            ),
                            TextSpan(text: '    '),
                            TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  isLogin = false;
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SignUp(),
                                    ),
                                  );
                                },
                              text: 'Register',
                              style: GoogleFonts.openSans(
                                  decoration: TextDecoration.underline,
                                  color: Colors.blue.shade300,
                                  //fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(errorMsg,
                          style:
                              const TextStyle(color: Colors.red, fontSize: 20)),
                    ),
                    const SizedBox(height: 5),
                    Align(
                        alignment: Alignment.bottomCenter,
                        child: _buildFooterLogo())
                  ]),
            ),
          ),
        ),
      ),
    );
  }

  void _loginUser() async {
    if (_loginFormKey.currentState!.validate()) {
      final email = emailController.text;
      final password = passwordController.text;

      try {
        User? user;
        if (isLogin) {
          user =
              await FirebaseAuthService.loginUser(email: email, pass: password);
        } else {
          //uid = await FirebaseAuthService.registerUser(email,password);
        }
        if (user != null) {
          //Navigator.pushReplacementNamed(context, ChatRoomPage.routeName);
          Navigator.pushReplacementNamed(context, HomePage.routeName);
        }
      } on FirebaseException catch (error) {
        setState(() {
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
        Image.asset('images/pqc.png', height: 40),
        Text('Team & Co. Ltd',
            textAlign: TextAlign.center,
            style: GoogleFonts.openSans(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold)),
      ],
    );
  }
}
