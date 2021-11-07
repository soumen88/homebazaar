import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:developer' as developer;

import '../AppConfig.dart';

class TimerDurationBloc extends StateNotifier<AsyncValue<bool>>{
  TimerDurationBloc() : super(AsyncData(false));
  String currentScreen = "TimerDurationBloc";
  void startTimer(){
    developer.log(currentScreen, name : "Timer started");
    state = AsyncData(true);
    Timer(Duration(seconds: 3), () {
      developer.log(currentScreen, name : "Timer expired");
      state = AsyncData(false);
    });
    /*Future.delayed(Duration(milliseconds: AppConfig.DURATION_TIMER), () {

    });*/
  }
}