import 'package:flutter/material.dart';
import 'package:cs6234/home/Toolbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class News extends StatefulWidget {
  final String widgetNews;
  final String widgetNewsId;
  final String widgetAlertEmail;
  const News({Key? key, this.widgetNews = "", this.widgetNewsId = "", this.widgetAlertEmail = ""}) : super(key: key);

  @override
  _NewsState createState() => _NewsState();
}

class _NewsState extends State<News> {
  final authInstance = FirebaseAuth.instance;
  final firestoreInstance = FirebaseFirestore.instance;
  String news = "";
  String newsId = "";
  String alertEmail = "";

  String? username = "";

  @override
  void initState() {
    super.initState();
    news = widget.widgetNews;
    newsId = widget.widgetNewsId;
    alertEmail = widget.widgetAlertEmail;
    final currentUser = authInstance.currentUser;
    if (currentUser != null) {
      username = currentUser.email;
    } else {
      print("not login");
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const ToolBar(title: "News"),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
              child: TextField( // or using TextFormField and change initialValue
                controller: TextEditingController()..text = news,
                decoration: const InputDecoration(hintText: "Say something..."),
                keyboardType: TextInputType.name,
                onChanged: (value){
                  news = value;
                },
              )
            )
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
              child: TextField( // or using TextFormField and change initialValue
                controller: TextEditingController()..text = alertEmail,
                decoration: const InputDecoration(hintText: "Put the email you want to alert"),
                keyboardType: TextInputType.name,
                onChanged: (value){
                  alertEmail = value;
                },
              )
            )
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(50, 5, 50, 5),
            child: MaterialButton(
              minWidth: double.infinity,
              color: Colors.lightBlue,
              child: const Text('Submit News', style: TextStyle(color: Colors.white)),
              onPressed: () async {
                if(newsId != "") {
                  firestoreInstance.collection("News").doc(newsId).update({
                    "news" : news,
                    "alertEmail" : alertEmail,
                    "username" : username,
                    "submitTime" : Timestamp.now()
                  }).then((value) => Navigator.pop(context));
                } else {
                  firestoreInstance.collection("News").add({
                    "news" : news,
                    "alertEmail" : alertEmail,
                    "username" : username,
                    "submitTime" : Timestamp.now()
                  }).then((value){
                    print(value.id);
                    Navigator.pop(context);
                  });
                }
              }
            ),
          )
        ]
      )
    );
  }
}