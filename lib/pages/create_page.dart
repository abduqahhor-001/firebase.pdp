import 'package:flutter/material.dart';


import '../model/post.dart';

import '../service/rtdb_service.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({Key? key}) : super(key: key);

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  var isLoading = false;
  var firstnameController = TextEditingController();
  var lastnameController = TextEditingController();
  var contentController = TextEditingController();
  var dateController = TextEditingController();

  _createPost() {
    String firstname = firstnameController.text.toString();
    String lastname = lastnameController.text.toString();
    String content = contentController.text.toString();
    String date = dateController.text.toString();
    if (firstname.isEmpty || lastname.isEmpty || content.isEmpty || date.isEmpty) return;

    _apiCreatePost(firstname, lastname , content , date);
  }

  _apiCreatePost(String firstname, String lastname , String content , String date) {
    setState(() {
      isLoading = true;
    });
    var post =
    Post(firstname: firstname, lastname: lastname,content: content,date: date );
    RTDBService.addPost(post).then((value) => {
      _resAddPost(),
    });
  }

  _resAddPost() {
    setState(() {
      isLoading = false;
    });
    Navigator.of(context).pop({'data': 'done'});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add post"),
        centerTitle: true,
        backgroundColor: Colors.deepOrange,
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextField(
                  controller: firstnameController,
                  decoration: InputDecoration(hintText: "Firstname"),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: lastnameController,
                  decoration: InputDecoration(hintText: "lastname"),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: contentController,
                  decoration: InputDecoration(hintText: "content"),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: dateController,
                  decoration: InputDecoration(hintText: "date"),
                ),
                SizedBox(
                  height: 10,
                ),
                MaterialButton(
                  onPressed: () {
                    _createPost();
                  },
                  color: Colors.deepOrange,
                  child: Text(
                    "Create",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
            isLoading
                ? Center(
              child: CircularProgressIndicator(),
            )
                : SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}