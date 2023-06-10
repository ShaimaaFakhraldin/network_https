import 'package:flutter/material.dart';
import 'package:network_https/utils/post_client.dart';

import '../models/post.dart';

class PostsPage extends StatelessWidget {
  final PostClient _postClient = PostClient();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Posts"),
      ),
      body: FutureBuilder(
        future: _postClient.getPosts(),
        builder: (BuildContext context, AsyncSnapshot<List<Post>> snapshot) {
          if (snapshot.hasData) {
            List<Post> posts = snapshot.data!;
            return ListView.builder(
                itemCount: posts.length,
                itemBuilder: (BuildContext con, int index) {
                  return InkWell(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext con) {
                            return AlertDialog(
                              content: Container(
                                height: 300,
                                width: 300,
                                child: EditPost(postId: posts[index].id),
                              ),
                            );
                          });
                    },
                    child: ListTile(
                      leading: Text("id ${posts[index].id}"),
                      title: Text(posts[index].title),
                      subtitle: Text(posts[index].body),
                    ),
                  );
                });
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

class EditPost extends StatefulWidget {
  final int postId;

  const EditPost({Key? key, required this.postId}) : super(key: key);

  @override
  State<EditPost> createState() => _EditPostState();
}

class _EditPostState extends State<EditPost> {
  String? title;

  String? body;

  var client = PostClient();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("id : ${widget.postId}"),
        SizedBox(
          height: 20,
        ),
        TextField(
          decoration: InputDecoration(
            hintText: "Enter Title",
            labelText: "Enter Title",
          ),
          onChanged: (String? value) {
            setState(() {
              title = value;
            });
          },
        ),
        SizedBox(
          height: 20,
        ),
        TextField(
          decoration: InputDecoration(
            hintText: "Enter body",
            labelText: "Enter body",
          ),
          onChanged: (String? value) {
            setState(() {
              body = value;
            });
          },
        ),
        SizedBox(
          height: 20,
        ),
        ElevatedButton(
            onPressed: () async {
              await client
                  .updatePost(widget.postId, title!, body!)
                  .then((value) {
                Navigator.pop(context);
              });
            },
            child: Text("Save change"))
      ],
    );
  }
}
