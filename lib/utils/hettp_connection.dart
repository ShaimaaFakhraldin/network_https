import 'dart:convert';
import 'dart:html';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../models/old/post.dart';

class HttpConnection {
  static String baseUrl = "https://jsonplaceholder.typicode.com";
  static String endPoint = "/posts";

  String postUrl = baseUrl + endPoint;

  final Client client = http.Client();

  ///

  Future<List<Post>> getPosts() async {
    Response response = await client.get(Uri.parse(postUrl));
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);

      List<Post> posts = body
          .map(
            (dynamic item) => Post.fromJson(item),
          )
          .toList();
      return posts;
    } else {
      throw "Unable to retrieve posts.";
    }
  }

 Future<Post> createPost()  async {
    Response  response=   await client.post(Uri.parse(postUrl),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',

        }, body: jsonEncode({"title": "mytittle", "body": "hi from dart"}));

      if(response.statusCode == 201){
         Post post = Post.fromJson(jsonDecode(response.body));
          return post ;
      } else{
        throw "Unable to retrieve posts.";

      }

  }
  updatePost(int postId) async{
    Response response =  await client.put(Uri.parse(postUrl+"/${postId}"));
  } 
}
