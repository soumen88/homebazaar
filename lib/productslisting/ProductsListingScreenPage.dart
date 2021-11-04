import 'dart:async';

import 'package:auto_route/src/router/auto_router_x.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:homebazaar/AppConfig.dart';
import 'package:homebazaar/productslisting/FilterProductsScreenPage.dart';
import 'package:homebazaar/productslisting/ProductListingNotifierBloc.dart';
import 'package:homebazaar/productslisting/Products.dart';
import 'package:homebazaar/providers/Providers.dart';
import 'package:homebazaar/routes/AppRouter.gr.dart';
import 'package:homebazaar/singleproduct/SingleProductScreenPage.dart';
import 'dart:developer' as developer;


class ProductsListingScreenPage extends ConsumerWidget{
  ProductsListingScreenPage({Key? key}) : super(key: key);
  int counter = 0;
  String currentScreen = "ProductListingScreenPage";
  ProductListingNotifierBloc productListingNotifierBloc = new ProductListingNotifierBloc();

  //StreamController<String>? streamController;
  StreamSubscription? subscription;

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final futureProducts = watch(productListProvider);

    return Scaffold(
      appBar: AppBar(title: Text(AppConfig.PRODUCT_LISTING),),
      body: Center(
        child: Column(
          children: [
            futureProducts.when(
                data: (data) {
                  counter++;
                  //streamController = new StreamController();
                  getDataStream(context);
                  return handleReponse(data, context);
                },
                loading: () => CircularProgressIndicator(),
                error: (e, st) =>  Text("Something went wrong")
            ),
            ElevatedButton(onPressed: (){
              context.read(productListProvider.notifier).testingStreams();

              //streamController!.add("This a test data 3");
              //context.read(productListProvider.notifier).filterProducts();
                //_productListingNotifierBloc.doubleProducts();
              }, child: Text("Double Products")
            ),
          ],
        ),
      ),
    );
  }

  void getDataStream(BuildContext context){

    subscription = context.read(productListProvider.notifier).streamController.stream.listen((data) {
      developer.log(currentScreen , name : "DataReceived: " + data);

      // Add 5 seconds delay
      // It will call onPause function passed on StreamController constructor
      //subscription!.pause(Future.delayed(const Duration(seconds: 5)));
    }, onDone: () {
      developer.log(currentScreen , name : "Task Done");
    }, onError: (error) {
      developer.log(currentScreen , name : "Some Error");
    });
  }

  Widget handleReponse(List<Products>? list, BuildContext context){
    return list == null ?
         Center(
            child: CircularProgressIndicator(),
         )
        : Column(
            children: [
              Text("Product Listing will be done here ${list.length} with counter ${counter}"),
              Container(
                height: 500,
                child: ListView.builder(
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
              ),
            ],
        );
  }


}
