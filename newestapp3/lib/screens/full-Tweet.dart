import 'package:flutter/material.dart';
import 'package:newestapp3/userprovider.dart';
import 'package:newestapp3/widgets/commenwidget/Tweet_Box.dart';
import 'package:newestapp3/widgets/commenwidget/bottom_navigation.dart';
import 'package:provider/provider.dart';

class FullTweet extends StatefulWidget {
  final TweetBox tweetBox;

  FullTweet.internal(
    this.tweetBox,
  );
  @override
  _FullTweetState createState() => _FullTweetState();
}

class _FullTweetState extends State<FullTweet>
    with SingleTickerProviderStateMixin {
  AnimationController expandController;
  Animation<double> animation;

  @override
  void initState() {
    super.initState();
    prepareAnimations();
    _runExpandCheck();
  }

  void prepareAnimations() {
    expandController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    animation = CurvedAnimation(
      parent: expandController,
      curve: Curves.fastOutSlowIn,
    );
  }

  void _runExpandCheck() {
    if (widget.tweetBox.decision) {
      expandController.forward();
    } else {
      expandController.reverse();
    }
  }

  @override
  void didUpdateWidget(FullTweet oldWidget) {
    super.didUpdateWidget(oldWidget);
    _runExpandCheck();
  }

  @override
  void dispose() {
    expandController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // UserProvider _userprovider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        title: Container(
          margin: EdgeInsets.only(right: 50),
          child: Center(
            child: Text("TweetDetay"),
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SingleChildScrollView(
            child: SizeTransition(
              axisAlignment: 1.0,
              sizeFactor: animation,
              child: Hero(tag: widget.tweetBox.tag, child: widget.tweetBox),
            ),
          ),
          BottomNavigation(),
        ],
      ),
    );
  }
}
