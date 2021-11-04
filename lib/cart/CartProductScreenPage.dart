import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:homebazaar/providers/Providers.dart';
import 'dart:developer' as developer;
class CartProductScreenPage extends StatefulWidget {
  const CartProductScreenPage({Key? key}) : super(key: key);

  @override
  _CartProductScreenPageState createState() => _CartProductScreenPageState();
}

class _CartProductScreenPageState extends State<CartProductScreenPage> {

  @override
  void initState() {
    String currentScreen = "CartProductScreenPage";

    WidgetsBinding.instance!.addPostFrameCallback((_) {
      developer.log(currentScreen , name: "WidgetsBinding");
    });
    SchedulerBinding.instance!.addPostFrameCallback((_) {
      developer.log(currentScreen , name: "SchedulerBinding");

    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Cart"),),
      body: Center(
        child: Text("Inside Product cart screen"),
      ),
    );
  }
}
