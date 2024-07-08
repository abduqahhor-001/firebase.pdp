import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../model/post.dart';
import '../service/rtdb_service.dart';
import '../service/store_service.dart';

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

  File? _image;
  final picker = ImagePicker();

  Future<void> _createPost() async {
    String firstname = firstnameController.text.trim();
    String lastname = lastnameController.text.trim();
    String content = contentController.text.trim();
    String date = dateController.text.trim();
    if (firstname.isEmpty || lastname.isEmpty || content.isEmpty || date.isEmpty) return;

    String? imageUrl;
    if (_image != null) {
      imageUrl = await StoreService.uploadImage(_image!);
    }

    var post = Post(
      firstname: firstname,
      lastname: lastname,
      content: content,
      date: date,
      imageUrl: imageUrl,
    );

    _apiCreatePost(post);
  }

  void _apiCreatePost(Post post) {
    setState(() {
      isLoading = true;
    });
    RTDBService.addPost(post).then((value) => {
      _resAddPost(),
    });
  }

  void _resAddPost() {
    setState(() {
      isLoading = false;
    });
    Navigator.of(context).pop({'data': 'done'});
  }

  Future<void> _getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print("No image selected");
      }
    });
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
                GestureDetector(
                  onTap: _getImage,
                  child: Container(
                    height: 100,
                    width: 100,
                    child: _image != null
                        ? Image.file(_image!, fit: BoxFit.cover)
                        : Image.asset("assets/images/ic_camera.png"),
                  ),
                ),
                TextField(
                  controller: firstnameController,
                  decoration: InputDecoration(hintText: "Firstname"),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: lastnameController,
                  decoration: InputDecoration(hintText: "Lastname"),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: contentController,
                  decoration: InputDecoration(hintText: "Content"),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: dateController,
                  decoration: InputDecoration(hintText: "Date"),
                ),
                SizedBox(height: 10),
                MaterialButton(
                  onPressed: _createPost,
                  color: Colors.deepOrange,
                  child: Text(
                    "Create",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
            if (isLoading)
              Center(
                child: CircularProgressIndicator(),
              ),
          ],
        ),
      ),
    );
  }
}
