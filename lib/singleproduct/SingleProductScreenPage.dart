import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:homebazaar/productslisting/ProductListingNotifierBloc.dart';
import 'package:homebazaar/productslisting/Products.dart';

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

  ProductListingNotifierBloc productListingNotifierBloc = new ProductListingNotifierBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Single Product Listing"),),
      body: Center(
        child: Text("We are in the single product listing screen ${widget.selectedProduct} and ${receivedProductsFromServer.length}"),
      ),
    );
  }
}
