

 class Post {
   final int userId;
   final int id;
   final String title;
   final String body;

   Post({
     required this.userId,
     required this.id,
     required this.title,
     required this.body,
   });

  factory Post.fromJson(Map<String, dynamic> json) {
        return Post(
      id: json['id'] ?? 0 ,
      userId: json['userId'] ?? 0,
      title: json['title']  ?? ""  ,
      body: json['body'] ??"" ,
    );
  }













  Map<String, dynamic> toJson() {

    return{
      'id':  id,
      'userId':  userId,
      'title':  title,
      'body':  body,
    };
  }
}
