import 'package:firebase_auth/firebase_auth.dart';
import 'package:newestapp3/model/user.dart' as usermodel;
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:newestapp3/screens/chat_room.dart';

class UsersPage extends StatefulWidget {
  @override
  _UsersPageState createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  usermodel.User user = usermodel.User.internal();

  final FirebaseAuth _firebaseauth = FirebaseAuth.instance;
  final _cloudfirestore = FirebaseFirestore.instance;

  Future<usermodel.User> currentuser() async {
    User user = _firebaseauth.currentUser;
    return readUser(_userfromfirebase(user).userId);
  }

  usermodel.User _userfromfirebase(User user) {
    if (user == null) {
      return null;
    } else {
      print(user.uid);
      print(user.email);
      return usermodel.User(userId: user.uid, email: user.email);
    }
  }

  Future<usermodel.User> readUser(String id) async {
    DocumentSnapshot doc =
        await _cloudfirestore.collection("users").doc(id).get();

    Map<String, dynamic> user = doc.data();
    return usermodel.User.fromMap(user);
  }

  List<usermodel.User> _listusers = [];

  usermodel.User _lastuserId;

  Future<List<usermodel.User>> getsomeuser(usermodel.User lastuser) async {
    if (lastuser == null) {
      QuerySnapshot querySnapShot = await _cloudfirestore
          .collection("users")
          .orderBy("userId")
          .limit(10)
          .get();

      List<usermodel.User> users = querySnapShot.docs
          .map((e) => usermodel.User.fromMap(e.data()))
          .toList();
      _listusers = users;

      _lastuserId = users.last;
      debugPrint("ahahhahahahahahh");
      debugPrint(_lastuserId.userName);

      return users;
    } else {
      QuerySnapshot tenusers = await _cloudfirestore
          .collection("users")
          .orderBy("userId")
          .limit(10)
          .startAfter([_lastuserId.userId]).get();

      if (tenusers == null) {
        return _listusers;
      } else {
        List<usermodel.User> users =
            tenusers.docs.map((e) => usermodel.User.fromMap(e.data())).toList();
        for (usermodel.User user in users) {
          _listusers.add(user);
        }
        return _listusers;
      }
    }
  }

  @override
  void initState() {
    currentuser().then((value) => user = value);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        actions: [],
        title: Center(
          child: Container(
            margin: EdgeInsets.only(right: 50),
            child: Text("KULLANICILAR"),
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () {
          setState(() {});
          return Future.delayed(Duration(seconds: 1));
        },
        child: FutureBuilder(
          future: getsomeuser(_lastuserId),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<usermodel.User> users = snapshot.data;

              return ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    if (users[index].userId != user.userId) {
                      debugPrint(users[index].userId);
                      return GestureDetector(
                        onTap: () => Navigator.of(
                          context,
                          rootNavigator: true,
                        ).push(
                          MaterialPageRoute(
                            builder: (context) => Chat(
                              currentUser: user,
                              otherUser: users[index],
                            ),
                          ),
                        ),
                        child: users[index].userId != user.userId
                            ? ListTile(
                                title: Text(users[index].userName),
                                subtitle: Text(users[index].email),
                              )
                            : Text("hello"),
                      );
                    } else {
                      return Container();
                    }
                  });
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
