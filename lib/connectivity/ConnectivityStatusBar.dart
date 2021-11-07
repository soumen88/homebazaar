import 'package:flutter/material.dart';

class ConnectivityStatusBar extends StatelessWidget {
  const ConnectivityStatusBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /*return SnackBar(content: Container(
      //color: Colors.white,
      decoration: BoxDecoration(color: Colors.white, border: Border.all(width: 2.0, color: Colors.black), borderRadius: BorderRadius.circular(20)),
      margin: EdgeInsets.fromLTRB(0, 0, 0, 75),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text('Yay! A SnackBar!'),
      ),
    ), backgroundColor: Colors.transparent, elevation: 1000, behavior: SnackBarBehavior.floating,);*/
    return Text("Hello from connection detector");
  }
}