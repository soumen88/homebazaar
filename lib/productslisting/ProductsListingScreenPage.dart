import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:homebazaar/AppConfig.dart';
import 'package:homebazaar/productslisting/Products.dart';
import 'package:homebazaar/providers/Providers.dart';


class ProductsListingScreenPage extends ConsumerWidget {
  ProductsListingScreenPage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final futureProducts = watch(productListProvider);
    return Scaffold(
      appBar: AppBar(title: Text(AppConfig.PRODUCT_LISTING),),
      body: Center(
        child: futureProducts.when(
            data: (data) => handleReponse(data),
            loading: () => CircularProgressIndicator(),
            error: (e, st) =>  Text("Something went wrong")),
      ),
    );
  }

  Widget handleReponse(List<Products>? list){
    return list == null ?
         Center(
            child: CircularProgressIndicator(),
         )
        : Column(
            children: [
              Text("Product Listing will be done here ${list.length}"),
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

                        },
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        // 3
                        onPressed: () {

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
