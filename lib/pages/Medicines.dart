import 'package:flutter/material.dart';
import 'package:cs6234/home/Toolbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Medicines extends StatefulWidget {
  final String widgetMedicine;
  final String widgetMedicineId;
  const Medicines({Key? key, this.widgetMedicine = "", this.widgetMedicineId = ""}) : super(key: key);

  @override
  _MedicinesState createState() => _MedicinesState();
}

class _MedicinesState extends State<Medicines> {
  final authInstance = FirebaseAuth.instance;
  final firestoreInstance = FirebaseFirestore.instance;
  String medicine = "";
  String medicineId = "";

  String? username = "";

  @override
  void initState() {
    super.initState();
    medicine = widget.widgetMedicine;
    medicineId = widget.widgetMedicineId;
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
          const ToolBar(title: "Medicines"),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
              child: TextField( // or using TextFormField and change initialValue
                controller: TextEditingController()..text = medicine,
                decoration: const InputDecoration(hintText: "Medicine"),
                keyboardType: TextInputType.name,
                onChanged: (value){
                  medicine = value;
                },
              )
            )
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(50, 5, 50, 5),
            child: MaterialButton(
              minWidth: double.infinity,
              color: Colors.lightBlue,
              child: const Text('Submit Medicines', style: TextStyle(color: Colors.white)),
              onPressed: () async {
                if(medicineId != "") {
                  firestoreInstance.collection("Medicines").doc(medicineId).update({
                    "medicine" : medicine,
                    "username" : username,
                    "submitTime" : Timestamp.now()
                  }).then((value) => Navigator.pop(context));
                } else {
                  firestoreInstance.collection("Medicines").add({
                    "medicine" : medicine,
                    "username" : username,
                    "submitTime" : Timestamp.now()
                  }).then((value){
                    print(value.id);
                    Navigator.pop(context);
                    // Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) =>
                    //   const Dashboard()
                    // ));
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