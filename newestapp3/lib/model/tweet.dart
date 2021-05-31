import 'package:flutter/cupertino.dart';

class TweetModel {
  String objectId;
  String urun_Id;
  String kullanici_tweet;
  String kullanici_Id;
  String kullanici_name;

  TweetModel(
      {this.objectId,
      @required this.urun_Id,
      @required this.kullanici_tweet,
      @required this.kullanici_Id,
      @required this.kullanici_name});

  factory TweetModel.fromJSON(Map<String, dynamic> data) {
    return TweetModel(
        objectId: data["_Id"],
        urun_Id: data["urun_Id"],
        kullanici_name: data["kullanici_name"],
        kullanici_tweet: data["kullanici_Yorum"],
        kullanici_Id: data["kullanici_Id"]);
  }
}
