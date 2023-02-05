import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cs6234/home/Homepage.dart';
import 'package:cs6234/auth/ResetPassword.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  FirebaseAuth auth = FirebaseAuth.instance;
  final firestoreInstance = FirebaseFirestore.instance;
  String email = "";
  String password = "";
  String checkCorrectness = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF3366FF), // blue: 0xFF3366FF; purple: 0xFF9400D3; green: 0xFF3CB371
              Color(0xFF00CCFF)
            ],
          ),
        ),
        child: ListView(
          //crossAxisAlignment: CrossAxisAlignment.start,
          padding: const EdgeInsets.symmetric(horizontal: 30.0).copyWith(top: 140.0),
          children: [
            Align(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    const Text("Register", style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.lightBlueAccent,
                        fontSize: 25.0,
                        fontWeight: FontWeight.w600
                    )),
                    Container(height: 40.0),
                    TextField(
                      decoration: const InputDecoration(
                        hintText: "Email Address",
                        hintStyle: TextStyle(color: Colors.white70),
                      ),
                      onChanged: (value){
                        email = value;
                      },
                      style: const TextStyle(color: Colors.white70),
                    ),
                    Container(height: 20.0),
                    TextField(
                      decoration: const InputDecoration(
                        hintText: "Password",
                        hintStyle: TextStyle(color: Colors.white70),
                      ),
                      obscureText: true,
                      onChanged: (value){
                        password = value;
                      },
                      style: const TextStyle(color: Colors.white70),
                    ),
                    Container(height: 40.0),
                    MaterialButton(
                        minWidth: double.infinity,
                        color: Colors.lightBlue,
                        child: const Text('Register', style: TextStyle(color: Colors.white)),
                        onPressed: () async {
                          try {
                            UserCredential userCredential = await auth.createUserWithEmailAndPassword(
                                email: email,
                                password: password
                            );
                            firestoreInstance.collection("User").add({
                              "email" : email,
                              "submitTime" : Timestamp.now()
                            }).then((value){
                              print(value.id);
                              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const HomePage()));
                              // Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) =>
                              //   const Dashboard()
                              // ));
                            });
                          } on FirebaseAuthException catch (e) {
                            setState(() {
                              if (e.code == 'weak-password') {
                                checkCorrectness = "The password provided is too weak";
                              } else if (e.code == 'email-already-in-use') {
                                checkCorrectness = "The account already exists for that email";
                              }
                            });
                          }
                        }
                    ),
                    Container(height: 10.0),
                    Text(checkCorrectness, style: const TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.red,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w700
                    )),
                  ],
                )
            ),

          ],
        ),
      ),
    );
  }
}