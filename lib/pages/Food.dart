import 'package:flutter/material.dart';
import 'package:cs6234/home/Toolbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Food extends StatefulWidget {
  final String widgetFood;
  final String widgetFoodId;
  const Food({Key? key, this.widgetFood = "", this.widgetFoodId = ""}) : super(key: key);

  @override
  _FoodState createState() => _FoodState();
}

class _FoodState extends State<Food> {
  final authInstance = FirebaseAuth.instance;
  final firestoreInstance = FirebaseFirestore.instance;
  String food = "";
  String foodId = "";

  String? username = "";

  @override
  void initState() {
    super.initState();
    food = widget.widgetFood;
    foodId = widget.widgetFoodId;
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
          const ToolBar(title: "Food"),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
              child: TextField( // or using TextFormField and change initialValue
                controller: TextEditingController()..text = food,
                decoration: const InputDecoration(hintText: "Food Detail"),
                keyboardType: TextInputType.name,
                onChanged: (value){
                  food = value;
                },
              )
            )
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(50, 5, 50, 5),
            child: MaterialButton(
              minWidth: double.infinity,
              color: Colors.lightBlue,
              child: const Text('Submit Foods', style: TextStyle(color: Colors.white)),
              onPressed: () async {
                if(foodId != "") {
                  firestoreInstance.collection("Foods").doc(foodId).update({
                    "food" : food,
                    "username" : username,
                    "submitTime" : Timestamp.now()
                  }).then((value) => Navigator.pop(context));
                } else {
                  firestoreInstance.collection("Foods").add({
                    "food" : food,
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