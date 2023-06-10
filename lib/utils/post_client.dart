// get post  put delete

import 'dart:convert';

import 'package:http/http.dart';
import 'package:network_https/models/post.dart';
import 'package:http/http.dart' as http;

class PostClient {
  static final baseURL = "https://jsonplaceholder.typicode.com";
  static final postsEndpoint = baseURL + "/posts";

  final client = http.Client();

  Future<Post> fetchPost(int postId) async {
    final url = Uri.parse(postsEndpoint + "/$postId");
    final response = await client.get(url);

    if (response.statusCode == 200) {
      return Post.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load post: $postId');
    }
  }
  Future<Post> createPost(String title, String body) async {
    final url = Uri.parse(postsEndpoint);

     Response response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json;',
      },
      body: jsonEncode({
        'title': title,
        'body': body,
      }),
    );

    if (response.statusCode == 201) {
      return Post.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create post');
    }
  }
  Future<Post> updatePost(int postId, String title, String body) async {
    final url = Uri.parse("https://jsonplaceholder.typicode.com/posts/$postId");
    final response = await http.put(
      url,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'title': title,
        'body': body,
      }),
    );

    if (response.statusCode == 200) {
      return Post.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to update post');
    }
  }
  Future<Post> deletePost(int postId) async {
    final url = Uri.parse(postsEndpoint + "/$postId");
    final response = await http.delete(
      url,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );


    if (response.statusCode == 200) {
      return Post.fromJson({});
    } else {
      throw Exception('Failed to delete post: $postId');
    }
  }
  Future<List<Post>> getPosts() async {
    Response response = await get(Uri.parse(postsEndpoint));
    List<Post> postsList = [];

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      //  for(int i =0 ;  i < body.length ; i++ ){
      //   Map<String , dynamic> map =  body[i] ;
      //
      //    Post post = Post.fromJson(map);
      //
      //     postsList.add(post);
      //
      //
      //  }
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
}
