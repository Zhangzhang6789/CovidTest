import 'package:flutter/material.dart';
import 'package:cs6234/home/Toolbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Symptoms extends StatefulWidget {
  final String widgetSymptoms;
  final String widgetSymptomsId;
  const Symptoms({Key? key, this.widgetSymptoms = "", this.widgetSymptomsId = ""}) : super(key: key);

  @override
  _SymptomsState createState() => _SymptomsState();
}

class _SymptomsState extends State<Symptoms> {
  final authInstance = FirebaseAuth.instance;
  final firestoreInstance = FirebaseFirestore.instance;
  String symptoms = "";
  String symptomsId = "";

  String? username = "";
  List<CheckBoxListTileModel> checkBoxListTileModel = CheckBoxListTileModel.getUsers();
  List symtpomList = [];

  @override
  void initState() {
    super.initState();
    symptoms = widget.widgetSymptoms;
    symptomsId = widget.widgetSymptomsId;
    final currentUser = authInstance.currentUser;
    if (currentUser != null) {
      username = currentUser.email;
    } else {
      print("not login");
    }
  }

  void itemChange(bool val, int index) {
    setState(() {
      if(val) {
        symtpomList.add(checkBoxListTileModel[index].title);
      } else {
        symtpomList.remove(checkBoxListTileModel[index].title);
      }
      print(symtpomList);
      checkBoxListTileModel[index].isCheck = val;
    });
  }

  void updateDatabase(String symptom, bool checkLast) {
    firestoreInstance.collection("Symptoms").add({
      "symptom" : symptom,
      "username" : username,
      "submitTime" : Timestamp.now()
    }).then((value){
      print(value.id);
      if(checkLast) {
        Navigator.pop(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          const ToolBar(title: "Symptoms"),
          Flexible(
            child: ListView.builder(
              itemCount: checkBoxListTileModel.length,
              itemBuilder: (BuildContext context, int index){
                return Card(
                  child: Container(
                  padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: <Widget>[
                        CheckboxListTile(
                          activeColor: Colors.pink[300],
                          dense: true,
                          title: Text(
                            checkBoxListTileModel[index].title,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.5
                            ),
                          ),
                          value: checkBoxListTileModel[index].isCheck,
                          onChanged: (bool? val) {
                            itemChange(val!, index);
                          }
                        )
                      ],
                    ),
                  ),
                );
              }
            )
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(50, 5, 50, 25),
            child: MaterialButton(
              minWidth: double.infinity,
              color: Colors.lightBlue,
              child: const Text('Submit Symptoms', style: TextStyle(color: Colors.white)),
              onPressed: () async {
                for(int i = 0; i < symtpomList.length; i++) {
                  if(symtpomList.length - i == 1) {
                    updateDatabase(symtpomList[i], true);
                  } else {
                    updateDatabase(symtpomList[i], false);
                  }

                }
              }
            ),
          )
        ]
      )
    );
  }
}

class CheckBoxListTileModel {
  String title;
  bool isCheck;

  CheckBoxListTileModel({this.title = "", this.isCheck = false});

  static List<CheckBoxListTileModel> getUsers() {
    return <CheckBoxListTileModel>[
      CheckBoxListTileModel(
          title: "Fatigue",
          isCheck: false),
      CheckBoxListTileModel(
          title: "Dizziness",
          isCheck: false),
      CheckBoxListTileModel(
          title: "Headaches",
          isCheck: false),
      CheckBoxListTileModel(
          title: "Sore throat",
          isCheck: false),
      CheckBoxListTileModel(
          title: "Muscle soreness",
          isCheck: false),
      CheckBoxListTileModel(
          title: "Fever",
          isCheck: false),
      CheckBoxListTileModel(
          title: "Loss of smell/taste ",
          isCheck: false),
      CheckBoxListTileModel(
          title: "Cough",
          isCheck: false),
    ];
  }
}