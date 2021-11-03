import 'dart:async';

import 'package:auto_route/src/router/auto_router_x.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homebazaar/AppConfig.dart';
import 'package:homebazaar/routes/AppRouter.gr.dart';

class SplashScreenPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SplashScreenState();
  }


}

class SplashScreenState extends State<SplashScreenPage>{


  Timer? timer;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home Bazaar"),),
      body: Container(
        child: Center(
          child: Column(
            children: <Widget>[
              ElevatedButton(
                onPressed: () => context.router.navigate(LoginScreenRoute()),
                child: Text(
                  'Go to SignupScreen',
                ),
              ),
              Container(
                alignment: Alignment.center,
                child: Container(
                  width: 300.0,
                  height: 500.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      image: DecorationImage(
                          image: AssetImage(
                            "assets/homebazaar.jpg",
                          ), fit: BoxFit.cover)
                  ),
                ),
              )
            ],
          ) ,
        ),
      ),
    );
  }

  @override
  void initState() {
    timer = Timer(
        Duration(seconds: AppConfig.SPLASH_SCREEN_TIME),
            () => startLoginScreen()
            );
  }

  void startLoginScreen(){
    timer?.cancel();
    context.router.navigate(ProductsListingScreenRoute());
  }
}
