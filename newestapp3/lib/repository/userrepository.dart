import 'package:newestapp3/model/category_model.dart';
import 'package:newestapp3/model/favori_model.dart';
import 'package:newestapp3/model/tweet.dart';
import 'package:newestapp3/model/user_model.dart';
import 'package:newestapp3/model/yorum.dart';
import 'package:newestapp3/network/service.dart';

class UserRepository {
  Authentication _authentication = Authentication();

  Future<User> createUser(String name, String email, String password) async {
    var answer =
        await _authentication.createUserEmailandPassword(name, email, password);
    return answer;
  }

  Future<User> loginUser(String email, String password) async {
    var answer = await _authentication.loginEmailandPassword(email, password);
    return answer;
  }

  Future<List<Category>> fetchmovie() async {
    var answer = await _authentication.fetchmovie();
    return answer;
  }

  Future<List<Category>> fetchbooks() async {
    var answer = await _authentication.fetchbook();
    return answer;
  }

  Future<List<Category>> fetchdizi() async {
    var answer = await _authentication.fetchdizi();
    return answer;
  }

  Future<bool> favfilmekle(Map<String, dynamic> movie) async {
    var answer = await _authentication.favfilmekle(movie);
    return answer;
  }

  Future<bool> favdizimekle(Map<String, dynamic> movie) async {
    var answer = await _authentication.favdizimekle(movie);
    return answer;
  }

  Future<bool> favkitapekle(Map<String, dynamic> movie) async {
    var answer = await _authentication.favkitapmekle(movie);
    return answer;
  }

  Future<List<FavoriModel>> getfav(String id) async {
    var answer = await _authentication.getfav(id);
    return answer;
  }

  Future<List<FavoriModel>> getdizi(String id) async {
    var answer = await _authentication.getfavdizi(id);
    return answer;
  }

  Future<List<FavoriModel>> getkitap(String id) async {
    var answer = await _authentication.getfavkitap(id);
    return answer;
  }

  Future<List<Yorum>> getconcomments(String id) async {
    var answer = await _authentication.getconcomments(id);
    return answer;
  }

  Future<bool> insertyorum(Yorum x) async {
    var answer = await _authentication.insertyorum(x);
    return answer;
  }

  Future<List<Yorum>> getuseryourm(String id) async {
    var answer = await _authentication.getuseryorum(id);
    return answer;
  }

  Future<bool> yorumsil(String userId, String objectId) async {
    var response = await _authentication.yorumsil(userId, objectId);
    return response;
  }

  Future<bool> yorumupdate(Yorum x) async {
    var response = await _authentication.yorumupdate(x);
    return response;
  }

  Future<bool> favoridelete(String userId, String objectId) async {
    var response = await _authentication.favoridelete(userId, objectId);
    return response;
  }

  Future<bool> inserttweet(Map<String, dynamic> x) async {
    var answer = await _authentication.inserttweet(x);
    return answer;
  }

  Future<List<TweetModel>> getusersTweet() async {
    var answer = await _authentication.getusersTweet();
    return answer;
  }

  Future<List<TweetModel>> getuserTweet(String id) async {
    var answer = await _authentication.getuserTweet(id);
    return answer;
  }

  Future<bool> tweetupdate(Map<String, dynamic> x) async {
    var response = await _authentication.tweetupdate(x);
    return response;
  }

  Future<bool> tweetsil(String id) async {
    var response = await _authentication.tweetsil(id);
    return response;
  }

  Future<bool> followuser(Map<String, dynamic> x) async {
    var response = await _authentication.followuser(x);
    return response;
  }

  Future<dynamic> followeduser(String id) async {
    var response = await _authentication.followeduser(id);
    return response;
  }

  Future<bool> deletefolloweduser(
      String id, String kullaniciId, String followuserId) async {
    var response =
        await _authentication.deletefolloweduser(id, kullaniciId, followuserId);
    return response;
  }

  Future<dynamic> followmeuser(String id) async {
    var response = await _authentication.followmeuser(id);
    return response;
  }
}
