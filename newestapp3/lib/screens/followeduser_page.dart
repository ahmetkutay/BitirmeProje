import 'package:flutter/material.dart';
import 'package:newestapp3/userprovider.dart';
import 'package:newestapp3/widgets/commenwidget/bottom_navigation.dart';
import 'package:provider/provider.dart';

class FollowedUserPage extends StatefulWidget {
  String id;
  bool followed = true;
  bool otheruser = false;
  FollowedUserPage(this.id, this.otheruser, this.followed);
  @override
  _FollowedUserPageState createState() => _FollowedUserPageState();
}

class _FollowedUserPageState extends State<FollowedUserPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    UserProvider _userprovider = Provider.of<UserProvider>(context);
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 9.2 / 10,
            child: SingleChildScrollView(
              child: FutureBuilder(
                future: widget.otheruser == false
                    ? widget.followed == true
                        ? _userprovider.followedUser(_userprovider.user.id)
                        : _userprovider.followmeUser(_userprovider.user.id)
                    : widget.followed == true
                        ? _userprovider.followedUser(widget.id)
                        : _userprovider.followmeUser(widget.id),
                //widget.followed == true
                //     ? _userprovider.followedUser(_userprovider.user.id)
                //     : _userprovider.followmeUser(_userprovider.user.id),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Container(
                      height: MediaQuery.of(context).size.height * 9.2 / 10,
                      child: ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.only(
                                bottom: 10, left: 5, right: 5, top: 5),
                            height: MediaQuery.of(context).size.height * 1 / 10,
                            decoration: BoxDecoration(
                              color: Colors.orange,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(left: 50),
                                      child: Text(
                                          "${snapshot.data[index]["kullanici_Adi"]}"),
                                    ),
                                    Container(
                                        margin:
                                            EdgeInsets.only(right: 50, top: 10),
                                        child: widget.followed == true
                                            ? widget.otheruser == false
                                                ? RaisedButton(
                                                    color: Colors.red,
                                                    child: Text(
                                                      "Çıkar",
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                    ),
                                                    onPressed: () async {
                                                      await _userprovider
                                                          .deletefollow(
                                                              snapshot.data[
                                                                  index]["_id"],
                                                              _userprovider
                                                                  .user.id,
                                                              snapshot.data[
                                                                      index][
                                                                  "followed_user_Id"]);
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              FollowedUserPage(
                                                                  _userprovider
                                                                      .user.id,
                                                                  false,
                                                                  true),
                                                        ),
                                                      );
                                                    },
                                                  )
                                                : SizedBox()
                                            : SizedBox()),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
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
