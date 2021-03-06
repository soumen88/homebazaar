import 'package:auto_route/src/router/auto_router_x.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:homebazaar/AppConfig.dart';
import 'package:homebazaar/components/NavBar.dart';
import 'package:homebazaar/connectivity/ConnectivityStatusBar.dart';
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

  ScrollController? _scrollController;
  bool isApiCallinProgress = false;
  bool isScrollListnerAdded = false;
  bool isStatusBarDisplayed = true;
  Function()? listener;
  List<Products> productlist = [];
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
      appBar: NavBar(
        screenName: "Home Bazaar",
        isCartRouteAllowed: true,
      ),
      body: SingleChildScrollView(
        controller:  _scrollController,
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
                          if(data != null){
                            productlist = List.from(data);
                          }
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
      bottomNavigationBar: Consumer(
        builder: (builder , watch, scope){
          final futureProvider = watch(connectivityProvider);
          bool isVisible = false;
          if(futureProvider.data != null && futureProvider.data!.value != null && futureProvider.data!.value!.isTimerExpired != null){
            isVisible = futureProvider.data!.value!.isTimerExpired!;
          }
          developer.log(currentScreen, name :"Is visible ${isVisible}");
          return Visibility(
            child: ConnectivityStatusBar(
              animationFinished: (isInternetConnected){
                if(isInternetConnected != null && isInternetConnected && productlist.isEmpty){
                  developer.log(currentScreen, name : "Hitting server as we have no data");
                  context.read(productListProvider.notifier).getProductsFromServer();
                }
              },
              animationStarted: (){

              },
            ),
            visible: !isVisible,
          );
        },
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
    if(list != null && list.isEmpty){
      developer.log(currentScreen, name: "Found empty list");
      return Container(
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
              Text("Sorry, No Products Found" , style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white
              ),)
            ],
          ),
        ),
      );
    }
    return list == null ?
    Center(
      child: CircularProgressIndicator(),
    )
        :
    Column(
      children: [
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
    String price = "Price \$." + currentProduct.price!.toString();
    var supportingText = "Category: " + currentProduct.category!;
    //var supportingText = "Category: " + currentProduct.id!.toString();
    return Card(
        elevation: 4.0,
        child: Column(
          children: [
            ListTile(
              title: Text(heading,
                  style: TextStyle(
                  fontSize: 22.0,
              )),
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
            Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    price,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold
                    ),
                  ),

                  Flexible(fit: FlexFit.tight, child: SizedBox()),


                ],
              ) ,
            ),
            ButtonBar(
              children: [
                TextButton(
                  child: Text(AppConfig.ADD_TO_CART),
                  onPressed: () {
                    context.read(cartProductsNotifier.notifier).changeProductCount(currentProduct, true);
                  },
                ),
                TextButton(
                  child: Text(AppConfig.LEARN_MORE),
                  onPressed: () {
                    context.router.push(
                      SingleProductScreenRoute(
                          onRateBook: (rating) {
                            // handle result
                            developer.log(currentScreen, name: "Callback received $rating");
                          },
                          displayProduct: currentProduct
                      ),

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
    switch(value){
      case "1" :{
        context.read(productListProvider.notifier).orderAscending();
      }
      break;
      case "2":{
        context.read(productListProvider.notifier).orderDecending();
      }
      break;
      case "3":{
        context.read(productListProvider.notifier).sortAlphabetical();
      }
      break;
      case "4":{
        context.read(productListProvider.notifier).sortReverseAlphabetical();
      }
      break;
      default:
        break;
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
                //context.read(productListProvider.notifier).getProductsFromServer();
              }
          });
        }
      } catch (e) {
        developer.log(currentScreen, name: 'Printing out the message: $e');
      }
  }

}