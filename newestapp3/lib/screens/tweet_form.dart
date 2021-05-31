import 'dart:async';

import 'package:flutter/material.dart';
import 'package:newestapp3/userprovider.dart';
import 'package:newestapp3/widgets/commenwidget/bottom_navigation.dart';
import 'package:provider/provider.dart';

class TweetForm extends StatefulWidget {
  @override
  _TweetFormState createState() => _TweetFormState();
}

class _TweetFormState extends State<TweetForm> {
  TextEditingController contoller1 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    UserProvider _userprovider = Provider.of<UserProvider>(context);
    return Scaffold(
      body: Form(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                Navigator.pop(context);
                              },
                              child: Icon(Icons.arrow_back),
                            ),
                          ),
                          Expanded(
                            flex: 10,
                            child: Container(
                              child: Center(
                                child: Text(
                                  "Tweet Ekle",
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
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.orangeAccent, width: 2),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(1, 1),
                        spreadRadius: 2,
                        blurRadius: 4,
                      )
                    ]),
                child: TextFormField(
                  controller: contoller1,
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                    counterStyle: TextStyle(color: Colors.orange),
                    suffixStyle: TextStyle(color: Colors.orange),
                    alignLabelWithHint: true,
                    hintText: "Gönderi oluştur",
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                  ),
                  maxLines: 5,
                ),
              ),
              RaisedButton(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(color: Colors.orange, width: 2),
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width * 8 / 10,
                  child: Center(
                    child: Text("Gönder"),
                  ),
                ),
                onPressed: () {
                  _userprovider.tweetekle({
                    "_id": _userprovider.user.id,
                    "kullaniciAdi": _userprovider.user.name,
                    "tweet": contoller1.text
                  });
                  contoller1.text = "";
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            content: Container(
                              width: 300,
                              height: 300,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text("başarıyla Yüklendi Tweet"),
                                  RaisedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text("Tamam"),
                                  )
                                ],
                              ),
                            ),
                          ));
                  //showDialog(context: context,builder:(context)=>AlertDialog());
                },
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 4.2 / 10,
              ),
              BottomNavigation(),
            ],
          ),
        ),
      ),
    );
  }
}
