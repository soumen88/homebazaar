import 'package:auto_route/src/router/auto_router_x.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:homebazaar/AppConfig.dart';
import 'package:homebazaar/productslisting/ProductListingNotifierBloc.dart';
import 'package:homebazaar/productslisting/Products.dart';
import 'package:homebazaar/providers/Providers.dart';
import 'package:homebazaar/routes/AppRouter.gr.dart';
import 'dart:developer' as developer;


class ProductsListingScreenPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ProductListingState();
  }
}

class ProductListingState extends State<ProductsListingScreenPage>{
  int counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product Listing here"),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.shopping_cart,
              color: Colors.white,
            ),
            onPressed: () {
              context.router.navigate(CartProductScreenRoute());
            },
          )

        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
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
                        loading: () {
                          return Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height,
                              child: Center(child: CircularProgressIndicator())
                          );
                        },
                        error: (e, st) =>  Text("Something went wrong")
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
            elevation: 0.0,
            child: new Icon(Icons.filter_alt_rounded),
            backgroundColor: Colors.blue,
            onPressed: (){
              startProductFilteringScreen();
            }
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
          physics: NeverScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          itemCount: list.length,
          itemBuilder: (BuildContext context, int index) {
            Products currentProduct = list[index];
            return buildCard(currentProduct);
          },
        ),
      ],
    );
  }

  Card buildCard(Products currentProduct) {
    String heading = currentProduct.title!;
    String rating = "Rating: " + currentProduct.rating!.rate!.toString();
    String cardUrl = currentProduct.image!;
    //var supportingText = "Category: " + currentProduct.category!;
    var supportingText = "Category: " + currentProduct.id!.toString();
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
                    //context.read(productListProvider.notifier).addProductToCart(currentProduct);

                  },
                ),
                TextButton(
                  child: Text(AppConfig.LEARN_MORE),
                  onPressed: () {
                    context.router.push(
                      SingleProductScreenRoute(
                          selectedProduct: currentProduct.id!,
                          onRateBook: (rating) {
                            // handle result
                            developer.log(currentScreen, name: "Callback received $rating");
                          }),
                    );
                    //context.router.navigate(SingleProductScreenRoute(selectedProduct: currentProduct.id!));
                  },
                )
              ],
            )
          ],
        ));
  }

  void startProductFilteringScreen(){
    context.router.push(FilterProductsScreenRoute(onSortOrderSelected: (received){
      developer.log(currentScreen, name: "Sorting Callback received $received");
      handleFiltering(received!);
    }));
  }

  void handleFiltering(String value){
    if(value == "1"){
      context.read(productListProvider.notifier).orderDecending();
    }
    else{
      context.read(productListProvider.notifier).orderAscending();
    }
  }
}