// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

String welcomeToJson(Welcome data) => json.encode(data.toJson());

class Welcome {
  String greeting;
  List<String> instructions;

  Welcome({
    required this.greeting,
    required this.instructions,
  });

  factory Welcome.fromJson(Map<String, dynamic> json) {
    List myLis = List<String>.from(["" ,"" ,""]);
    List<String> value = [];
    value.map((e) => null);

    List mm  = json["instructions"].map((x) => x) ;

    return  Welcome(
      greeting: json["greeting"],
      instructions: json["instructions"].map((x) => x) ,
    );
  }


  Map<String, dynamic> toJson() => {
    "greeting": greeting,
    "instructions": List<dynamic>.from(instructions.map((x) => x)),
  };
}
