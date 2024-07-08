import 'package:flutter/material.dart';
import 'package:herewego/service/auth_service.dart';

class HomePage extends StatefulWidget {
  static final String id = "home_page";
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: Text('Home',style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: Center(
        child: MaterialButton(
          onPressed: (){
            AuthService.signOutUser(context);
          },
          child: Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.deepOrange,
                borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            child: Text('logout',style: TextStyle(color: Colors.white),),
  
          ),
        ),
      ),
    );
  }
}
