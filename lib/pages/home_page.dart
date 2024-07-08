import 'package:flutter/material.dart';
import 'package:herewego/pages/create_page.dart';
import 'package:herewego/service/auth_service.dart';
import 'package:herewego/service/rtdb_service.dart';

import '../model/post.dart';

class HomePage extends StatefulWidget {
  static final String id = "home_page";
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = false;
  List<Post> items = [];

  Future<void> _callCreatePage() async {
    final results = await Navigator.of(context).push(
      MaterialPageRoute(builder: (BuildContext context) {
        return CreatePage();
      }),
    );
    if (results != null && results.containsKey("data")) {
      print(results['data']);
      _apiPostList();
    }
  }

  Future<void> _apiPostList() async {
    setState(() {
      isLoading = true;
    });
    try {
      var list = await RTDBService.getPosts();
      setState(() {
        items = list;
      });
    } catch (e) {
      print("Error fetching posts: $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _apiPostList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: Text('Home', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          ListView.builder(
            itemCount: items.length,
            itemBuilder: (ctx, index) {
              return itemOfPost(items[index]);
            },
          ),
          if (isLoading)
            Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
        onPressed: _callCreatePage,
        child: Icon(Icons.add),
      ),
    );
  }

  Widget itemOfPost(Post post) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (post.imageUrl != null && post.imageUrl!.isNotEmpty)
            Image.network(post.imageUrl!),
          Row(
            children: [
              Text(
                post.firstname?.toUpperCase() ?? '',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 8),
              Text(
                post.lastname?.toUpperCase() ?? '',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(height: 5),
          Text(post.date?.toUpperCase() ?? ''),
          SizedBox(height: 5),
          Text(post.content?.toUpperCase() ?? ''),
        ],
      ),
    );
  }
}
