import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'dart:developer' as developer;

import 'package:flutter_riverpod/flutter_riverpod.dart';


class ConnectivityDetectorBloc extends StateNotifier<AsyncValue<bool>>{

  ConnectivityDetectorBloc() : super(AsyncData(false));

  String currentScreen = "ConnectivityDetectorBloc";
  ConnectivityResult? _connectivityResult;
  late StreamSubscription _connectivitySubscription;
  void connectivityListener(){
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      developer.log(currentScreen, name : 'Current connectivity status: $result');
      switch (result) {
        case ConnectivityResult.mobile:{
          state = AsyncData(true);
        }
         break;
        case ConnectivityResult.wifi:
          state = AsyncData(true);
          break;
        case ConnectivityResult.none:
          state = AsyncData(false);
          break;
        default:

          state = AsyncData(false);
          break;
      }
    });
  }

}