import 'package:flutter/material.dart';
import 'package:newestapp3/screens/landingpage.dart';
import 'package:newestapp3/userprovider.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ChangeNotifierProvider(
    create: (context) => UserProvider(),
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LandingPage(),
    ),
  ));
}
