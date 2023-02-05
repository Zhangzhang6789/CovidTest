import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cs6234/home/Homepage.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  FirebaseAuth auth = FirebaseAuth.instance;
  String email = "";

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
                    const Text("Reset Password", style: TextStyle(
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
                    Container(height: 30.0),
                    MaterialButton(
                        minWidth: double.infinity,
                        color: Colors.lightBlue,
                        child: const Text('Reset', style: TextStyle(color: Colors.white)),
                        onPressed: () async {
                          await auth.sendPasswordResetEmail(email: email);
                          Navigator.pop(context);
                        }
                    )
                  ],
                )
            ),

          ],
        ),
      ),
    );
  }
}