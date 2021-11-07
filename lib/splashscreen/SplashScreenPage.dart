import 'dart:async';

import 'package:auto_route/src/router/auto_router_x.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/src/provider.dart';
import 'package:homebazaar/AppConfig.dart';
import 'package:homebazaar/providers/Providers.dart';
import 'package:homebazaar/routes/AppRouter.gr.dart';
import 'dart:developer' as developer;

class SplashScreenPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SplashScreenState();
  }
}
class SplashScreenState extends State<SplashScreenPage>{

  String currentScreen = "SplashScreenState";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Consumer(
            builder: (builder, watch, child){
              final timerExpired = watch(durationProvider).data!.value;
              if(timerExpired){
                startLoginScreen();
              }
              return Column(
                children: <Widget>[
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
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      developer.log(currentScreen , name: "WidgetsBinding");
      context.read(durationProvider.notifier).startTimer();
    });

  }

  void startLoginScreen(){
    context.router.replace(LoginScreenRoute());
    //context.router.navigate(ProductsListingScreenRoute());
  }
}
