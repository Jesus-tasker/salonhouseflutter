// To parse this JSON data, do
//
//     final trasnbanckModel1 = trasnbanckModel1FromJson(jsonString);

import 'dart:convert';

TrasnbanckModel1 trasnbanckModel1FromJson(String str) =>
    TrasnbanckModel1.fromJson(json.decode(str));

String trasnbanckModel1ToJson(TrasnbanckModel1 data) =>
    json.encode(data.toJson());

class TrasnbanckModel1 {
  TrasnbanckModel1({
    required this.token,
    required this.url,
  });

  String token;
  String url;

  factory TrasnbanckModel1.fromJson(Map<String, dynamic> json) =>
      TrasnbanckModel1(
        token: json["token"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "url": url,
      };
}
