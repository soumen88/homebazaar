import 'package:auto_route/src/router/auto_router_x.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:homebazaar/components/BuyButton.dart';
import 'package:homebazaar/providers/Providers.dart';
import 'dart:developer' as developer;

import 'package:homebazaar/routes/AppRouter.gr.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../AppConfig.dart';

class RegistrationScreenPage extends ConsumerWidget {
  TextEditingController emailController = new TextEditingController();
  TextEditingController userNameController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final autheticate = watch(authenticateProvider);
    return GestureDetector(
      onTap: (){
        dismissKeyboard(context);
      },
      onTapUp:(details){
        dismissKeyboard(context);
      },
      onTapDown: (details){
        dismissKeyboard(context);
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(title: Text("Sign Up"),),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Column(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text ("Sign up", style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),),
                        SizedBox(height: 20,),
                        Text("Create an Account, And Look up to great deals!",style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey[700],
                        ),),
                        SizedBox(height: 30,)
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 40
                      ),
                      child: Column(
                        children: [
                          makeInput("Email", false, emailController),
                          makeInput("Username",false, userNameController),
                          makeInput("Password",true, passwordController),

                        ],
                      ),
                    ),
                    Container(
                      child: autheticate.when(
                          data: (data) {
                            if(data){
                              startProductListingScreen(context);
                            }
                            else{
                              return Padding(
                                padding: EdgeInsets.symmetric(horizontal: 40),
                                child: Container(
                                  padding: EdgeInsets.only(top: 3,left: 3),
                                  child: BuyButton(tap: ()  {
                                    validate(context);
                                  },buttonText: "Sign Up",),
                                ),
                              );
                            }
                          },
                          loading: () {
                            return Container(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height,
                                child: Center(child: CircularProgressIndicator())
                            );
                          },
                          error: (e, st) =>  Text("Something went wrong")
                      ),
                    ),
                  ],

                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool validate(BuildContext context){
    String currentScreen = "RegistrationScreenPage";
    String emailEntered = emailController.text.toString();
    String usernameEntered = userNameController.text.toString();
    String passwordEntered = passwordController.text.toString();
    bool isEmailValid = context.read(authenticateProvider.notifier).isValidEmail(emailEntered);
    if(!isEmailValid){
      displaySnackBar(context, "Invalid Email", true);
      return false;
    }
    bool isPasswordValid = context.read(authenticateProvider.notifier).isPasswordCompliant(passwordEntered);
    if(!isPasswordValid){
      displaySnackBar(context, "Invalid Password", true);
      return false;
    }
    context.read(authenticateProvider.notifier).hitServerForRegistration(emailEntered, usernameEntered, passwordEntered);
    developer.log(currentScreen, name: "Is email valid ${isEmailValid} and ${isPasswordValid}");
    return true;
  }

  void displaySnackBar(BuildContext context, String message, bool isError){
    var snackBar = SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void startProductListingScreen(BuildContext context) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(AppConfig.LOGIN_SUCCESS_KEY, "Success");
    context.router.replace(ProductsListingScreenRoute());
  }

  void dismissKeyboard(BuildContext context){
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }
}

//Widget makeInput({label,obsureText = false}){
Widget makeInput(String label , bool obsureText, TextEditingController controller){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label,style:TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w400,
          color: Colors.black87
      ),),
      SizedBox(height: 5,),
      TextField(
        obscureText: obsureText,
        controller: controller,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 0,horizontal: 10),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey,
            ),
          ),
          border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey)
          ),
        ),
      ),
      SizedBox(height: 30,)

    ],
  );
}
