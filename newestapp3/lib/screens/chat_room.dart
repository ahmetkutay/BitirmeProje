import 'package:newestapp3/model/message.dart';
import 'package:newestapp3/model/user.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Chat extends StatefulWidget {
  User currentUser;
  User otherUser;

  Chat({@required this.currentUser, @required this.otherUser});
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final TextEditingController textcontroller = TextEditingController();
  final _cloudfirestore = FirebaseFirestore.instance;

  Stream getAllMessage(String userId, String otheruserId) {
    Stream<QuerySnapshot> querySnapShot = _cloudfirestore
        .collection("konusmalar")
        .doc(userId + "--" + otheruserId)
        .collection("mesajlar")
        .orderBy("date")
        .snapshots();

    return querySnapShot;
  }

  Future<bool> setMessage(Message mesaj) async {
    String mesajId = _cloudfirestore.collection("konusmalar").doc().id;
    Map<String, dynamic> mesajmap = mesaj.messagetoMap();
    mesajmap["date"] = FieldValue.serverTimestamp();
    await _cloudfirestore
        .collection("konusmalar")
        .doc(mesajmap["verici"] + "--" + mesajmap["alici"])
        .collection("mesajlar")
        .doc(mesajId)
        .set(mesajmap);
    mesajmap["bendenMi"] = false;

    await _cloudfirestore
        .collection("konusmalar")
        .doc(
          mesajmap["alici"] + "--" + mesajmap["verici"],
        )
        .collection("mesajlar")
        .doc(mesajId)
        .set(mesajmap);

    return true;
  }

  @override
  Widget build(BuildContext context) {
    //UserModel _userModel = Provider.of<UserModel>(context);
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          title: Text(
            "Konusma",
            style: TextStyle(color: Colors.orangeAccent),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                stream: getAllMessage(
                    widget.currentUser.userId, widget.otherUser.userId),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (context, index) {
                        return Row(
                          mainAxisAlignment:
                              snapshot.data.docs[index]["bendenMi"] == false
                                  ? MainAxisAlignment.start
                                  : MainAxisAlignment.end,
                          children: [
                            Flexible(
                              child: Container(
                                padding: EdgeInsets.all(10),
                                margin: EdgeInsets.only(
                                    bottom: 20, left: 10, top: 10, right: 10),
                                decoration: BoxDecoration(
                                  color: snapshot.data.docs[index]
                                              ["bendenMi"] ==
                                          false
                                      ? Colors.red
                                      : Colors.green,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  snapshot.data.docs[index]["message"],
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            // Text(
                            //   (snapshot.data.docs[index]["date"] as Timestamp)
                            //           .toDate()
                            //           .hour
                            //           .toString() +
                            //       "." +
                            //       (snapshot.data.docs[index]["date"]
                            //               as Timestamp)
                            //           .toDate()
                            //           .minute
                            //           .toString(),
                            // ),
                          ],
                        );
                      },
                    );
                  } else {
                    return Container(child: Text("Dogru"));
                  }
                },
              ),
            ),
            Container(
              margin: EdgeInsets.only(),
              decoration: BoxDecoration(
                // color: Color.fromRGBO(37, 211, 102, 1),
                color: Colors.orangeAccent,
              ),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: textcontroller,
                    ),
                  ),
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(30),
                      ),
                    ),
                    color: Colors.white,
                    child: Text(
                      "PUSH",
                      style: TextStyle(color: Colors.orangeAccent),
                    ),
                    onPressed: () async {
                      if (textcontroller.text.trim().length > 0) {
                        bool gittmi = await setMessage(
                          Message(
                              message: textcontroller.text,
                              verici: widget.currentUser.userId,
                              alici: widget.otherUser.userId,
                              bendenMi: true),
                        );
                        if (gittmi) {
                          textcontroller.clear();
                        }
                      }
                    },
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
