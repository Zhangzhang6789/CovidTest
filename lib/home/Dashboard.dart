import 'package:flutter/material.dart';
import 'package:cs6234/home/Toolbar.dart';
import 'package:cs6234/model/FunctionalityCard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final authInstance = FirebaseAuth.instance;
  final firestoreInstance = FirebaseFirestore.instance;
  String? username = "";
  bool pressCalculate = false;
  num calculateResult = 0;

  @override
  void initState() {
    super.initState();
    final currentUser = authInstance.currentUser;
    if (currentUser != null) {
      print(currentUser);
      username = currentUser.email;
      print("here");
    } else {
      print(currentUser);
      print("not login");
    }
  }



  calculatePossibility() async {
    calculateResult = 0;
    await firestoreInstance.collection("Symptoms").where("username", isEqualTo: username).get().then((string) {
      if(string.docs.length >= 5) {
        calculateResult += 50;
      } else if(string.docs.length < 5 && string.docs.length >= 1) {
        calculateResult += 20;
      }
    });
    await firestoreInstance.collection("Trips").where("username", isEqualTo: username).get().then((string) {
      num count = 0;
      final now = DateTime.now();
      var startingDay = now.subtract(const Duration(days: 7));
      for(int i = 0; i < string.docs.length; i++) {
        if(DateTime.parse(string.docs[i].data()['endTime']).isAfter(startingDay)) {
          count += 1;
        }
      }
      if(count > 3) {
        calculateResult += 40;
      } else if(count <= 3 && count > 1) {
        calculateResult += 20;
      }
    });
    setState(() {
      pressCalculate = true;
    });
  }

  // @override
  // void dispose() {
  //   setState(() {
  //     pressCalculate = false;
  //   });
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const ToolBar(title: "Dashboard"),
          Padding(
            padding: const EdgeInsets.fromLTRB(50, 5, 50, 5),
            child: MaterialButton(
              color: Colors.lightBlue,
              child: const Text('Calculate the possibility to get Covid', style: TextStyle(color: Colors.white)),
              onPressed: () {
                calculatePossibility();
              }
            ),
          ),
          pressCalculate ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3.0, vertical: 4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Get Covid Possibility is " + calculateResult.toString() + "%", style: const TextStyle(
                  fontFamily: 'Poppins',
                  color: Colors.lightBlueAccent,
                  fontSize: 25.0,
                  fontWeight: FontWeight.w600
                )),
              ],
            ),
          ) : Container(),
          Expanded(
            child: GridView.count(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              childAspectRatio: 0.9, // default
              padding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 5.0),
              crossAxisSpacing: 10,
              mainAxisSpacing: 15,
              crossAxisCount: 2,
              physics: const ScrollPhysics(),
              children: const <Widget>[
                FunctionalityCard(
                  functionality: "Symptoms",
                  icon: Icons.announcement,
                ),
                FunctionalityCard(
                  functionality: "Medicines",
                  icon: Icons.medication,
                ),
                FunctionalityCard(
                  functionality: "Doctor Visit",
                  icon: Icons.medical_services,
                ),
                FunctionalityCard(
                  functionality: "Trips",
                  icon: Icons.beach_access,
                ),
                FunctionalityCard(
                  functionality: "News",
                  icon: Icons.new_releases,
                ),
                FunctionalityCard(
                  functionality: "Take Out Food",
                  icon: Icons.food_bank,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}