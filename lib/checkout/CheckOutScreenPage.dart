import 'dart:async';

import 'package:auto_route/src/router/auto_router_x.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:homebazaar/cart/SavedProducts.dart';
import 'package:homebazaar/components/BuyButton.dart';
import 'package:homebazaar/connectivity/ConnectivityStatusBar.dart';
import 'package:homebazaar/providers/Providers.dart';
import 'dart:developer' as developer;

import 'package:rflutter_alert/rflutter_alert.dart';

class CheckOutScreenPage extends ConsumerWidget {
  String currentScreen = "CheckOutScreenPage";
  Timer? timer;
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final savedProducts = watch(cartProductsNotifier).savedProductsInCart;
    final cartResponseProduct = watch(cartListProvider);

    return Scaffold(
      appBar: AppBar(title: Text("Product Checkout")),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              flex:5,
              child:Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blue,Colors.orangeAccent],
                  ),
                ),
                child: Column(
                    children: [
                      SizedBox(height: 110.0,),
                      CircleAvatar(radius: (52),
                          backgroundColor: Colors.white,
                          child: ClipRRect(
                            borderRadius:BorderRadius.circular(50),
                            child: Image.asset("assets/homebazaar.jpg"),
                          )
                      ),
                      SizedBox(height: 10.0,),
                      Text('Home Bazaar',
                          style: TextStyle(
                            color:Colors.white,
                            fontSize: 20.0,
                          )),
                      SizedBox(height: 10.0,),
                    ]
                ),
              ),
            ),
            Flexible(
              flex: 2,
              child: Card(
                  child: Padding(
                    padding:EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                            child:Column(
                              children: [
                                Text('Order id',
                                  style: TextStyle(
                                      color: Colors.grey[400],
                                      fontSize: 14.0
                                  ),),
                                SizedBox(height: 5.0,),
                                Text("88",
                                  style: TextStyle(
                                    fontSize: 15.0,
                                  ),)
                              ],
                            )
                        ),

                        Container(
                          child: Column(
                              children: [
                                Text('Order Date',
                                  style: TextStyle(
                                      color: Colors.grey[400],
                                      fontSize: 14.0
                                  ),),
                                SizedBox(height: 5.0,),
                                Text('November 7th',
                                  style: TextStyle(
                                    fontSize: 15.0,
                                  ),)
                              ]),
                        ),

                        Container(
                            child:Column(
                              children: [
                                Text('Delivery By',
                                  style: TextStyle(
                                      color: Colors.grey[400],
                                      fontSize: 14.0
                                  ),),
                                SizedBox(height: 5.0,),
                                Text('November 11',
                                  style: TextStyle(
                                    fontSize: 15.0,
                                  ),)
                              ],
                            )
                        ),
                      ],
                    ),
                  )
              ),
            ),
            Flexible(
              flex: 2,
              child: Card(
                elevation: 2,
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Text("Total Bill"),
                      Consumer(
                          builder: (builder, watch , child){
                            double totalCost = 0.0;
                            for(SavedProducts current in savedProducts){
                              totalCost = totalCost + current.product.price! * current.count!;
                            }
                            developer.log(currentScreen, name : "Found total cost $totalCost");

                            return Text("Price : \$" +totalCost.round().toString());
                          }
                      )
                    ],
                  ),
                ),
              ),
            ),
            Consumer(
              builder: ( context, watch, child) {
                  final cartResponse = watch(cartListProvider);
                  return Container(
                    child: cartResponse.when(
                        data: (data) {
                          if(data != null && data.idFirst!.isNotEmpty && savedProducts.length > 0){
                            displayPopUp(context);
                            return Text("Order was succesfully placed");
                          }
                          else{
                            return Text("Place Your Order Now");
                          }
                        },
                        loading: () {
                          return Container(
                              child: Center(child: CircularProgressIndicator())
                          );
                        },
                        error: (e, st) =>  Text("Something went wrong")
                    ),
                  );
              },
            ),
            Flexible(
              flex:2,
              child: Container(
                color: Colors.grey[200],
                child: Center(
                    child:Card(
                      //margin: EdgeInsets.fromLTRB(0.0, 45.0, 0.0, 0.0),
                      child: Consumer(
                          builder: (builder, watch , child){
                            return Container(
                              child :_buildCheckOutList(savedProducts),
                            );
                          }
                      ),
                    )
                ),
              ),
            ),
            BuyButton(
                tap: (){
                  context.read(cartListProvider.notifier).placeOrder("5", savedProducts);
                },
                buttonText: "Pay now"
            )
          ],
        ),

      ),
      bottomNavigationBar: Consumer(
        builder: (builder , watch, scope){
          String currentScreen = "LoginScreenPage";
          final futureProvider = watch(connectivityProvider);
          bool isVisible = false;
          if(futureProvider.data != null && futureProvider.data!.value != null && futureProvider.data!.value!.isTimerExpired != null){
            isVisible = futureProvider.data!.value!.isTimerExpired!;
          }
          developer.log(currentScreen, name :"Is visible ${isVisible}");
          return Visibility(
            child: ConnectivityStatusBar(
              animationFinished: (isInternetConnected){

              },
              animationStarted: (){

              },
            ),
            visible: !isVisible,
          );
        },
      ),
    );
  }

  Widget _buildCheckOutList(List<SavedProducts> productList){
    return ListView.builder(

        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemCount: productList.length,
        itemBuilder: (context, index){
            SavedProducts savedProducts = productList[index];
            return Card(
              elevation: 4.0,
              child: ListTile(
                title: Text(savedProducts.product.title!),
                subtitle:getRow(savedProducts),
              ),
            );
        }
    );
  }

  Widget getRow(SavedProducts savedProducts){
    double totalCost = savedProducts.product.price! * savedProducts.count!;
    return  Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(width: 10.0,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Quantity",
              style: TextStyle(
                fontSize: 15.0,
              ),),
            Text("${savedProducts.count}",
              style: TextStyle(
                fontSize: 12.0,
                color: Colors.grey[400],
              ),)
          ],
        ),
        SizedBox(width: 20.0,),
        Text("Price: ${savedProducts.count} x ${savedProducts.product.price!} = ${totalCost.round()}"),
        SizedBox(height: 10),
      ],
    );
  }

  void displayPopUp(BuildContext context){
    timer = Timer(Duration(seconds: 2), () {
      timer!.cancel();

      Alert(
        context: context,
        type: AlertType.success,
        title: "Home Bazaar",
        desc: "Your Order Was Successfully Placed",
        buttons: [
          DialogButton(
            child: Text(
              "Okay",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: ()  {
              Navigator.pop(context);
              context.read(cartProductsNotifier.notifier).clearCart();
              context.read(productListProvider.notifier).clearCart();
              context.read(cartProductsNotifier.notifier).clearCartAndNotify();
              context.read(productListProvider.notifier).loadPreviousProducts();
              context.router.popUntilRoot();
            },
            width: 120,
          )
        ],
      ).show();
    });
  }
}

