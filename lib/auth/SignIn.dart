import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cs6234/home/Homepage.dart';
import 'package:cs6234/auth/ResetPassword.dart';
import 'package:cs6234/auth/Register.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  FirebaseAuth auth = FirebaseAuth.instance;
  String email = "";
  String password = "";
  bool checkCorrectness = true;

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
                  const Text("Sign In", style: TextStyle(
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
                  Container(height: 30.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        child: TextButton(
                          child: const Text(
                            'Register',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Register()));
                          },
                        )
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          child: const Text(
                            'Forgot Password?',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ResetPassword()));
                          },
                        )
                      ),
                    ],
                  ),
                  Container(height: 20.0),
                  MaterialButton(
                    minWidth: double.infinity,
                    color: Colors.lightBlue,
                    child: const Text('Login', style: TextStyle(color: Colors.white)),
                    onPressed: () async {
                      try {
                        UserCredential userCredential = await auth.signInWithEmailAndPassword(
                            email: email,
                            password: password
                        );
                        print(userCredential.toString());
                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const HomePage()));
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'user-not-found') {
                          print('No user found for that email.');
                        } else if (e.code == 'wrong-password') {
                          print('Wrong password provided for that user.');
                        }
                        setState(() {
                          checkCorrectness = false;
                        });
                      }
                    }
                  ),
                  Container(height: 10.0),
                  Text(checkCorrectness == true
                      ? ""
                      : "Wrong Username or Password", style: const TextStyle(
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