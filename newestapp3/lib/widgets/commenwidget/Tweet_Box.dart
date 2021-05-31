import 'package:newestapp3/model/tweet.dart';
import 'package:newestapp3/screens/full-Tweet.dart';
import 'package:flutter/material.dart';
import 'package:newestapp3/screens/homepage.dart';
import 'package:newestapp3/userprovider.dart';
import 'package:provider/provider.dart';

class TweetBox extends StatelessWidget {
  // final void onPress;
  // final bool isSmall;
  TweetModel tweetModel;
  final String tag;
  final bool decision;
  bool open = false;
  bool row = false;
  TweetBox.internal(this.tag, this.decision, this.row, this.tweetModel);
  // TweetBox({@required this.onPress, @required this.isSmall});
  TweetBox(
    this.tag,
    this.decision,
    this.tweetModel,
  );

  @override
  Widget build(BuildContext context) {
    UserProvider _userprovider = Provider.of<UserProvider>(context);
    return Container(
      height: decision == false
          ? MediaQuery.of(context).size.height * 3 / 10
          : MediaQuery.of(context).size.height * 5 / 10,
      child: Scaffold(
        body: GestureDetector(
          onTap: () {
            if (decision == false) {
              if (row == true) {
                if (tweetModel.kullanici_Id == _userprovider.user.id) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FullTweet.internal(
                        TweetBox.internal(tag, true, true, this.tweetModel),
                      ),
                    ),
                  );
                }
              }
            } else {
              open = true;
            }
          },
          child: Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.symmetric(
                vertical: decision == false ? 10 : 10, horizontal: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.orange, width: 1.5),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey[400],
                  blurRadius: 7,
                  spreadRadius: 1,
                  offset: Offset(5, 5),
                )
              ],
            ),
            height: decision == false
                ? MediaQuery.of(context).size.height * 3 / 10
                : MediaQuery.of(context).size.height * 3 / 10,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        child: GestureDetector(
                          onTap: () {
                            if (row == false) {
                              if (_userprovider.user.id ==
                                  tweetModel.kullanici_Id) {
                              } else {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => HomePage.internal(
                                        tweetModel.kullanici_Id,
                                        true,
                                        tweetModel.kullanici_name),
                                  ),
                                );
                              }
                            }
                          },
                          child: Text(
                            "${tweetModel.kullanici_name} ",
                            style: TextStyle(fontWeight: FontWeight.bold),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ),
                      //Text("12 s"),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 1 / 10,
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Text(
                      "${tweetModel.kullanici_tweet}",
                      style: TextStyle(color: Colors.orange, fontSize: 14),
                    ),
                  ),
                  Divider(
                    thickness: 1,
                    color: Colors.grey,
                  ),
                  Row(
                    children: [
                      decision == false
                          ? Container(
                              margin: EdgeInsets.only(left: 20),
                              child: Image.asset(
                                "lib/assets/heart.png",
                                width: 30,
                                color: Colors.black,
                              ),
                            )
                          : row == true
                              ? Container(
                                  width: MediaQuery.of(context).size.width *
                                      9 /
                                      10,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      RaisedButton(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          color: Colors.orange,
                                          child: Text(
                                            "Güncelle",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          onPressed: () {
                                            var _controller =
                                                TextEditingController(
                                                    text: tweetModel
                                                        .kullanici_tweet);
                                            showDialog(
                                              context: context,
                                              builder: (context) => AlertDialog(
                                                actions: [
                                                  Center(
                                                    child: Container(
                                                      padding:
                                                          EdgeInsets.all(10),
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              7 /
                                                              10,
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              4 /
                                                              10,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: <Widget>[
                                                          TextFormField(
                                                            decoration:
                                                                InputDecoration(
                                                              border:
                                                                  OutlineInputBorder(),
                                                            ),
                                                            controller:
                                                                _controller,
                                                            maxLines: 8,
                                                          ),
                                                          Container(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                4 /
                                                                10,
                                                            height: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                0.7 /
                                                                10,
                                                            child: RaisedButton(
                                                              color:
                                                                  Colors.green,
                                                              onPressed:
                                                                  () async {
                                                                _userprovider
                                                                    .tweetupdate({
                                                                  "_id": tweetModel
                                                                      .urun_Id,
                                                                  "tweet":
                                                                      _controller
                                                                          .text
                                                                });
                                                                // UserProvider

                                                                // var deger =
                                                                //     await _userprovider
                                                                //         .yorumupdate(
                                                                //   Yorum(
                                                                //       objectId: value[
                                                                //               index]
                                                                //           .objectId,
                                                                //       kullanici_Id:
                                                                //           value[index]
                                                                //               .kullanici_Id,
                                                                //       kullanici_yorum:
                                                                //           _controller
                                                                //               .value
                                                                //               .text,
                                                                //       kullanici_name:
                                                                //           value[index]
                                                                //               .kullanici_name,
                                                                //       urun_Id: value[
                                                                //               index]
                                                                //           .urun_Id),
                                                                //);

                                                                Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            HomePage(),
                                                                  ),
                                                                );
                                                              },
                                                              child: Text(
                                                                  "Kaydet"),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          }),
                                      RaisedButton(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        color: Colors.red,
                                        child: Text(
                                          "Sil",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        onPressed: () {
                                          showDialog(
                                              context: context,
                                              builder: (context) => AlertDialog(
                                                    content: Container(
                                                      height: 300,
                                                      width: 300,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: [
                                                          Center(
                                                            child: Text(
                                                                "Silmnek İstedginize Emin Misiniz"),
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceEvenly,
                                                            children: [
                                                              RaisedButton(
                                                                color:
                                                                    Colors.red,
                                                                child: Text(
                                                                  "Evet",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white),
                                                                ),
                                                                onPressed: () {
                                                                  _userprovider
                                                                      .tweetsil(
                                                                          tweetModel
                                                                              .urun_Id);
                                                                  Navigator
                                                                      .push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                      builder:
                                                                          (context) =>
                                                                              HomePage(),
                                                                    ),
                                                                  );
                                                                },
                                                              ),
                                                              RaisedButton(
                                                                color: Colors
                                                                    .green,
                                                                child: Text(
                                                                  "Hayır",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white),
                                                                ),
                                                                onPressed: () {
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ));
                                        },
                                      ),
                                    ],
                                  ),
                                )
                              : SizedBox(),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
