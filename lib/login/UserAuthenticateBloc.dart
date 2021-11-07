import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:homebazaar/chopper/ApiService.dart';
import 'package:homebazaar/login/Address.dart';
import 'package:homebazaar/login/GeoLocation.dart';
import 'package:homebazaar/login/Login.dart';
import 'package:homebazaar/login/User.dart';
import 'package:homebazaar/login/UserDetails.dart';
import 'dart:developer' as developer;

import 'package:shared_preferences/shared_preferences.dart';

import '../AppConfig.dart';

class UserAuthenticateBloc extends StateNotifier<AsyncValue<bool>>{
  String currentScreen = "UserAuthentication";
  UserAuthenticateBloc() : super(AsyncData(false))  {
    isFirstTimeLogin();
  }


  void hitServerForRegistration(String email, String username, String password) async{
    state = AsyncLoading();
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
      var geoLocation = GeoLocation(lat: "-37.3159", long: "81.1496");
      var address = Address(city: "Test", street: "Some street", number: 3, zipcode: "12926-3874", geolocation: geoLocation);
      var userdetails = UserDetails(firstname: "John", lastname: "Doe");
      final quoteService = ApiService.instance;
      var user = User(email: email, username: username, password: password, name: userdetails, address: address, phone: "1234567890"  );
      final response = await quoteService.register(user);
      if(response != null){
        state = AsyncData(true);
      }
      else{
        state = AsyncData(false);
      }
    }
    else{
      state = AsyncData(false);
    }
  }

  void hitServerForLogin(String username, String password) async{
    state = AsyncLoading();
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
      var loginModel = Login(username: username, password: password);
      final quoteService = ApiService.instance;
      final response = await quoteService.login(loginModel);
      if(response != null){
        state = AsyncData(true);
      }
      else{
        state = AsyncData(false);
      }
    }
    else{
      state = AsyncData(false);
    }
  }

  bool isValidEmail(String email){
    bool isValid = email.contains(new RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$'));
    return isValid;
  }


  bool isPasswordCompliant(String password, [int minLength = 8]) {
    if (password == null || password.isEmpty) {
      return false;
    }

    //bool hasUppercase = password.contains(new RegExp(r'[A-Z]'));
    bool hasDigits = password.contains(new RegExp(r'[0-9]'));
    bool hasLowercase = password.contains(new RegExp(r'[a-z]'));
    //bool hasSpecialCharacters = password.contains(new RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
    bool hasMinLength = password.length > minLength;

    return hasDigits & hasLowercase & hasMinLength;
  }

  void isFirstTimeLogin() async{
    state = AsyncLoading();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String? isLoginDone = prefs.getString(AppConfig.LOGIN_SUCCESS_KEY);
    developer.log(currentScreen, name: "Shared preferences key ${isLoginDone}");
    if(isLoginDone != null && isLoginDone.isNotEmpty){
      state = AsyncData(true);
    }
    else{
      state = AsyncData(false);
    }
  }

}