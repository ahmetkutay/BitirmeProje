import 'package:flutter/material.dart';
import 'package:newestapp3/userprovider.dart';
import 'package:newestapp3/widgets/commenwidget/Tweet_Box.dart';
import 'package:newestapp3/widgets/commenwidget/bottom_navigation.dart';
import 'package:provider/provider.dart';

class TweetPage extends StatefulWidget {
  @override
  _TweetPageState createState() => _TweetPageState();
}

class _TweetPageState extends State<TweetPage> {
  @override
  Widget build(BuildContext context) {
    UserProvider _userprovider = Provider.of<UserProvider>(context);
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 1 / 10,
            margin: EdgeInsets.only(top: 30),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: FlatButton(
                          onPressed: () {
                            // Navigator.pop(context);
                          },
                          child: Text(""),
                          //Icon(Icons.arrow_back),
                        ),
                      ),
                      Expanded(
                        flex: 10,
                        child: Container(
                          child: Center(
                            child: Text(
                              "TweetPage",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: SizedBox(),
                      )
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 4),
                    padding: EdgeInsets.symmetric(horizontal: 100),
                    child: Divider(
                      color: Colors.orange,
                      thickness: 3,
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 7.7 / 10,
            child: FutureBuilder(
                future: _userprovider.userstweet(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return Hero(
                          tag: "$index",
                          child:
                              TweetBox("$index", false, snapshot.data[index]),
                        );
                      },
                    );
                  } else {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Kullanıcıların Tweetleri Yükleniyor"),
                        CircularProgressIndicator(),
                      ],
                    );
                  }
                }),
          ),
          BottomNavigation(),
        ],
      ),
    );
  }
}
