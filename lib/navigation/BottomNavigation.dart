// import 'package:flutter/material.dart';
// import 'package:cs6234/home/Dashboard.dart';
// import 'package:cs6234/home/Account.dart';
//
// class BottomNavigation extends StatefulWidget {
//   final String title;
//
//   const BottomNavigation(this.title);
//
//   @override
//   State<StatefulWidget> createState() => _BottomNavigationState(this.title);
// }
//
// class _BottomNavigationState extends State<BottomNavigation> with TickerProviderStateMixin<BottomNavigation>{
//   final _bottomNavigationColor = Colors.blue;
//   final String title;
//   int _currentIndex = 0;
//
//   _BottomNavigationState(this.title);
//
//   changePosition() {
//     switch(this.title) {
//       case "Dashboard":
//         _currentIndex = 0;
//         break;
//       case "Account":
//         _currentIndex = 1;
//         break;
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     changePosition();
//     return BottomNavigationBar(
//       //child: BottomNavigationBar(
//       items: [
//         BottomNavigationBarItem(
//             icon: Icon(
//               Icons.dashboard,
//               color: _bottomNavigationColor,
//             ),
//             label: "Dashboard"
//         ),
//         BottomNavigationBarItem(
//             icon: Icon(
//               Icons.account_circle,
//               color: _bottomNavigationColor,
//             ),
//             label: "Account"
//         ),
//       ],
//       currentIndex: _currentIndex,
//       iconSize: 25.0,
//       onTap: (int index) async {
//         switch(index) {
//           case 0:
//             if(this.title != "Dashboard") {
//               Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>
//                   Dashboard()
//               ));
//
//             }
//             break;
//           case 1:
//             if(this.title != "Account") {
//               Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>
//                   Account()
//               ));
//               // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//               // String user = sharedPreferences.getString("User");
//               // bool isLogin = false;
//               // if(user != null) {
//               //   isLogin = true;
//               // }
//               //
//               // Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) =>
//               //     AccountPage(user, isLogin)
//               // ));
//             }
//             break;
//         }
//
//         setState(() {
//           _currentIndex = index;
//         });
//       },
//       selectedItemColor: Colors.lightBlueAccent,
//       type: BottomNavigationBarType.shifting,
//       //)
//     );
//   }
// }