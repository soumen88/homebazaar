import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'dart:developer' as developer;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:homebazaar/connectivity/AppConnectivity.dart';
import 'package:homebazaar/splashscreen/TimerDurationBloc.dart';


class ConnectivityDetectorBloc extends StateNotifier<AsyncValue<AppConnectivity?>>{

  ConnectivityDetectorBloc() : super(AsyncData(null));

  String currentScreen = "ConnectivityDetectorBloc";
  bool currentStatus = false;
  void connectivityListener() async{
    state = AsyncLoading();


    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
      currentStatus = true;
      AppConnectivity connectivity = new AppConnectivity(isInternetConnected: true,isTimerExpired: false);
      state = AsyncData(connectivity);
    }
    else if(connectivityResult == ConnectivityResult.none){
      currentStatus = false;
      AppConnectivity connectivity = new AppConnectivity(isInternetConnected: false,isTimerExpired: false);
      state = AsyncData(connectivity);
    }

    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      developer.log(currentScreen, name : 'Current connectivity status: $result');

      switch (result) {
        case ConnectivityResult.mobile:{
          currentStatus = true;
          AppConnectivity connectivity = new AppConnectivity(isInternetConnected: true,isTimerExpired: false);
          state = AsyncData(connectivity);
        }
         break;
        case ConnectivityResult.wifi:
          currentStatus = true;
          AppConnectivity connectivity = new AppConnectivity(isInternetConnected: true,isTimerExpired: false);
          state = AsyncData(connectivity);
          break;
        case ConnectivityResult.none:
          currentStatus = false;
          AppConnectivity connectivity = new AppConnectivity(isInternetConnected: false,isTimerExpired: false);
          state = AsyncData(connectivity);
          break;
        default:
          currentStatus = false;
          AppConnectivity connectivity = new AppConnectivity(isInternetConnected: false,isTimerExpired: false);
          state = AsyncData(connectivity);
          break;
      }
    });


  }

  void startTimer(){
    Timer(Duration(seconds: 1), () {
      developer.log(currentScreen, name : "Timer expired");
      AppConnectivity connectivity = new AppConnectivity(isInternetConnected: currentStatus,isTimerExpired: true);
      state = AsyncData(connectivity);
    });
  }

}