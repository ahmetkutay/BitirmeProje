import 'package:flutter/material.dart';
import 'package:newestapp3/model/tweet.dart';
import 'package:newestapp3/model/user_model.dart';
import 'package:newestapp3/model/favori_model.dart';
import 'package:newestapp3/model/yorum.dart';
import 'package:newestapp3/repository/userrepository.dart';

import 'model/category_model.dart';

enum Durum { Bos, Mesgul }

class UserProvider with ChangeNotifier {
  UserRepository _userrepo = UserRepository();
  User _user;
  Durum _durum = Durum.Bos;

  get user => _user;
  set user(User value) => _user = value;

  set durum(value) {
    _durum = value;
    notifyListeners();
  }

  get durum => _durum;

  void login(@required String email, @required String password) async {
    try {
      durum = Durum.Mesgul;
      User response = await _userrepo.loginUser(email, password);
      if (response != null) {
        user = response;
      } else {}
    } catch (e) {
      debugPrint("USerProvider  sigUp hatası  :" + e.toString());
    } finally {
      durum = Durum.Bos;
    }
  }

  void signUp(@required String name, @required String email,
      @required String password) async {
    try {
      durum = Durum.Mesgul;
      var response = await _userrepo.createUser(name, email, password);
      if (response != null) {
        user = User(response.name, response.id, response.email);
      } else {}
    } catch (e) {
      debugPrint("USerProvider  sigUp hatası  :" + e.toString());
    } finally {
      durum = Durum.Bos;
    }
  }

  void logOut() {
    user = null;
    durum = Durum.Bos;
  }

  Future<List<Category>> movieget() async {
    List<Category> category = await _userrepo.fetchmovie();
    return category;
  }

  Future<List<Category>> diziget() async {
    List<Category> category = await _userrepo.fetchdizi();
    return category;
  }

  Future<List<Category>> kitapget() async {
    List<Category> category = await _userrepo.fetchbooks();
    return category;
  }

  Future<bool> favorifilmekle(Map<String, dynamic> fav) async {
    var response = await _userrepo.favfilmekle(fav);
    debugPrint(response.toString());
    return response;
  }

  Future<bool> favoridizimekle(Map<String, dynamic> fav) async {
    var response = await _userrepo.favdizimekle(fav);
    debugPrint(response.toString());
    return response;
  }

  Future<bool> favorikitapekle(Map<String, dynamic> fav) async {
    var response = await _userrepo.favkitapekle(fav);
    debugPrint(response.toString());
    return response;
  }

  Future<List<FavoriModel>> favoriler(String id) async {
    var response = await _userrepo.getfav(id);
    return response;
  }

  Future<List<FavoriModel>> favoridiziler(String id) async {
    var response = await _userrepo.getdizi(id);
    return response;
  }

  Future<List<FavoriModel>> favorikitaplar(String id) async {
    var response = await _userrepo.getkitap(id);
    return response;
  }

  Future<List<Yorum>> content_comments(String id) async {
    var response = await _userrepo.getconcomments(id);
    return response;
  }

  Future<bool> yorumekle(Yorum x) async {
    var response = await _userrepo.insertyorum(x);
    return response;
  }

  Future<List<Yorum>> kullaniciyorumListe(String x) async {
    var response = await _userrepo.getuseryourm(x);
    return response;
  }

  Future<bool> yorumsil(String userId, String objectId) async {
    var response = await _userrepo.yorumsil(userId, objectId);
    return response;
  }

  Future<bool> yorumupdate(Yorum x) async {
    var response = await _userrepo.yorumupdate(x);
    return response;
  }

  Future<bool> favoridelete(String userId, String objectId) async {
    var response = await _userrepo.favoridelete(userId, objectId);
    return response;
  }

  Future<bool> tweetekle(Map<String, dynamic> x) async {
    var response = await _userrepo.inserttweet(x);
    return response;
  }

  Future<List<TweetModel>> userstweet() async {
    var response = await _userrepo.getusersTweet();
    return response;
  }

  Future<List<TweetModel>> getusertweet(String id) async {
    var response = await _userrepo.getuserTweet(id);
    return response;
  }

  Future<bool> tweetupdate(Map<String, dynamic> x) async {
    var response = await _userrepo.tweetupdate(x);
    return response;
  }

  Future<bool> tweetsil(String id) async {
    var response = await _userrepo.tweetsil(id);
    return response;
  }

  Future<bool> followuser(Map<String, dynamic> x) async {
    var response = await _userrepo.followuser(x);
    return response;
  }

  Future<dynamic> followedUser(String id) async {
    var response = await _userrepo.followeduser(id);
    return response;
  }

  Future<bool> deletefollow(
      String id, String kullaniciId, String followuserId) async {
    var response =
        await _userrepo.deletefolloweduser(id, kullaniciId, followuserId);
    return response;
  }

  Future<dynamic> followmeUser(String id) async {
    var response = await _userrepo.followmeuser(id);
    return response;
  }
}
