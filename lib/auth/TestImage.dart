import 'package:flutter/material.dart';

//ProgressDialog pr;

class TestPage extends StatefulWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {


  @override
  Widget build(BuildContext context) {
    //pr = new ProgressDialog(context,type: ProgressDialogType.Normal);
    //pr.style(message: 'Loading...');

    return Scaffold(
        body: Image.asset('assets/images/image7.png',
          fit: BoxFit.cover,
          height: double.infinity,
          width: double.infinity,
          alignment: Alignment.center,
        )
    );
  }
}