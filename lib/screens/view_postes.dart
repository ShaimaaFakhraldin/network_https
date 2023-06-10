import 'package:flutter/material.dart';
import 'package:network_https/models/post.dart';
 import 'package:network_https/utils/post_client.dart';

class ViewPostes extends StatefulWidget {
  const ViewPostes({Key? key}) : super(key: key);

  @override
  State<ViewPostes> createState() => _ViewPostesState();
}

class _ViewPostesState extends State<ViewPostes> {

  PostClient postClient =PostClient();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(title:  Text("get data"),),
      body: FutureBuilder(
        future: postClient.getPosts() ,
        builder: (BuildContext con , AsyncSnapshot<List<Post>> snapshot){
          if(snapshot.hasData){
             return ListView.builder(
               itemCount:  snapshot.data!.length,
                 itemBuilder: (BuildContext con , int index){
                return
                  ListTile(
                    title: Text(snapshot.data![index].title),
                    subtitle: Text("${snapshot.data![index].userId}"),
                  );
             });
          } else if (!snapshot.hasData){
            return Center(
              child:  Text("hase no data  "),
            );
          } else if (snapshot.hasError){
            return Center(
              child:  Text("Some thinge error"),
            );

          }

          else {
            return  const Center(child:  CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
