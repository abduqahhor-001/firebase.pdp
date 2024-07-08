import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:herewego/pages/home_page.dart';
import 'package:herewego/pages/signin_page.dart';

import '../service/auth_service.dart';


class SignUpPage extends StatefulWidget {
  static final String id = "signup_page";

  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  var isLoading = false;
  var fullnameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var cpasswordController = TextEditingController();

  void _doSignUp() {
    String fullname = fullnameController.text.toString().trim();
    String email = emailController.text.toString().trim();
    String password = passwordController.text.toString().trim();
    String cpassword = cpasswordController.text.toString().trim();

    if (fullname.isEmpty || email.isEmpty || password.isEmpty) return;
    if (cpassword != password) {
      print("Password and confirm password does not match");
      return;
    }

    setState(() {
      isLoading = true;
    });
    AuthService.signUpUser(fullname, email, password).then((value) => {
      responseSignUp(value!),
    });
  }

  void responseSignUp(User firebaseUser) {
    setState(() {
      isLoading = false;
    });
    Navigator.pushReplacementNamed(context, HomePage.id);
  }

  void _callSignInPage() {
    Navigator.pushReplacementNamed(context, SignInPage.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(20),
          color: Colors.white,
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  //#fullname
                  Container(
                    height: 50,
                    padding: EdgeInsets.only(left: 10, right: 10),

                    child: TextField(
                      controller: fullnameController,
                      style: TextStyle(color: Colors.grey),
                      decoration: InputDecoration(
                          hintText: "Fullname",
                          hintStyle:
                          TextStyle(fontSize: 17, color: Colors.grey)),
                    ),
                  ),

                  //#email
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    height: 50,
                    padding: EdgeInsets.only(left: 10, right: 10),

                    child: TextField(
                      controller: emailController,
                      style: TextStyle(color: Colors.grey),
                      decoration: InputDecoration(
                          hintText: "Email",
                          hintStyle:
                          TextStyle(fontSize: 17, color: Colors.grey)),
                    ),
                  ),

                  //#password
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    height: 50,
                    padding: EdgeInsets.only(left: 10, right: 10),

                    child: TextField(
                      controller: passwordController,
                      obscureText: true,
                      style: TextStyle(color: Colors.grey),
                      decoration: InputDecoration(
                          hintText: "Password",
                          hintStyle:
                          TextStyle(fontSize: 17, color: Colors.grey)),
                    ),
                  ),

                  //#cpassword

                  //#signin
                  GestureDetector(
                    onTap: _doSignUp,
                    child: Container(
                        margin: EdgeInsets.only(top: 10),
                        height: 50,
                        padding: EdgeInsets.only(left: 10, right: 10),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: Center(
                            child: Text(
                              "Sign Up",
                              style: TextStyle(color: Colors.white, fontSize: 17),
                            ))),
                  ),

                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Already have an account?",
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: _callSignInPage,
                        child: Text(
                          "Sign In",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              isLoading
                  ? Center(
                child: CircularProgressIndicator(),
              )
                  : SizedBox.shrink(),
            ],
          )),
    );
  }
}