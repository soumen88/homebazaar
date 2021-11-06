import 'package:auto_route/src/router/auto_router_x.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
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
  ScrollController? _scrollController;
  bool isApiCallinProgress = false;
  bool isScrollListnerAdded = false;
  Function()? listener;

  @override
  void initState() {
    SchedulerBinding.instance!.addPostFrameCallback((_) {
      developer.log(currentScreen , name: "SchedulerBinding");
      context.read(productListProvider.notifier).getProductsFromServer();
    });
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      developer.log(currentScreen , name: "WidgetsBinding");

    });
    developer.log(currentScreen, name : "Adding scroll listener");

    _scrollController = new ScrollController();
    addScrollListener();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product Listing here"),
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
                removeListener();
                context.router.push(CartProductScreenRoute(cartClosed:() {
                  developer.log(currentScreen, name : "Cart closed invoked");
                  _scrollController = new ScrollController();
                  isScrollListnerAdded = false;
                  addScrollListener();
                }));
              },
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        controller:  _scrollController,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(onPressed: (){
                addScrollListener();
              }, child: Text("Check")),
              Consumer(
                builder: (context, watch, child) {
                  final futureProducts = watch(productListProvider);
                  return Container(
                    child: futureProducts.when(
                        data: (data) {
                          isApiCallinProgress = false;
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

  @override
  void dispose() {
    developer.log(currentScreen, name : "Inside dispose");
    //_audioPlayer?.dispose();
    super.dispose();
  }
  void removeListener(){
    Future.delayed(Duration(milliseconds: 1000), () {
      developer.log(currentScreen, name : "Removing listeners");
      _scrollController!.dispose();
      _scrollController = null;
    });

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
                    context.read(productListProvider.notifier).addProductToCart(currentProduct);
                    setState(() {
                      counter++;
                    });

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

  void addScrollListener(){
      try {

        if(isScrollListnerAdded == false && !_scrollController!.hasClients && !_scrollController!.hasListeners){
          isScrollListnerAdded = true;
          developer.log(currentScreen, name : "Adding scroll listener");
          _scrollController!..addListener(() {
              var triggerFetchMoreSize =
                  0.9 * _scrollController!.position.maxScrollExtent;

              if (_scrollController!.position.pixels > triggerFetchMoreSize && !isApiCallinProgress) {
                isApiCallinProgress = true;
                developer.log(currentScreen, name : "Fetch more products now");
                context.read(productListProvider.notifier).getProductsFromServer();
              }
          });
        }
      } catch (e) {
        developer.log(currentScreen, name: 'Printing out the message: $e');
      }
  }

}