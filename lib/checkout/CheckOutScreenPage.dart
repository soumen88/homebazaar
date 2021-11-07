import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:homebazaar/cart/SavedProducts.dart';
import 'package:homebazaar/components/BuyButton.dart';
import 'package:homebazaar/providers/Providers.dart';
import 'dart:developer' as developer;

import 'package:rflutter_alert/rflutter_alert.dart';

class CheckOutScreenPage extends ConsumerWidget {
  String currentScreen = "CheckOutScreenPage";
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

                            return Text("Price : \$" +totalCost.toString());
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
                          if(data != null && data.idFirst!.isNotEmpty){
                            //displayPopUp(context);
                          }
                          //return Text("Order was succesfully placed");
                          return Text("Order was succesfully placed");
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
            return ListTile(
              title: Text(savedProducts.product.title!),
              subtitle:getRow(),
            );
        }
    );
  }

  Widget getRow(){

    return  Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(
          Icons.description,
          color: Colors.blueAccent[400],
          size: 35,
        ),
        SizedBox(width: 20.0,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Guild",
              style: TextStyle(
                fontSize: 15.0,
              ),),
            Text("FairyTail, Magnolia",
              style: TextStyle(
                fontSize: 12.0,
                color: Colors.grey[400],
              ),)
          ],
        ),
        SizedBox(width: 20.0,),
        Text("Price Here")
      ],
    );
  }

  Alert displayPopUp(BuildContext context){
    var alert = Alert(
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
          onPressed: () => Navigator.pop(context),
          width: 120,
        )
      ],
    );

    return alert;
  }
}

