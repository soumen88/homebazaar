import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:homebazaar/AppConfig.dart';
import 'package:homebazaar/components/BuyButton.dart';
import 'package:homebazaar/components/QuantityCounter.dart';
import 'package:homebazaar/productslisting/ProductListingNotifierBloc.dart';
import 'package:homebazaar/productslisting/Products.dart';
import 'package:homebazaar/providers/Providers.dart';
import 'dart:developer' as developer;



class SingleProductScreenPage extends StatefulWidget {
  int selectedProduct;

  SingleProductScreenPage({
    Key? key,
    @PathParam() required this.selectedProduct })
      : super(key: key);

  @override
  _SingleProductListingScreenState createState() => _SingleProductListingScreenState();
}

class _SingleProductListingScreenState extends State<SingleProductScreenPage> {

  @override
  void initState() {
    String currentScreen = "SingleProductScreenPage";
    developer.log(currentScreen, name: "Selected product id ${widget.selectedProduct}");
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      developer.log(currentScreen , name: "WidgetsBinding");
    });
    SchedulerBinding.instance!.addPostFrameCallback((_) {
      developer.log(currentScreen , name: "SchedulerBinding");
      context.read(productListProvider.notifier).getSingleProductDetails(widget.selectedProduct);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {



    return Scaffold(
      appBar: AppBar(title: Text("Single Product Listing"),),
      body: Center(
        child: Column(
          children: [
            Text("We are in the single product listing screen ${widget.selectedProduct} and ${receivedProductsFromServer.length}"),
            Consumer(
              builder: (context, watch, child) {
                final futureProducts = watch(productListProvider);
                return Container(
                  child: futureProducts.when(
                      data: (data) {
                        return handleReponse(data!.first);
                      },
                      loading: () => CircularProgressIndicator(),
                      error: (e, st) =>  Text("Something went wrong")
                  ),
                );
              },
            ),
            Expanded(
              child: Align(
                alignment: FractionalOffset.bottomCenter,
                child: BuyButton(tap: () {
                  developer.log(currentScreen , name : "Buy button was tapped");
                }) ,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget handleReponse(Products? currentProduct) {
    return currentProduct == null ?
    Center(
      child: CircularProgressIndicator(),
    )
        : Column(
            children: [
              buildCard(currentProduct)
            ],
         );
  }

  Card buildCard(Products currentProduct) {
    String heading = currentProduct.title!;
    String rating = currentProduct.rating!.rate!.toString();
    String cardUrl = currentProduct.image!;
    var supportingText = "Category: " + currentProduct.category!;
    Size size = MediaQuery.of(context).size;
    return Card(
        elevation: 4.0,
        child: Column(
          children: [
            ListTile(
              trailing: Icon(Icons.favorite_outline),
            ),
            Hero(
                tag: currentProduct.id!,
                child: Image.network(
                  cardUrl,
                  height: size.height * 0.4,
                  fit: BoxFit.fitHeight,
                )
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
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/icons/star.svg',
                  width: AppConfig.kDefaultPadding * 0.8,
                ),

                SizedBox(width: AppConfig.kDefaultPadding * 0.5),

                Text('${rating}')
              ],
            ),
            SizedBox(width: 10),
            QuantityCounter(
              incrementCountSelected: () {
                developer.log(currentScreen , name :"increment Count was selected.");
              },
              decrementCountSelected: (){
                developer.log(currentScreen , name :"decrement Count was selected.");
              },
            ),

          ],
        ));
  }
}
