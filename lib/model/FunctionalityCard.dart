import 'package:flutter/material.dart';
import 'package:cs6234/pages/Symptom.dart';
import 'package:cs6234/pages/Medicines.dart';
import 'package:cs6234/pages/Doctor.dart';
import 'package:cs6234/pages/Trip.dart';
import 'package:cs6234/pages/News.dart';
import 'package:cs6234/pages/Food.dart';

class FunctionalityCard extends StatelessWidget {
  const FunctionalityCard({
    Key? key,
    required this.functionality,
    required this.icon
  }) : super(key: key);

  final String functionality;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        switch(functionality) {
          case "Symptoms":
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Symptoms()));
            break;
          case "Medicines":
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Medicines()));
            break;
          case "Doctor Visit":
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Doctor()));
            break;
          case "Trips":
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Trips()));
            break;
          case "News":
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => const News()));
            break;
          case "Take Out Food":
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Food()));
            break;
          default:
            break;
        }
      },
      child: Container(
        child: Column(
          children: [
            Container(height: 10.0),
            Icon(
              icon,
              size: MediaQuery.of(context).size.width * 0.25,
              color: Colors.blue,
            ),
            Container(height: 25.0),
            Text(functionality, style: const TextStyle(
                fontFamily: 'Poppins',
                color: Colors.blue,
                fontSize: 24.0,
                fontWeight: FontWeight.w500
            ))
          ],
        ),
        margin: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 5.0),
        decoration: BoxDecoration(
            color: Colors.white, // dark blue: 0xFF333366
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: const <BoxShadow>[
              BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10.0,
                  offset: Offset(0.0, 10.0)
              )
            ]
        ),
      )
    );
  }
}