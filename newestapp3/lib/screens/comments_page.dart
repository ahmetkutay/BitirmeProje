import 'package:flutter/material.dart';
import 'package:newestapp3/model/yorum.dart';
import 'package:newestapp3/screens/homepage.dart';
import 'package:newestapp3/userprovider.dart';
import 'package:newestapp3/widgets/commenwidget/bottom_navigation.dart';
import 'package:provider/provider.dart';

class ComentsPage extends StatefulWidget {
  bool otheruser = false;
  String userId;
  ComentsPage(this.otheruser, this.userId);
  @override
  _ComentsPageState createState() => _ComentsPageState();
}

class _ComentsPageState extends State<ComentsPage> {
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
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomePage(),
                              ),
                            );
                          },
                          child: Icon(Icons.arrow_back),
                        ),
                      ),
                      Expanded(
                        flex: 10,
                        child: Container(
                          child: Center(
                            child: Text(
                              "Yorumlar",
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
          SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 7.75 / 10,
              child: FutureBuilder(
                future: widget.otheruser == false
                    ? _userprovider.kullaniciyorumListe(_userprovider.user.id)
                    : _userprovider.kullaniciyorumListe(widget.userId),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<Yorum> value = snapshot.data;
                    return ListView.builder(
                      itemCount: value.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                            ),
                          ),
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.all(10),
                          height: MediaQuery.of(context).size.height * 2.6 / 10,
                          width: MediaQuery.of(context).size.width * 9 / 10,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text("${value[index].kullanici_name}"),
                                ],
                              ),
                              Container(
                                  padding: EdgeInsets.all(10),
                                  color: Colors.grey.withOpacity(0.4),
                                  height: MediaQuery.of(context).size.height *
                                      1.3 /
                                      10,
                                  width: MediaQuery.of(context).size.height *
                                      6 /
                                      10,
                                  child: Text(
                                    "${value[index].kullanici_yorum}",
                                    maxLines: 10,
                                  )),
                              widget.otheruser == false
                                  ? Row(
                                      children: [
                                        RaisedButton(
                                          color: Colors.red,
                                          child: Icon(
                                            Icons.delete,
                                            color: Colors.white,
                                          ),
                                          onPressed: () {
                                            showDialog(
                                              context: (context),
                                              builder: ((context) {
                                                return AlertDialog(
                                                  title: Text(
                                                      " Silmek İstediginize Emin Misiniz",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          color: Colors.red)),
                                                  actions: <Widget>[
                                                    Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              1 /
                                                              10,
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: [
                                                          RaisedButton(
                                                            color: Colors.red,
                                                            onPressed:
                                                                () async {
                                                              debugPrint(value[
                                                                      index]
                                                                  .objectId);
                                                              debugPrint(
                                                                  " object Id");
                                                              var deger = await _userprovider
                                                                  .yorumsil(
                                                                      _userprovider
                                                                          .user
                                                                          .id,
                                                                      value[index]
                                                                          .objectId);
                                                              Navigator.pop(
                                                                  context);
                                                              Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                  builder: (context) =>
                                                                      ComentsPage(
                                                                          false,
                                                                          _userprovider
                                                                              .user
                                                                              .id),
                                                                ),
                                                              );
                                                            },
                                                            child: Text(
                                                              "Evet",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black),
                                                            ),
                                                          ),
                                                          RaisedButton(
                                                            color: Colors.blue,
                                                            onPressed:
                                                                () async {
                                                              Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                  builder: (context) =>
                                                                      ComentsPage(
                                                                          false,
                                                                          _userprovider
                                                                              .user
                                                                              .id),
                                                                ),
                                                              );
                                                            },
                                                            child: Text(
                                                              "Hayır",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              }),
                                            );
                                          },
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        RaisedButton(
                                          color: Colors.orangeAccent,
                                          child: Icon(
                                            Icons.edit,
                                            color: Colors.white,
                                          ),
                                          onPressed: () {
                                            var _controller =
                                                TextEditingController(
                                                    text: value[index]
                                                        .kullanici_yorum);
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
                                                                        OutlineInputBorder()),
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
                                                                var deger =
                                                                    await _userprovider
                                                                        .yorumupdate(
                                                                  Yorum(
                                                                      objectId:
                                                                          value[index]
                                                                              .objectId,
                                                                      kullanici_Id:
                                                                          value[index]
                                                                              .kullanici_Id,
                                                                      kullanici_yorum: _controller
                                                                          .value
                                                                          .text,
                                                                      kullanici_name:
                                                                          value[index]
                                                                              .kullanici_name,
                                                                      urun_Id: value[
                                                                              index]
                                                                          .urun_Id),
                                                                );
                                                                Navigator.pop(
                                                                    context);
                                                                Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                    builder: (context) => ComentsPage(
                                                                        false,
                                                                        _userprovider
                                                                            .user
                                                                            .id),
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
                                          },
                                        ),
                                      ],
                                    )
                                  : SizedBox(),
                            ],
                          ),
                        );
                      },
                    );
                  } else {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.only(bottom: 30),
                            child: Text(
                              "Kullanıcı Yorumları Yükleniyor",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                          CircularProgressIndicator(),
                        ],
                      ),
                    );
                  }
                },
              ),
            ),
          ),
          BottomNavigation(),
        ],
      ),
    );
  }
}
