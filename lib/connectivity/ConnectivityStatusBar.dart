import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:homebazaar/providers/Providers.dart';
import 'dart:developer' as developer;

class ConnectivityStatusBar extends StatefulWidget {
  final VoidCallback animationStarted;
  final VoidCallback animationFinished;


  ConnectivityStatusBar({
    Key? key,
    required this.animationStarted,
    required this.animationFinished
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ConnectivityStatusBarState();
  }

}
class ConnectivityStatusBarState extends State<ConnectivityStatusBar> with TickerProviderStateMixin {
  bool _isContainerVisible = true;
  Timer? timer;
  String currentScreen = "ConnectivityStatusBar";
  AnimationController? animation;
  Animation<double>? _fadeInFadeOut;


  @override
  void initState() {

  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (builder, watch, child){
        final isNetworkAvailable = watch(connectivityProvider).data!.value;
        //changeState();
        return displayBar(isNetworkAvailable, context);
      },
    );
  }

  void changeState(){
    animation = AnimationController(vsync: this, duration: Duration(seconds: 3),);
    _fadeInFadeOut = Tween<double>(begin: 1.0, end: 0.0).animate(animation!);

    animation!.addStatusListener((status){
      if(status == AnimationStatus.completed){
        widget.animationFinished();
      }
      else if(status == AnimationStatus.dismissed){
        //animation!.forward();
      }
    });
    animation!.forward();
  }

  Widget displayBar(bool isNetworkAvailable, BuildContext context){
    changeState();
    _isContainerVisible = true;
    widget.animationStarted();
    developer.log(currentScreen, name : "Is display ${_isContainerVisible}");
    return FadeTransition(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.05,
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.center,
          child: Text(
            isNetworkAvailable ? "Internet is Available" : "Internet is not Available",
            style: TextStyle(
                color: Colors.white,
                fontSize: 20
            ),
          ) ,
          color: isNetworkAvailable ? Colors.green : Colors.redAccent,
        ),
        opacity: _fadeInFadeOut! ,
    );
  }
}