import 'package:flutter/material.dart';
import 'dart:async';
//import 'package:progress_dialog/progress_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cs6234/model/AfterLayout.dart';
import 'package:cs6234/auth/SignIn.dart';
import 'package:cs6234/home/HomePage.dart';

//ProgressDialog pr;

class StartImagePage extends StatefulWidget {
  const StartImagePage({Key? key}) : super(key: key);

  @override
  _StartImagePageState createState() => _StartImagePageState();
}

class _StartImagePageState extends State<StartImagePage> with AfterLayoutMixin<StartImagePage> {
  final authInstance = FirebaseAuth.instance;
  late Timer _timer;

  @override
  void afterFirstLayout(BuildContext context) {
    // Calling the same function "after layout" to resolve the issue.
    //pr.show();
    _timer = Timer(const Duration(seconds: 2), () {
      //setState(() {
      getUserInfo();
      //});
    });
  }

  @override
  void dispose() {
    //pr = null;
    _timer.cancel();
    //_timer = null;
    super.dispose();
  }

  getUserInfo() async {
    if (authInstance.currentUser != null) {
      print(authInstance.currentUser);
      print("here");
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const HomePage()));
    } else {
      print(authInstance.currentUser);
      print("not login");
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const SignIn()));
    }
  }

  @override
  Widget build(BuildContext context) {
    //pr = new ProgressDialog(context,type: ProgressDialogType.Normal);
    //pr.style(message: 'Loading...');

    return Scaffold(
        body: Image.asset('assets/images/image7.png',
          fit: BoxFit.cover,
          height: double.infinity,
          width: double.infinity,
          alignment: Alignment.center,
        )
    );
  }
}