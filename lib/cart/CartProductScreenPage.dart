import 'dart:collection';

import 'package:auto_route/src/router/auto_router_x.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:homebazaar/cart/SavedProducts.dart';
import 'package:homebazaar/components/BuyButton.dart';
import 'package:homebazaar/components/NavBar.dart';
import 'package:homebazaar/components/QuantityCounter.dart';
import 'package:homebazaar/productslisting/Products.dart';
import 'package:homebazaar/providers/Providers.dart';
import 'package:homebazaar/routes/AppRouter.gr.dart';
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
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
        appBar: NavBar(
          screenName: "Cart Products",
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
        bottomNavigationBar: Visibility(
          child: Consumer(
            builder : (context , watch, child){
              final futureProducts = watch(cartProductsNotifier).savedProductsInCart;
              return Visibility(
                  child: BuyButton(tap: ()  {
                    developer.log(currentScreen , name : "Buy button was tapped");
                    prepareCheckoutcart();
                  },
                    buttonText: "Buy Now",),
                  maintainSize: true,
                  maintainAnimation: true,
                  maintainState: true,
                  visible: (futureProducts.length > 0) ? true : false,
              );
            }
          ),
          maintainSize: true,
          maintainAnimation: true,
          maintainState: true,
          visible: true,
        ),
      ),
    );
  }


  Widget handleReponse(List<SavedProducts>? list, BuildContext context){
    return (list == null) || list.isEmpty ?
    Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height,
      color: Colors.orangeAccent,
      alignment: Alignment.center,
      child: Container(
        width: 300,
        height: 300,
        child: Column(
          children: [
            Image.asset('assets/no_product_found.png'),
            Text("Sorry, No Result Found" , style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white
            ),)
          ],
        ),
      ),
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
                  displayAlert(currentProduct, productCount);
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

                    },
                    decrementCountSelected: (count){
                      developer.log(currentScreen , name :"decrement Count was selected.");
                      context.read(cartProductsNotifier.notifier).changeProductCount(currentProduct, false);
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
    context.router.push(CheckOutScreenRoute());
  }
  Future<bool> _onWillPop()  async {

    int count = context.read(productListProvider.notifier).receivedProductsFromApi.length;
    developer.log(currentScreen, name: "Back button pressed count $count");
    context.read(productListProvider.notifier).loadPreviousProducts();
    widget.cartClosed();
    return Future.value(context.router.removeLast());

  }

  void displayAlert(Products product, int count){
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
          onPressed: () {
            context.read(cartProductsNotifier.notifier).removeProductFromCart(product);
            Navigator.pop(context);
          },
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
