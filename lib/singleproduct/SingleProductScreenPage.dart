import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:homebazaar/AppConfig.dart';
import 'package:homebazaar/cart/SavedProducts.dart';
import 'package:homebazaar/components/BuyButton.dart';
import 'package:homebazaar/components/NavBar.dart';
import 'package:homebazaar/components/QuantityCounter.dart';
import 'package:homebazaar/productslisting/ProductListingNotifierBloc.dart';
import 'package:homebazaar/productslisting/Products.dart';
import 'package:homebazaar/providers/Providers.dart';
import 'dart:developer' as developer;

import 'package:homebazaar/routes/AppRouter.gr.dart';



class SingleProductScreenPage extends StatefulWidget {
  Products displayProduct;
  final void Function(int) onRateBook;
  SingleProductScreenPage({
    Key? key,
    required this.displayProduct,
    required this.onRateBook
    })
      : super(key: key);

  @override
  _SingleProductListingScreenState createState() => _SingleProductListingScreenState();
}

class _SingleProductListingScreenState extends State<SingleProductScreenPage> {

  int counter = 0;
  @override
  void initState() {
    String currentScreen = "SingleProductScreenPage";
    developer.log(currentScreen, name: "Selected product id ${widget.displayProduct.id}");
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      developer.log(currentScreen , name: "WidgetsBinding");
    });
    SchedulerBinding.instance!.addPostFrameCallback((_) {
      developer.log(currentScreen , name: "SchedulerBinding");
      context.read(productListProvider.notifier).saveProductDetails(widget.displayProduct);
      updateCart();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,

      child: Scaffold(
        appBar: NavBar(
            screenName: "Product Description",
            isCartRouteAllowed : true,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Consumer(
                  builder: (context, watch, child) {
                    final futureProducts = watch(productListProvider);
                    final savedProducts = watch(cartProductsNotifier).savedProductsInCart;

                    return Container(
                      child: futureProducts.when(
                          data: (data) {
                            int productCount = 0;
                            List<SavedProducts> savedProductsList = savedProducts.where((element) => element.product.id! == widget.displayProduct.id!).toList();
                            if(savedProductsList.isNotEmpty){
                              productCount = savedProductsList.first.count!;
                            }
                            return handleReponse(data!.first, productCount);
                          },
                          loading: () => CircularProgressIndicator(),
                          error: (e, st) =>  Text("Something went wrong")
                      ),
                    );
                  },
                ),

              ],
            ),
          ) ,
        ),
      ),
    );
  }

  Widget handleReponse(Products? currentProduct, int productCount) {
    return currentProduct == null ?
    Center(
      child: CircularProgressIndicator(),
    )
        : Column(
      children: [
        buildCard(currentProduct, productCount)
      ],
    );
  }

  Widget buildCard(Products currentProduct, int productCount) {
    String heading = currentProduct.title!;
    String rating = currentProduct.rating!.rate!.toString();
    String description = "Product Description: "+ currentProduct.description!;
    String price = "Price : \$" + currentProduct.price!.toString();
    String cardUrl = currentProduct.image!;
    var supportingText = "Category: " + currentProduct.category!;
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        ListTile(
          leading: Text(price, style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold
          )),
          trailing: Icon(Icons.favorite_outline),
        ),
        Container(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Hero(
              tag: currentProduct.id!,
              child: Image.network(
                cardUrl,
                height: size.height * 0.4,
                fit: BoxFit.fitHeight,
                width: MediaQuery.of(context).size.width,
              ),

            ),
          ),
          color: AppConfig.bodyColor,
        ),
        Container(
          padding: EdgeInsets.all(16.0),
          alignment: Alignment.center,
          child: Text(supportingText),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                heading,
                style: TextStyle(
                    fontSize: 24
                ),
              ),
            )
          ],
        ),
        Padding(
          padding: EdgeInsets.all(16),
          child: Text('${description}'),
        ),
        Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SvgPicture.asset(
                'assets/icons/star.svg',
                width: AppConfig.kDefaultPadding * 0.8,
              ),

              SizedBox(width: AppConfig.kDefaultPadding * 0.5),

              Text('${rating}'),

              Flexible(fit: FlexFit.tight, child: SizedBox()),

              QuantityCounter(
                incrementCountSelected: (count) {
                  developer.log(currentScreen , name :"increment Count was selected.");
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
        SizedBox(width: 10),

        Container(
          margin: EdgeInsets.all(5),
          child: BuyButton(tap: ()  {
            developer.log(currentScreen , name : "Buy button was tapped");
            context.router.push(CheckOutScreenRoute());
          },buttonText: "Buy Now",),
        ),

      ],
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


  Future<bool> _onWillPop()  async {
    developer.log(currentScreen, name: "Back button pressed");
    widget.onRateBook(5);
    context.read(productListProvider.notifier).loadPreviousProducts();
    return Future.value(context.router.removeLast());

  }
}
