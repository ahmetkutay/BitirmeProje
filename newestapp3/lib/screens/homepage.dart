import 'package:flutter/material.dart';
import 'package:newestapp3/model/yorum.dart';
import 'package:newestapp3/screens/comments_page.dart';
import 'package:newestapp3/screens/favoripage.dart';
import 'package:newestapp3/screens/followeduser_page.dart';
import 'package:newestapp3/screens/users.dart';
import 'package:newestapp3/widgets/commenwidget/Tweet_Box.dart';
import 'package:newestapp3/widgets/commenwidget/bottom_navigation.dart';
import 'package:provider/provider.dart';

import '../userprovider.dart';

class HomePage extends StatefulWidget {
  String userid;
  String userName;
  bool takipediyor = false;
  bool otheruser = false;
  int uzunluk = 0;
  HomePage();
  HomePage.internal(this.userid, this.otheruser, this.userName);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    UserProvider _userprovider = Provider.of<UserProvider>(context);

    return Scaffold(
      backgroundColor: Colors.orangeAccent,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * 2.3 / 10,
              color: Colors.white,
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.04 / 10),
                    child: Image.asset("lib/assets/box2.jpg"),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  margin: EdgeInsets.only(right: 3, left: 3),
                  child: RaisedButton(
                    color: Colors.white,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ComentsPage(
                              widget.otheruser == false ? false : true,
                              widget.otheruser == false
                                  ? _userprovider.user.id
                                  : widget.userid),
                        ),
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 15),
                      width: MediaQuery.of(context).size.width * 4.7 / 10,
                      child: Text("Yorumlar"),
                    ),
                  ),
                ),
                RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  color: Colors.white,
                  child: Container(
                    margin: EdgeInsets.all(12),
                    child: Icon(Icons.message_sharp),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UsersPage(),
                      ),
                    );
                  },
                ),
                Container(
                  margin: EdgeInsets.all(
                      MediaQuery.of(context).size.height * 0.05 / 10),
                  height: MediaQuery.of(context).size.height * 0.7 / 10,
                  width: MediaQuery.of(context).size.width * 2 / 10,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      PopupMenuButton(
                        icon: Image.asset(
                          "lib/assets/bookmark.png",
                          width: 25,
                        ),
                        itemBuilder: (context) => [
                          PopupMenuItem(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5),
                                ),
                              ),
                              child: FlatButton(
                                onPressed: () async {
                                  var x = widget.otheruser == false
                                      ? await _userprovider
                                          .favoridiziler(_userprovider.user.id)
                                      : await _userprovider
                                          .favoridiziler(widget.userid);

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          FavoriPage(
                                              veriler: x,
                                              title: "FAVORİ DİZİLER",
                                              otheruser:
                                                  widget.otheruser == false
                                                      ? false
                                                      : true),
                                    ),
                                  );
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Icon(
                                      Icons.tv,
                                      color: Colors.green,
                                    ),
                                    Text("Diziler"),
                                  ],
                                ),
                              ),
                              height:
                                  MediaQuery.of(context).size.height * 0.5 / 10,
                              width:
                                  MediaQuery.of(context).size.width * 3.3 / 10,
                            ),
                          ),
                          PopupMenuItem(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5),
                                ),
                              ),
                              child: FlatButton(
                                onPressed: () async {
                                  var x = widget.otheruser == false
                                      ? await _userprovider
                                          .favoriler(_userprovider.user.id)
                                      : await _userprovider
                                          .favoriler(widget.userid);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          FavoriPage(
                                              veriler: x,
                                              title: "FAVORİ FİLMLER",
                                              otheruser:
                                                  widget.otheruser == false
                                                      ? false
                                                      : true),
                                    ),
                                  );
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Icon(
                                      Icons.movie,
                                      color: Colors.blue,
                                    ),
                                    Text("Filmler")
                                  ],
                                ),
                              ),
                              height:
                                  MediaQuery.of(context).size.height * 0.5 / 10,
                              width:
                                  MediaQuery.of(context).size.width * 3.3 / 10,
                            ),
                          ),
                          PopupMenuItem(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5),
                                ),
                              ),
                              child: FlatButton(
                                onPressed: () async {
                                  var x = widget.otheruser == false
                                      ? await _userprovider
                                          .favorikitaplar(_userprovider.user.id)
                                      : await _userprovider
                                          .favorikitaplar(widget.userid);

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          FavoriPage(
                                              veriler: x,
                                              title: "FAVORİ KİTAPLAR",
                                              otheruser:
                                                  widget.otheruser == false
                                                      ? false
                                                      : true),
                                    ),
                                  );
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Icon(
                                      Icons.book,
                                      color: Colors.red,
                                    ),
                                    Text("Kitaplar"),
                                  ],
                                ),
                              ),
                              height:
                                  MediaQuery.of(context).size.height * 0.5 / 10,
                              width:
                                  MediaQuery.of(context).size.width * 3.3 / 10,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ],
            ),
            Divider(
              color: Colors.white,
              thickness: 10,
              endIndent: 5,
              indent: 5,
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
              ),
              margin: EdgeInsets.only(right: 5, left: 5, bottom: 3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    widget.otheruser == true
                        ? "Kullanıcı Adı: ${widget.userName}"
                        : "",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FollowedUserPage(
                              widget.otheruser == false
                                  ? _userprovider.user.id
                                  : widget.userid,
                              widget.otheruser == false ? false : true,
                              true),
                        ),
                      );
                    },
                    child: Column(
                      children: [
                        Text(
                          "Takip Edilenler",
                          style: TextStyle(fontSize: 12),
                        ),
                        FutureBuilder(
                            future: widget.otheruser == false
                                ? _userprovider
                                    .followedUser(_userprovider.user.id)
                                : _userprovider.followedUser(widget.userid),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return Text(
                                  "${snapshot.data.length}",
                                  style: TextStyle(fontSize: 10),
                                );
                              } else {
                                return Text("...");
                              }
                            })
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FollowedUserPage(
                              widget.otheruser == false
                                  ? _userprovider.user.id
                                  : widget.userid,
                              widget.otheruser == false ? false : true,
                              false),
                        ),
                      );
                    },
                    child: Column(
                      children: [
                        Text(
                          "Takipçiler",
                          style: TextStyle(fontSize: 12),
                        ),
                        FutureBuilder(
                          future: widget.otheruser == false
                              ? _userprovider
                                  .followmeUser(_userprovider.user.id)
                              : _userprovider.followmeUser(widget.userid),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              if (widget.uzunluk == 0) {
                                widget.uzunluk = snapshot.data.length;
                              }
                              return Text(
                                widget.uzunluk == 0
                                    ? "${snapshot.data.length}"
                                    : "${widget.uzunluk}",
                                style: TextStyle(fontSize: 10),
                              );
                            } else {
                              return Text("...");
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  widget.otheruser == true
                      ? FutureBuilder(
                          future:
                              _userprovider.followedUser(_userprovider.user.id),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              int count = 0;
                              snapshot.data.map(
                                (value) {
                                  if (value["followed_user_Id"] ==
                                      widget.userid) {
                                    widget.takipediyor = true;
                                  }
                                },
                              );

                              return GestureDetector(
                                onTap: () async {
                                  setState(() {
                                    widget.uzunluk = widget.uzunluk + 1;
                                  });

                                  var response =
                                      await _userprovider.followuser({
                                    "kullanici_Id": _userprovider.user.id,
                                    "followed_user_Id": widget.userid,
                                    "kullanici_Adi": widget.userName,
                                  });

                                  if (response == true) {
                                    // showDialog(
                                    //   context: context,
                                    //   builder: (context) => AlertDialog(
                                    //     content: Container(
                                    //       width: 200,
                                    //       height: 200,
                                    //       child: Column(
                                    //         mainAxisAlignment:
                                    //             MainAxisAlignment.center,
                                    //         children: [
                                    //           Center(
                                    //             child: Text(
                                    //                 "Kullanıcı Takip Edildi"),
                                    //           ),
                                    //           RaisedButton(
                                    //             color: Colors.blue,
                                    //             child: Text("Tamam"),
                                    //             onPressed: () {
                                    //               Navigator.pop(context);
                                    //             },
                                    //           ),
                                    //         ],
                                    //       ),
                                    //     ),
                                    //   ),
                                    // );
                                  }
                                },
                                child: Container(
                                  margin: EdgeInsets.only(bottom: 5, top: 5),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  child: Text(
                                    widget.takipediyor == false
                                        ? "FOLLOW"
                                        : "BIRAK",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.orangeAccent,
                                  ),
                                ),
                              );
                            } else {
                              return SizedBox();
                            }
                          },
                        )
                      : SizedBox(
                          height: 34,
                        )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 2, bottom: 2),
              height: MediaQuery.of(context).size.height * 0.35 / 10,
              width: MediaQuery.of(context).size.width * 9.8 / 10,
              child: FlatButton(
                child: Container(
                  // margin: EdgeInsets.only(bottom: 30),
                  child: Text(
                    "TWEETLER",
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange),
                  ),
                ),
                onPressed: () {},
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                  color: Colors.white,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 4.9 / 10,
                  child: FutureBuilder(
                    future: widget.otheruser == true
                        ? _userprovider.getusertweet(widget.userid)
                        : _userprovider.getusertweet(_userprovider.user.id),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            return Hero(
                              tag: "$index",
                              child: TweetBox.internal(
                                  "$index", false, true, snapshot.data[index]),
                            );
                          },
                        );
                      } else {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Twettler Yükleniyor"),
                            CircularProgressIndicator(),
                          ],
                        );
                      }
                    },
                  )),
            ),
            BottomNavigation(),
          ],
        ),
      ),
    );
  }
}

// FutureBuilder(
//           //future: ,
//           builder: (BuildContext context, AsyncSnapshot snapshot) {
//             if (!snapshot.hasData) {
//               return Center(child: CircularProgressIndicator());
//             } else {
//               return ListView.builder(
//                 itemCount: snapshot.data.length,
//                 itemBuilder: (BuildContext context, int index) {
//                   return Container(
//                     padding: EdgeInsets.all(10),
//                     margin: EdgeInsets.all(10),
//                     height: MediaQuery.of(context).size.height * 2.50 / 10,
//                     width: MediaQuery.of(context).size.width * 9 / 10,
//                     child: Column(
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             Text("name"),
//                             Text("tarih"),
//                           ],
//                         ),
//                         Container(
//                           child: Image.network(""),
//                         ),
//                         SizedBox(
//                           height: 8,
//                         ),
//                         Text("")
//                       ],
//                     ),
//                   );
//                 },
//               );
//             }
//           },
//         ),

//  FutureBuilder(
//                   future:
//                       _userprovider.kullaniciyorumListe(_userprovider.user.id),
//                   builder: (context, snapshot) {
//                     if (snapshot.hasData) {
//                       List<Yorum> value = snapshot.data;
//                       return ListView.builder(
//                         itemCount: value.length,
//                         itemBuilder: (BuildContext context, int index) {
//                           return Container(
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.only(
//                                 topRight: Radius.circular(10),
//                                 bottomRight: Radius.circular(10),
//                                 bottomLeft: Radius.circular(10),
//                               ),
//                             ),
//                             padding: EdgeInsets.all(10),
//                             margin: EdgeInsets.all(10),
//                             height:
//                                 MediaQuery.of(context).size.height * 2.6 / 10,
//                             width: MediaQuery.of(context).size.width * 9 / 10,
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                               children: [
//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   children: [
//                                     Text("${value[index].kullanici_name}"),
//                                   ],
//                                 ),
//                                 Container(
//                                     padding: EdgeInsets.all(10),
//                                     color: Colors.grey.withOpacity(0.4),
//                                     height: MediaQuery.of(context).size.height *
//                                         1.3 /
//                                         10,
//                                     width: MediaQuery.of(context).size.height *
//                                         6 /
//                                         10,
//                                     child: Text(
//                                       "${value[index].kullanici_yorum}",
//                                       maxLines: 10,
//                                     )),
//                                 Row(
//                                   children: [
//                                     RaisedButton(
//                                       color: Colors.red,
//                                       child: Icon(
//                                         Icons.delete,
//                                         color: Colors.white,
//                                       ),
//                                       onPressed: () {
//                                         showDialog(
//                                           context: (context),
//                                           builder: ((context) {
//                                             return AlertDialog(
//                                               title: Text(
//                                                   " Silmek İstediginize Emin Misiniz",
//                                                   textAlign: TextAlign.center,
//                                                   style: TextStyle(
//                                                       color: Colors.red)),
//                                               actions: <Widget>[
//                                                 Container(
//                                                   width: MediaQuery.of(context)
//                                                       .size
//                                                       .width,
//                                                   height: MediaQuery.of(context)
//                                                           .size
//                                                           .height *
//                                                       1 /
//                                                       10,
//                                                   child: Row(
//                                                     mainAxisAlignment:
//                                                         MainAxisAlignment
//                                                             .spaceEvenly,
//                                                     children: [
//                                                       RaisedButton(
//                                                         color: Colors.red,
//                                                         onPressed: () async {
//                                                           debugPrint(
//                                                               value[index]
//                                                                   .objectId);
//                                                           debugPrint(
//                                                               " object Id");
//                                                           var deger = await _userprovider
//                                                               .yorumsil(
//                                                                   _userprovider
//                                                                       .user.id,
//                                                                   value[index]
//                                                                       .objectId);
//                                                           Navigator.pop(
//                                                               context);
//                                                           Navigator.push(
//                                                             context,
//                                                             MaterialPageRoute(
//                                                               builder:
//                                                                   (context) =>
//                                                                       HomePage(),
//                                                             ),
//                                                           );
//                                                         },
//                                                         child: Text(
//                                                           "Evet",
//                                                           style: TextStyle(
//                                                               color:
//                                                                   Colors.black),
//                                                         ),
//                                                       ),
//                                                       RaisedButton(
//                                                         color: Colors.blue,
//                                                         onPressed: () async {
//                                                           Navigator.push(
//                                                             context,
//                                                             MaterialPageRoute(
//                                                               builder:
//                                                                   (context) =>
//                                                                       HomePage(),
//                                                             ),
//                                                           );
//                                                         },
//                                                         child: Text(
//                                                           "Hayır",
//                                                           style: TextStyle(
//                                                               color:
//                                                                   Colors.white),
//                                                         ),
//                                                       ),
//                                                     ],
//                                                   ),
//                                                 ),
//                                               ],
//                                             );
//                                           }),
//                                         );
//                                       },
//                                     ),
//                                     SizedBox(
//                                       width: 5,
//                                     ),
//                                     RaisedButton(
//                                       color: Colors.orangeAccent,
//                                       child: Icon(
//                                         Icons.edit,
//                                         color: Colors.white,
//                                       ),
//                                       onPressed: () {
//                                         var _controller = TextEditingController(
//                                             text: value[index].kullanici_yorum);
//                                         showDialog(
//                                           context: context,
//                                           builder: (context) => AlertDialog(
//                                             actions: [
//                                               Center(
//                                                 child: Container(
//                                                   padding: EdgeInsets.all(10),
//                                                   width: MediaQuery.of(context)
//                                                           .size
//                                                           .width *
//                                                       7 /
//                                                       10,
//                                                   height: MediaQuery.of(context)
//                                                           .size
//                                                           .height *
//                                                       4 /
//                                                       10,
//                                                   child: Column(
//                                                     mainAxisAlignment:
//                                                         MainAxisAlignment
//                                                             .spaceEvenly,
//                                                     children: <Widget>[
//                                                       TextFormField(
//                                                         decoration: InputDecoration(
//                                                             border:
//                                                                 OutlineInputBorder()),
//                                                         controller: _controller,
//                                                         maxLines: 8,
//                                                       ),
//                                                       Container(
//                                                         width: MediaQuery.of(
//                                                                     context)
//                                                                 .size
//                                                                 .width *
//                                                             4 /
//                                                             10,
//                                                         height: MediaQuery.of(
//                                                                     context)
//                                                                 .size
//                                                                 .height *
//                                                             0.7 /
//                                                             10,
//                                                         child: RaisedButton(
//                                                           color: Colors.green,
//                                                           onPressed: () async {
//                                                             var deger =
//                                                                 await _userprovider
//                                                                     .yorumupdate(
//                                                               Yorum(
//                                                                   objectId: value[
//                                                                           index]
//                                                                       .objectId,
//                                                                   kullanici_Id:
//                                                                       value[index]
//                                                                           .kullanici_Id,
//                                                                   kullanici_yorum:
//                                                                       _controller
//                                                                           .value
//                                                                           .text,
//                                                                   kullanici_name:
//                                                                       value[index]
//                                                                           .kullanici_name,
//                                                                   urun_Id: value[
//                                                                           index]
//                                                                       .urun_Id),
//                                                             );
//                                                             Navigator.pop(
//                                                                 context);
//                                                             Navigator.push(
//                                                               context,
//                                                               MaterialPageRoute(
//                                                                 builder:
//                                                                     (context) =>
//                                                                         HomePage(),
//                                                               ),
//                                                             );
//                                                           },
//                                                           child: Text("Kaydet"),
//                                                         ),
//                                                       ),
//                                                     ],
//                                                   ),
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                         );
//                                       },
//                                     ),
//                                   ],
//                                 )
//                               ],
//                             ),
//                           );
//                         },
//                       );
//                     } else {
//                       return Center(
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Container(
//                               margin: EdgeInsets.only(bottom: 30),
//                               child: Text(
//                                 "Kullanıcı Yorumları Yükleniyor",
//                                 style: TextStyle(
//                                     color: Colors.white, fontSize: 20),
//                               ),
//                             ),
//                             CircularProgressIndicator(),
//                           ],
//                         ),
//                       );
//                     }
//                   },
//                 ),
