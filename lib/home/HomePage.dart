import 'package:flutter/material.dart';
import 'package:cs6234/home/Dashboard.dart';
import 'package:cs6234/home/Activity.dart';
import 'package:cs6234/home/Account.dart';
import 'package:cs6234/auth/SignIn.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final authInstance = FirebaseAuth.instance;
  int selectedPage = 0;

  @override
  void initState() {
    super.initState();
    //getUserInfo();
  }

  getUserInfo() {
    if (authInstance.currentUser != null) {
      print(authInstance.currentUser);
      print("here");
    } else {
      print(authInstance.currentUser);
      print("not login");
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const SignIn()));
    }
  }

  final _pageOptions = [
    const Dashboard(),
    const Activity(),
    const Account()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _pageOptions[selectedPage],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.dashboard,
            ),
            label: "Dashboard"
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.history, // folder_shared
            ),
            label: "Activities"
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.account_circle,
            ),
            label: "Account"
          ),
        ],
        selectedItemColor: Colors.lightBlueAccent,
        elevation: 5.0,
        iconSize: 25.0,
        unselectedItemColor: Colors.blue[900],
        currentIndex: selectedPage,
        backgroundColor: Colors.white,
        onTap: (index){
          setState(() {
            selectedPage = index;
          });
        },
        type: BottomNavigationBarType.shifting,
      )
    );
  }
}