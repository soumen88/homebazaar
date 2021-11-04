import 'dart:async';

import 'package:auto_route/src/router/auto_router_x.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:homebazaar/AppConfig.dart';
import 'package:homebazaar/filters/FilterProductsScreenPage.dart';
import 'package:homebazaar/productslisting/ProductListingNotifierBloc.dart';
import 'package:homebazaar/productslisting/Products.dart';
import 'package:homebazaar/providers/Providers.dart';
import 'package:homebazaar/routes/AppRouter.gr.dart';
import 'package:homebazaar/singleproduct/SingleProductScreenPage.dart';
import 'dart:developer' as developer;

import 'package:rflutter_alert/rflutter_alert.dart';

import 'MyRadioOption.dart';


class ProductsListingScreenPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ProductListingState();
  }
}

class ProductListingState extends State<ProductsListingScreenPage>{
  int counter = 0;
  String? _groupValue = "1";

  ValueChanged<String?> _valueChangedHandler() {
    return (value) => setState(() {
      developer.log(currentScreen , name : "Value changed to $value");
      context.read(productListProvider.notifier).filterProducts();
      _groupValue = value!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product Listing here"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Consumer(
                builder: (context, watch, child) {
                  final futureProducts = watch(productListProvider);
                  return Container(
                    child: futureProducts.when(
                        data: (data) {
                          counter++;
                          //streamController = new StreamController();
                          return handleReponse(data, context);
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
      ),
      bottomNavigationBar: BottomAppBar(

        shape: CircularNotchedRectangle(),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            MyRadioOption<String>(
              value: '1',
              groupValue: _groupValue,
              onChanged: _valueChangedHandler(),
              label: '1',
              text: 'Low to High',
            ),
            MyRadioOption<String>(
              value: '2',
              groupValue: _groupValue,
              onChanged: _valueChangedHandler(),
              label: '2',
              text: 'High To Low',
            ),

          ],
        ),
        color: Color.fromARGB(255, 238,106,41),
      ),
    );
  }


  Widget handleReponse(List<Products>? list, BuildContext context){
    return list == null ?
    Center(
      child: CircularProgressIndicator(),
    )
        :
    Column(
      children: [
        Text("Product Listing will be done here ${list.length} with counter ${counter}"),
        ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount: list.length,
          itemBuilder: (BuildContext context, int index) {
            Products currentProduct = list[index];
            return ListTile(
              title: Text(currentProduct.title ?? "Empty Product Description"),
              leading: IconButton(
                icon: Icon(Icons.edit),
                // 3
                onPressed: () {
                  context.router.push(SingleProductScreenRoute(selectedProduct: 5));
                },
              ),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                // 3
                onPressed: () {
                  context.router.navigate(FilterProductsScreenRoute());
                },
              ),
            );
          },
        ),
      ],
    );
  }


}