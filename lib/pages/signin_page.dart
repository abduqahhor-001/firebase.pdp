import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:herewego/pages/home_page.dart';
import 'package:herewego/pages/signup_page.dart';

import '../service/auth_service.dart';


class SignInPage extends StatefulWidget {
  static final String id = "signin_page";

  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  var isLoading = false;
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  void _callSignUpPage() {
    Navigator.pushReplacementNamed(context, SignUpPage.id);
  }

  void _doSignIn(){
    String email = emailController.text.toString().trim();
    String password = passwordController.text.toString().trim();
    if(email.isEmpty || password.isEmpty) return;

    setState(() {
      isLoading = true;
    });
    AuthService.signInUser(email, password).then((value) => {
      responseSignIn(value!),
    });
  }

  void responseSignIn(User firebaseUser)async{
    // You can store user id locally
    setState(() {
      isLoading = false;
    });
    Navigator.pushReplacementNamed(context, HomePage.id);
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
                //#email
                Container(
                  height: 50,
                  padding: EdgeInsets.only(left: 10, right: 10),

                  child: TextField(
                    controller: emailController,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                        hintText: "Email",


                        hintStyle: TextStyle(fontSize: 17, color: Colors.grey)),
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
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                        hintText: "Password",
                        hintStyle: TextStyle(fontSize: 17, color: Colors.grey)),
                  ),
                ),
                //#signin
                GestureDetector(
                  onTap: _doSignIn,
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
                            "Sign In",
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
                      "Don`t have an account?",
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: _callSignUpPage,
                      child: Text(
                        "Sign Up",
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

            isLoading ? Center(
              child: CircularProgressIndicator(),
            ) : SizedBox.shrink(),

          ],
        ),
      ),
    );
  }
}