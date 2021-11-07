import 'package:auto_route/src/router/auto_router_x.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:homebazaar/cart/SavedProducts.dart';
import 'package:homebazaar/providers/Providers.dart';
import 'dart:developer' as developer;

import 'package:homebazaar/routes/AppRouter.gr.dart';
class NavBar extends ConsumerWidget implements PreferredSizeWidget {
  int counter = 0;
  String currentScreen  = "navBar";
  String? screenName;
  bool? isCartRouteAllowed = true;

  NavBar({
    Key? key,
    @required this.screenName,
    @required this.isCartRouteAllowed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final futureProducts = watch(cartProductsNotifier).savedProductsInCart;
    int totalItemCount = 0;
    for(SavedProducts current in futureProducts){
      totalItemCount = totalItemCount + current.count!;
    }
    developer.log(currentScreen, name : "Found total item count $totalItemCount");
    counter = totalItemCount;
    return AppBar(
      title: Text(screenName!),
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 16.0, top: 8.0),
          child: GestureDetector(
            child: Stack(
              alignment: Alignment.topCenter,
              children: <Widget>[
                Visibility(
                  child: Icon(
                    Icons.shopping_cart,
                    size: 36.0,
                  ),
                  visible: isCartRouteAllowed!,
                ),
                if (counter > 0)
                  Visibility(
                    child: Padding(
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
                    visible: isCartRouteAllowed!,
                  ),
              ],
            ),
            onTap: () {

              context.router.push(CartProductScreenRoute(cartClosed:() {
                developer.log(currentScreen, name : "Cart closed invoked");

              }));
            },
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

}