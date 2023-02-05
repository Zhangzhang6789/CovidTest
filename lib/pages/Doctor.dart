import 'package:flutter/material.dart';
import 'package:cs6234/home/Toolbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Doctor extends StatefulWidget {
  final String widgetDoctor;
  final String widgetDoctorId;
  const Doctor({Key? key, this.widgetDoctor = "", this.widgetDoctorId = ""}) : super(key: key);

  @override
  _DoctorState createState() => _DoctorState();
}

class _DoctorState extends State<Doctor> {
  final authInstance = FirebaseAuth.instance;
  final firestoreInstance = FirebaseFirestore.instance;
  String doctor = "";
  String doctorId = "";

  String? username = "";

  @override
  void initState() {
    super.initState();
    doctor = widget.widgetDoctor;
    doctorId = widget.widgetDoctorId;
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
          const ToolBar(title: "Doctor"),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
              child: TextField( // or using TextFormField and change initialValue
                controller: TextEditingController()..text = doctor,
                decoration: const InputDecoration(hintText: "Doctor Name"),
                keyboardType: TextInputType.name,
                onChanged: (value){
                  doctor = value;
                },
              )
            )
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(50, 5, 50, 5),
            child: MaterialButton(
                minWidth: double.infinity,
                color: Colors.lightBlue,
                child: const Text('Submit Doctor Visit', style: TextStyle(color: Colors.white)),
                onPressed: () async {
                  if(doctorId != "") {
                    firestoreInstance.collection("Doctors").doc(doctorId).update({
                      "doctor" : doctor,
                      "username" : username,
                      "submitTime" : Timestamp.now()
                    }).then((value) => Navigator.pop(context));
                  } else {
                    firestoreInstance.collection("Doctors").add({
                      "doctor" : doctor,
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