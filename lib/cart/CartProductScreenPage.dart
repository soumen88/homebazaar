import 'dart:collection';

import 'package:auto_route/src/router/auto_router_x.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:homebazaar/cart/SavedProducts.dart';
import 'package:homebazaar/components/BuyButton.dart';
import 'package:homebazaar/components/QuantityCounter.dart';
import 'package:homebazaar/productslisting/Products.dart';
import 'package:homebazaar/providers/Providers.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'dart:developer' as developer;

import '../AppConfig.dart';
class CartProductScreenPage extends StatefulWidget {
  final VoidCallback cartClosed;

  CartProductScreenPage({
    Key? key,
    required this.cartClosed
  }) : super(key: key);

  @override
  _CartProductScreenPageState createState() => _CartProductScreenPageState();
}

class _CartProductScreenPageState extends State<CartProductScreenPage> {
  String currentScreen = "CartProductScreenPage";
  int counter = 0;
  List<SavedProducts>? _products = [];
  //List<Products>? _receivedProducts = [];
  SplayTreeMap treeMap = new SplayTreeMap<int, String>();
  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      developer.log(currentScreen , name: "WidgetsBinding");
    });
    SchedulerBinding.instance!.addPostFrameCallback((_) {
      developer.log(currentScreen , name: "SchedulerBinding");
      SplayTreeMap  _receivedProducts = context.read(productListProvider.notifier).cartProductsMap;
      List<Products>  _receivedProducts2 = context.read(productListProvider.notifier).getProductsFromCart;
      context.read(cartProductsNotifier.notifier).addAllProducts(_receivedProducts, _receivedProducts2);
      updateCart();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
        appBar: AppBar(
          title: Text("Cart"),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 16.0, top: 8.0),
              child: GestureDetector(
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: <Widget>[
                    Icon(
                      Icons.shopping_cart,
                      size: 36.0,
                    ),
                    if (counter > 0)
                      Padding(
                        padding: const EdgeInsets.only(left: 2.0),
                        child: CircleAvatar(
                          radius: 8.0,
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          child: Text(
                            counter.toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12.0,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
                onTap: () {

                },
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Consumer(builder: (context,watch, child) {
              final futureProducts = watch(cartProductsNotifier).savedProductsInCart;
              _products!.clear();
              _products!.addAll(futureProducts);

              return Container(
                child: handleReponse(_products, context),
              );
            },
            ),
          ),
        ),
        bottomNavigationBar: BuyButton(tap: ()  {
          developer.log(currentScreen , name : "Buy button was tapped");
          prepareCheckoutcart();
        },
        buttonText: "Buy Now",),
      ),
    );
  }

  void updateCart(){
    List<SavedProducts> savedProducts = context.read(cartProductsNotifier.notifier).savedProductsInCart;
    int totalItemCount = 0;
    for(SavedProducts current in savedProducts){
      totalItemCount = totalItemCount + current.count!;
    }
    setState(() {
      counter = totalItemCount;
    });
  }

  Widget handleReponse(List<SavedProducts>? list, BuildContext context){
    return (list == null) || list.isEmpty ?
    Center(
      child: Image.asset('assets/no_product_found.png'),
    )
        :
    Column(
      children: [
        Text("Product Listing will be done here ${list.length} with counter ${counter}"),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          itemCount: list.length,
          itemBuilder: (BuildContext context, int index) {
            Products currentProduct = list[index].product;
            int productCount = list[index].count!;
            return buildCard(currentProduct, productCount);
          },
        ),
      ],
    );
  }

  Card buildCard(Products currentProduct, int productCount) {
    String heading = currentProduct.title!;
    String count = "Available Pieces: " + currentProduct.rating!.count.toString();
    String cardUrl = currentProduct.image!;
    var supportingText = "Category: " + currentProduct.id!.toString();
    return Card(
        elevation: 4.0,
        child: Column(
          children: [
            ListTile(
              title: Text(heading),
              trailing: InkWell(
                onTap: (){
                  displayAlert(productCount);
                },
                child: Icon(
                  Icons.delete,
                  size: 26.0,
                ),
              ),
            ),
            Container(
              height: 200.0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  cardUrl,
                  height: 150.0,
                  width: 100.0,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('${count}'),

                  Flexible(fit: FlexFit.tight, child: SizedBox()),

                  new QuantityCounter(
                    incrementCountSelected: (count) {
                      developer.log(currentScreen , name :"increment Count was selected.");
                      SavedProducts savedProducts = new SavedProducts(count, currentProduct);
                      context.read(cartProductsNotifier.notifier).changeProductCount(currentProduct, true);
                      updateCart();
                    },
                    decrementCountSelected: (count){
                      developer.log(currentScreen , name :"decrement Count was selected.");
                      context.read(cartProductsNotifier.notifier).changeProductCount(currentProduct, false);
                      updateCart();
                    },
                    initialCount: productCount,
                  ),
                ],
              ) ,
            ),
          ],
        ));
  }

  void prepareCheckoutcart(){
    treeMap.forEach((key, value){
      developer.log(currentScreen ,name: "Value $value");
    });
    //context.read(productListProvider.notifier).getSavedProductsfromCart();
  }
  Future<bool> _onWillPop()  async {

    int count = context.read(productListProvider.notifier).receivedProductsFromApi.length;
    developer.log(currentScreen, name: "Back button pressed count $count");
    context.read(productListProvider.notifier).loadPreviousProducts();
    widget.cartClosed();
    return Future.value(context.router.removeLast());

  }

  void displayAlert(int count){
    Alert(
      context: context,
      type: AlertType.warning,
      title: "Delete Product",
      desc: "Are you sure you want to delete ${count} quantities of this product?",
      buttons: [
        DialogButton(
          child: Text(
            "Okay",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          color: Colors.redAccent
        ),
        DialogButton(
          child: Text(
            "Cancel",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          color: Colors.greenAccent,
        )
      ],
    ).show();
  }
}
