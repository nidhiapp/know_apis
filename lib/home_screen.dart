import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:know_apis/modals/posts_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<PostsModel> postList = [];
  Future<List<PostsModel>> getPostApi() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      postList.clear();
      for (Map<String, dynamic> i in data) {
        postList.add(PostsModel.fromJson(i));
      }
      return postList;
    } else {
      return postList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("api demo"),
      ),
      body: Column(
        children: [
          FutureBuilder(
              future: getPostApi(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Text("Loading");
                } else {
                  return Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    postList[index].title.toString(),
                                    style: TextStyle(color: Colors.blue),
                                  ),
                                ),
                                Text(
                                  postList[index].body.toString(),
                                  style: TextStyle(color: Colors.red),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      itemCount: postList.length,
                    ),
                  );
                }
              })
        ],
      ),
    );
  }
}
