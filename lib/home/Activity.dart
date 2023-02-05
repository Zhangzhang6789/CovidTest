import 'package:flutter/material.dart';
import 'package:cs6234/home/Toolbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:cs6234/pages/Medicines.dart';
import 'package:cs6234/pages/Doctor.dart';
import 'package:cs6234/pages/Trip.dart';
import 'package:cs6234/pages/News.dart';
import 'package:cs6234/pages/Food.dart';
import 'package:intl/intl.dart';

class Activity extends StatefulWidget {
  const Activity({Key? key}) : super(key: key);

  @override
  _ActivityState createState() => _ActivityState();
}

class _ActivityState extends State<Activity> {
  final authInstance = FirebaseAuth.instance;
  final firestoreInstance = FirebaseFirestore.instance;

  var activitiList = ["Symptoms", "Medicines", "Doctor Visit", "Trip", "News", "Take Out Food", "Apple Health"];
  var selectActivity = "Symptoms";
  var selectActivityDatabase = "Symptoms";

  int? defaultChoiceIndex = 0;
  String? username = "";

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

  scrollableRow() {
    return Wrap(
      spacing: 5,
      children: List.generate(activitiList.length, (index) {
        return ChoiceChip(
          labelPadding: const EdgeInsets.all(2.0),
          label: Text(activitiList[index], style: const TextStyle(
              fontFamily: 'Poppins',
              color: Colors.white,
              fontSize: 13.0,
              fontWeight: FontWeight.w500
            )
          ),
          selected: defaultChoiceIndex == index,
          selectedColor: Colors.redAccent,
          onSelected: (value) {
            setState(() {
              defaultChoiceIndex = value ? index : defaultChoiceIndex;
              selectActivity = activitiList[index];
              print(selectActivity);
              switch(selectActivity) {
                case "Symptoms":
                  selectActivityDatabase = "Symptoms";
                  break;
                case "Medicines":
                  selectActivityDatabase = "Medicines";
                  break;
                case "Doctor Visit":
                  selectActivityDatabase = "Doctors";
                  break;
                case "Trip":
                  selectActivityDatabase = "Trips";
                  break;
                case "News":
                  selectActivityDatabase = "News";
                  break;
                case "Take Out Food":
                  selectActivityDatabase = "Foods";
                  break;
                case "Apple Health":
                  selectActivityDatabase = "Health";
                  break;
                default:
                  break;
              }
            });
          },
          backgroundColor: Colors.lightBlue,
          elevation: 4,
          padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
        );
      }),
    );
  }

  deleteSymptom(String documentId) {
    firestoreInstance.collection("Symptoms").doc(documentId).delete().then((value){
      print("Success delete symptom!");
    });
  }

  deleteMedicine(String documentId) {
    firestoreInstance.collection("Medicines").doc(documentId).delete().then((value){
      print("Success delete medicine!");
    });
  }

  deleteDoctor(String documentId) {
    firestoreInstance.collection("Doctors").doc(documentId).delete().then((value){
      print("Success delete doctor visit!");
    });
  }

  deleteTrip(String documentId) {
    firestoreInstance.collection("Trips").doc(documentId).delete().then((value){
      print("Success delete trip!");
    });
  }

  deleteNews(String documentId) {
    firestoreInstance.collection("News").doc(documentId).delete().then((value){
      print("Success delete news!");
    });
  }

  deleteFoods(String documentId) {
    firestoreInstance.collection("Foods").doc(documentId).delete().then((value){
      print("Success delete take out food!");
    });
  }

  deleteHealth(String documentId) {
    firestoreInstance.collection("Health").doc(documentId).delete().then((value){
      print("Success delete take out food!");
    });
  }

  deleteFunctionality(String documentId) {
    switch(selectActivity) {
      case "Symptoms":
        deleteSymptom(documentId);
        break;
      case "Medicines":
        deleteMedicine(documentId);
        break;
      case "Doctor Visit":
        deleteDoctor(documentId);
        break;
      case "Trip":
        deleteTrip(documentId);
        break;
      case "News":
        deleteNews(documentId);
        break;
      case "Take Out Food":
        deleteFoods(documentId);
        break;
      case "Apple Health":
        deleteHealth(documentId);
        break;
      default:
        break;
    }
  }

  detailContent(DocumentSnapshot ds) {
    print(ds.data());
    switch(selectActivity) {
      case "Symptoms":
        return RichText(
          text: TextSpan(
            style: const TextStyle(
              fontFamily: 'Poppins',
              color: Colors.black,
              fontSize: 15.0,
              fontWeight: FontWeight.w400
            ),
            children: [
              const TextSpan(text: "Symptom: "),
              TextSpan(
                text: ds.data().toString().contains('symptom') ? ds['symptom'].toString() : "",
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  color: Colors.black,
                  fontSize: 15.0,
                  fontWeight: FontWeight.w700
                )
              ),
              const TextSpan(text: " Date: "),
              TextSpan(
                text: ds.data().toString().contains('submitTime') ? DateFormat("yyyy-MM-dd").format(ds['submitTime'].toDate()) : "",
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  color: Colors.black,
                  fontSize: 15.0,
                  fontWeight: FontWeight.w700
                )
              )
            ]
          ),
        );
      case "Medicines":
        return RichText(
          text: TextSpan(
            style: const TextStyle(
              fontFamily: 'Poppins',
              color: Colors.black,
              fontSize: 15.0,
              fontWeight: FontWeight.w400
            ),
            children: [
              const TextSpan(text: "Medicine: "),
              TextSpan(
                text: ds.data().toString().contains('medicine') ? ds['medicine'].toString() : "",
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  color: Colors.black,
                  fontSize: 15.0,
                  fontWeight: FontWeight.w700
                )
              ),
              const TextSpan(text: " Date: "),
              TextSpan(
                text: ds.data().toString().contains('submitTime') ? DateFormat("yyyy-MM-dd").format(ds['submitTime'].toDate()) : "",
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  color: Colors.black,
                  fontSize: 15.0,
                  fontWeight: FontWeight.w700
                )
              )
            ]
          ),
        );
      case "Doctor Visit":
        return RichText(
          text: TextSpan(
            style: const TextStyle(
              fontFamily: 'Poppins',
              color: Colors.black,
              fontSize: 15.0,
              fontWeight: FontWeight.w400
            ),
            children: [
              const TextSpan(text: "Doctor: "),
              TextSpan(
                text: ds.data().toString().contains('doctor') ? ds['doctor'].toString() : "",
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  color: Colors.black,
                  fontSize: 15.0,
                  fontWeight: FontWeight.w700
                )
              ),
              const TextSpan(text: " Date: "),
              TextSpan(
                text: ds.data().toString().contains('submitTime') ? DateFormat("yyyy-MM-dd").format(ds['submitTime'].toDate()) : "",
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  color: Colors.black,
                  fontSize: 15.0,
                  fontWeight: FontWeight.w700
                )
              )
            ]
          ),
        );
      case "Trip":
        return RichText(
          text: TextSpan(
            style: const TextStyle(
              fontFamily: 'Poppins',
              color: Colors.black,
              fontSize: 15.0,
              fontWeight: FontWeight.w400
            ),
            children: [
              const TextSpan(text: "Trip: "),
              TextSpan(
                text: ds.data().toString().contains('trip') ? ds['trip'].toString(): "",
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  color: Colors.black,
                  fontSize: 15.0,
                  fontWeight: FontWeight.w700
                )
              ),
              TextSpan(text: ds.data().toString().contains('startTime') ? " From: " + ds['startTime'].toString(): ""),
              // TextSpan(
              //   text: ds.data().toString().contains('startTime') ? ds['startTime'].toString() + " To: ": "",
              //     style: const TextStyle(
              //      fontFamily: 'Poppins',
              //      color: Colors.black,
              //      fontSize: 15.0,
              //      fontWeight: FontWeight.w700
              //   ),
              // ),
              TextSpan(
                text: ds.data().toString().contains('endTime') ? " To: " + ds['endTime'].toString() : "",
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  color: Colors.black,
                  fontSize: 15.0,
                  // fontWeight: FontWeight.w600
                ),
              ),
            ]
          ),
        );
      case "News":
        return RichText(
          text: TextSpan(
            style: const TextStyle(
              fontFamily: 'Poppins',
              color: Colors.black,
              fontSize: 15.0,
              fontWeight: FontWeight.w400
            ),
            children: [
              const TextSpan(text: "News: "),
              TextSpan(
                text: ds.data().toString().contains('news') ? ds['news'].toString() : "",
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  color: Colors.black,
                  fontSize: 15.0,
                  fontWeight: FontWeight.w700
                )
              ),
              const TextSpan(text: " Date: "),
              TextSpan(
                text: ds.data().toString().contains('submitTime') ? DateFormat("yyyy-MM-dd").format(ds['submitTime'].toDate()) : "",
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  color: Colors.black,
                  fontSize: 15.0,
                  fontWeight: FontWeight.w700
                )
              )
            ]
          ),
        );
      case "Take Out Food":
        return RichText(
          text: TextSpan(
            style: const TextStyle(
              fontFamily: 'Poppins',
              color: Colors.black,
              fontSize: 15.0,
              fontWeight: FontWeight.w400
            ),
            children: [
              const TextSpan(text: "Food: "),
              TextSpan(
                text: ds.data().toString().contains('food') ? ds['food'].toString() : "",
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  color: Colors.black,
                  fontSize: 15.0,
                  fontWeight: FontWeight.w700
                )
              ),
              const TextSpan(text: " Date: "),
              TextSpan(
                text: ds.data().toString().contains('submitTime') ? DateFormat("yyyy-MM-dd").format(ds['submitTime'].toDate()) : "",
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  color: Colors.black,
                  fontSize: 15.0,
                  fontWeight: FontWeight.w700
                )
              )
            ]
          ),
        );
      case "Apple Health":
        return RichText(
          text: TextSpan(
            style: const TextStyle(
              fontFamily: 'Poppins',
              color: Colors.black,
              fontSize: 15.0,
              fontWeight: FontWeight.w400
            ),
            children: [
              TextSpan(text: ds.data().toString().contains('date') ? DateFormat("yyyy-MM-dd").format(ds['date'].toDate()).toString() + " ": ""),
              TextSpan(
                text: ds.data().toString().contains('steps') ? "steps: " + ds['steps'].toString() : "",
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  color: Colors.black,
                  fontSize: 15.0,
                  fontWeight: FontWeight.w700
                )
              ),
              TextSpan(
                text: ds.data().toString().contains('distance') ? " distance: " + ds['distance'].toString() : "",
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  color: Colors.black,
                  fontSize: 15.0,
                  fontWeight: FontWeight.w700
                )
              )
            ]
          ),
        );
      default:
        break;
    }
  }

  showWarning() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection("News").where("alertEmail", isEqualTo: username).orderBy('submitTime', descending: true).snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if(!snapshot.hasData) {
          return const Center(
            child: Text("Loading", style: TextStyle(
              fontFamily: 'Poppins',
              color: Colors.blue,
              fontSize: 20.0,
              fontWeight: FontWeight.w500
            ))
          );
        } else {
          return ListView.builder(
            shrinkWrap: true,
            physics: const AlwaysScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              DocumentSnapshot ds = (snapshot.data!).docs[index];
              return Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 5.0),
                  child: Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(5.0, 17.0, 5.0, 0.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                flex: 2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(left: 12.0),
                                      child: RichText(
                                        text: TextSpan(
                                          style: const TextStyle(
                                            fontFamily: 'Poppins',
                                            color: Colors.black,
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.w400
                                          ),
                                          children: [
                                            const TextSpan(text: "News: "),
                                            TextSpan(
                                              text: ds.data().toString().contains('news') ? ds['news'].toString() : "",
                                              style: const TextStyle(
                                                fontFamily: 'Poppins',
                                                color: Colors.black,
                                                fontSize: 15.0,
                                                fontWeight: FontWeight.w700
                                              )
                                            ),
                                            const TextSpan(text: " Date: "),
                                            TextSpan(
                                              text: ds.data().toString().contains('submitTime') ? DateFormat("yyyy-MM-dd").format(ds['submitTime'].toDate()) : "",
                                              style: const TextStyle(
                                                fontFamily: 'Poppins',
                                                color: Colors.black,
                                                fontSize: 15.0,
                                                fontWeight: FontWeight.w700
                                              )
                                            ),
                                            const TextSpan(text: " Warning From: "),
                                            TextSpan(
                                              text: ds.data().toString().contains('username') ? ds['username'] : "",
                                              style: const TextStyle(
                                                fontFamily: 'Poppins',
                                                color: Colors.black,
                                                fontSize: 15.0,
                                                fontWeight: FontWeight.w700
                                              )
                                            ),
                                          ]
                                        ),
                                      )
                                    ),
                                  ],
                                )
                              ),
                            ],
                          ),
                        ),
                        Container(height: 16.0),
                      ],
                    )
                  ),
              );
            },
            itemCount: (snapshot.data!).docs.length,
            //padding: new EdgeInsets.symmetric(vertical: 4.0) // distance from bar to the first one
          );
        }
      },
    );
  }

  showDetail() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection(selectActivityDatabase).where("username", isEqualTo: username).orderBy('submitTime', descending: true).snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if(!snapshot.hasData) {
          return const Center(
            child: Text("Loading", style: TextStyle(
              fontFamily: 'Poppins',
              color: Colors.blue,
              fontSize: 20.0,
              fontWeight: FontWeight.w500
            ))
          );
        } else {
          return ListView.builder(
            shrinkWrap: true,
            physics: const AlwaysScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              DocumentSnapshot ds = (snapshot.data!).docs[index];
              return Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 5.0),
                  child: Slidable(
                    key: Key(ds.id),
                    endActionPane: ActionPane(
                      motion: const ScrollMotion(),
                      dismissible: DismissiblePane(onDismissed: () {
                        deleteFunctionality(ds.id);
                      }),
                      children: [
                        selectActivity != "Apple Health"  && selectActivity != "Symptoms" ? SlidableAction(
                          // An action can be bigger than the others.
                          flex: 2,
                          onPressed: (_) {
                            switch(selectActivity) {
                              case "Medicines":
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => Medicines(widgetMedicine: ds['medicine'], widgetMedicineId: ds.id)));
                                break;
                              case "Doctor Visit":
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => Doctor(widgetDoctor: ds['doctor'], widgetDoctorId: ds.id)));
                                break;
                              case "Trip":
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => Trips(widgetTrip: ds['trip'], widgetTripId: ds.id, widgetStartTime: ds['startTime'], widgetEndTime: ds['endTime'])));
                                break;
                              case "News":
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => News(widgetNews: ds['medicine'], widgetNewsId: ds.id)));
                                break;
                              case "Take Out Food":
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => Food(widgetFood: ds['food'], widgetFoodId: ds.id)));
                                break;
                              default:
                                break;
                            }
                          },
                          backgroundColor: const Color(0xFF21B7CA),
                          foregroundColor: Colors.white,
                          icon: Icons.border_color,
                          label: 'Modify',
                        ) : Container(),
                        SlidableAction(
                          // An action can be bigger than the others.
                          flex: 2,
                          onPressed: (_) {
                            deleteFunctionality(ds.id);
                          },
                          backgroundColor: Colors.redAccent,
                          foregroundColor: Colors.white,
                          icon: Icons.delete,
                          label: 'Delete',
                        ),
                      ],
                    ),
                    child: Card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.fromLTRB(5.0, 17.0, 5.0, 0.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Expanded(
                                  flex: 2,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(left: 12.0),
                                        child: detailContent(ds)
                                      ),
                                    ],
                                  )
                                ),
                              ],
                            ),
                          ),
                          Container(height: 16.0),
                        ],
                      )
                    ),
                  )
              );
            },
            itemCount: (snapshot.data!).docs.length,
            //padding: new EdgeInsets.symmetric(vertical: 4.0) // distance from bar to the first one
          );
        }
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const ToolBar(title: "Activities"),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: scrollableRow(),
          ),
          Expanded(
            child: showDetail()
          ),
          Expanded(child: selectActivity == "News" ? showWarning() : Container())
        ]
      )
    );
  }
}