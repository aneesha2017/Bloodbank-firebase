import 'package:bloodbank/Start.dart';
import 'package:bloodbank/update.dart';
import 'package:flutter/material.dart';
import 'home.dart'; // Make sure this is the correct import path to your home.dart file
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/home': (context) => MyHomePage(),
        '/update': (context) => UpdateUser(),
      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Start(),
    );
  }
}
