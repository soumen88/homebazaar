import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:homebazaar/AppConfig.dart';
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


  List<Color> colors = [Colors.blue, Colors.green, Colors.yellow, Colors.pink];
  List<String> imagePath = ["assets/shoe_blue.png", "assets/shoe_blue.png", "assets/shoe_blue.png", "assets/shoe_blue.png"];
  var selectedColor = Colors.blue;
  var isFavourite = false;



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
    String rating = "Rating: " + currentProduct.rating!.rate!.toString();
    String cardUrl = currentProduct.image!;
    var supportingText = "Category: " + currentProduct.category!;
    return Card(
        elevation: 4.0,
        child: Column(
          children: [
            ListTile(
              title: Text(heading),
              subtitle: Text(rating),
              trailing: Icon(Icons.favorite_outline),
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
            Container(
              padding: EdgeInsets.all(16.0),
              alignment: Alignment.center,
              child: Text(supportingText),
            ),
            ButtonBar(
              children: [
                TextButton(
                  child: Text(AppConfig.ADD_TO_CART),
                  onPressed: () {

                  },
                ),
                TextButton(
                  child: Text(AppConfig.LEARN_MORE),
                  onPressed: () {

                  },
                )
              ],
            )
          ],
        ));
  }
}
