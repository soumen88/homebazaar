import 'package:auto_route/src/router/auto_router_x.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'dart:developer' as developer;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:homebazaar/AppConfig.dart';
import 'package:homebazaar/providers/Providers.dart';
import 'package:homebazaar/routes/AppRouter.gr.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreenPage extends ConsumerWidget {
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();


  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final autheticate = watch(authenticateProvider);
    return GestureDetector(
      onTap: (){
        developer.log("LoginScreenPage", name: "Tap deetected");
        dismissKeyboard(context);
      },
      onTapDown: (details){
        dismissKeyboard(context);
      },
      onTapUp: (details){
        dismissKeyboard(context);
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppBar(title: Text("Login Page"),),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                //Consumer Widget
                Container(
                  child: autheticate.when(
                      data: (data) {
                        if(data){
                          startProductListingScreen(context);
                          return Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height,
                              child: Center(child: CircularProgressIndicator())
                          );
                        }
                        else{
                          return loadLoginUi(context);
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
                //_buildBody(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void dismissKeyboard(BuildContext context){
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  Widget loadLoginUi(BuildContext context){
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Column(
          children: [
            Text ("Login", style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),),
            SizedBox(height: 20,),
            Text("Welcome back ! Login with your credentials",style: TextStyle(
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
              makeInput("Password",true, passwordController),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: Container(
            padding: EdgeInsets.only(top: 3,left: 3),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                border: Border(
                    bottom: BorderSide(color: Colors.black),
                    top: BorderSide(color: Colors.black),
                    right: BorderSide(color: Colors.black),
                    left: BorderSide(color: Colors.black)
                )
            ),
            child: MaterialButton(
              minWidth: double.infinity,
              height:60,
              onPressed: (){
                validate(context);
              },
              color: Colors.indigoAccent[400],
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40)
              ),
              child: Text("Login",style: TextStyle(
                  fontWeight: FontWeight.w600,fontSize: 16,color: Colors.white70
              ),),
            ),
          ),
        ),
        SizedBox(height: 20,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Dont have an account?"),
            Padding(
              padding: EdgeInsets.all(10),
              child: InkWell(
                onTap: (){
                  context.router.navigate(RegistrationScreenRoute());
                },
                child: Text("Sign Up",style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18
                ),),
              ),
            ),

          ],
        ),
      ],
    );
  }

  bool validate(BuildContext context){
    String currentScreen = "LoginScreenPage";
    String emailEntered = emailController.text.toString();
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
    context.read(authenticateProvider.notifier).hitServerForLogin(emailEntered, passwordEntered);
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

  Future<String?> _getLoginDetailsSF() async {
    String currentScreen = "LoginScreenPage";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String? stringValue = prefs.getString(AppConfig.LOGIN_SUCCESS_KEY);
    developer.log(currentScreen, name: "Shared preferences key ${stringValue}");
    return stringValue;
  }

  FutureBuilder<String?> _buildBody(){
    String currentScreen = "LoginScreenPage";
    return FutureBuilder(
      future: _getLoginDetailsSF(),
      builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
        if(snapshot.connectionState == ConnectionState.done){
          if(snapshot.hasError){
            developer.log(currentScreen, name : "Found error " + snapshot.error.toString() );
          }
          else{
            final posts = snapshot.data;
            if(posts != null && posts.isNotEmpty){
              startProductListingScreen(context);
            }
            developer.log(currentScreen, name : "Found data $posts" );
            return Text("Found something in shared preferences");
          }
        }
        else if(snapshot.connectionState == ConnectionState.none){
          developer.log(currentScreen, name : "Connection state none" );
        }
        else if(snapshot.connectionState == ConnectionState.waiting){
          return Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Center(child: CircularProgressIndicator())
          );
        }
        return Container(
          child: Text("This is the container"),
        );
      },);
  }

}

//Widget makeInput({label,obsureText = false} ){
Widget makeInput(String label, bool obsureText, TextEditingController controller ){
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
