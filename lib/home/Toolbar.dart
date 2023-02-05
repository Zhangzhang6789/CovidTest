import 'package:flutter/material.dart';

class ToolBar extends StatelessWidget {
  const ToolBar({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;
  final double barHeight = 80.0;

  getTitle() {
    return title;
  }


  // cuisine.dart is not using this; need to modify that if Toolbar changed somewhere
  StatelessWidget _getToolBar(BuildContext context) { // return button
    if(title == "Symptoms" || title == "Medicines" || title == "Doctor" || title == "Trips" || title == "News" || title == "Food") {
      return Container(
        margin: const EdgeInsets.only(right: 16.0),
        //child: new BackButton(color: Colors.white),
        child: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
          // size: 30.0,  // in case need to change size
        ),
      );
    } else {
      return const Visibility(
        child: Text("          "),
        visible: true,
      );
    }
  }

  Visibility _getFilterButton(BuildContext context) {
      return const Visibility(
        child: Text("              "),
        visible: true,
      );
  }

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    //print("bar name height: "+ statusBarHeight.toString());
    return Container(
        padding: EdgeInsets.only(top: statusBarHeight),
        height: statusBarHeight / 2 + barHeight,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: FractionalOffset(0.0, 0.0),
            end: FractionalOffset(1.0, 0.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp,
            colors: [
              Color(0xFF3366FF), // blue: 0xFF3366FF; purple: 0xFF9400D3; green: 0xFF3CB371
              Color(0xFF00CCFF), // blue: 0xFF00CCFF; purple: 0xFFEE82EE; green: 0xFF00FF00
            ],
          ),
        ),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween, // check spacer maybe in the future
          children: <Widget>[
            _getToolBar(context),
            Text(title,
                style: const TextStyle(
                    color: Colors.white,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    fontSize: 30.0
                )
            ),
            _getFilterButton(context)
          ],
        )
    );
  }
}