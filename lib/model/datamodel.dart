import 'package:flutter/material.dart';

class FBData {
  final String full_Picture;
  final String id;
  final String message;
  const FBData({this.id, this.full_Picture, this.message});

  factory FBData.fromJson(Map<String, dynamic> json) {
    return FBData(
      full_Picture: json['picture'],
      message: json['message'],
      id: json['id'],
    );
  }
}

class Data {
  final String image;
  final String title;
  final String text;
  const Data({this.image, this.title, this.text});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      image: json['image'],
      title: json['title'],
      text: json['text'],
    );
  }
}

List<Data> serverFailed = [Data(image:"", title:"", text:"")];
