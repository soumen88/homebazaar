import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:homebazaar/chopper/ApiService.dart';
import 'package:homebazaar/login/Address.dart';
import 'package:homebazaar/login/GeoLocation.dart';
import 'package:homebazaar/login/User.dart';
import 'package:homebazaar/login/UserDetails.dart';
import 'dart:developer' as developer;

class UserAuthenticateBloc extends StateNotifier<AsyncValue<bool>>{
  String currentScreen = "UserAuthentication";

  UserAuthenticateBloc(AsyncValue<bool> state) : super(state);

  void hitServerForRegistration(String email, String username, String password) async{
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

}