// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i4;
import 'package:flutter/material.dart' as _i5;

import '../login/LoginScreenPage.dart' as _i2;
import '../productslisting/ProductsListingScreenPage.dart' as _i3;
import '../splashscreen/SplashScreenPage.dart' as _i1;

class AppRouter extends _i4.RootStackRouter {
  AppRouter([_i5.GlobalKey<_i5.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i4.PageFactory> pagesMap = {
    SplashScreenRoute.name: (routeData) {
      return _i4.MaterialPageX<dynamic>(
          routeData: routeData, child: _i1.SplashScreenPage());
    },
    LoginScreenRoute.name: (routeData) {
      return _i4.MaterialPageX<dynamic>(
          routeData: routeData, child: _i2.LoginScreenPage());
    },
    ProductsListingScreenRoute.name: (routeData) {
      final args = routeData.argsAs<ProductsListingScreenRouteArgs>(
          orElse: () => const ProductsListingScreenRouteArgs());
      return _i4.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i3.ProductsListingScreenPage(key: args.key));
    }
  };

  @override
  List<_i4.RouteConfig> get routes => [
        _i4.RouteConfig('/#redirect',
            path: '/', redirectTo: '/splash', fullMatch: true),
        _i4.RouteConfig(SplashScreenRoute.name, path: '/splash'),
        _i4.RouteConfig(LoginScreenRoute.name, path: '/login', children: [
          _i4.RouteConfig('*#redirect',
              path: '*',
              parent: LoginScreenRoute.name,
              redirectTo: '',
              fullMatch: true)
        ]),
        _i4.RouteConfig(ProductsListingScreenRoute.name,
            path: '/productlisting',
            children: [
              _i4.RouteConfig('*#redirect',
                  path: '*',
                  parent: ProductsListingScreenRoute.name,
                  redirectTo: '',
                  fullMatch: true)
            ])
      ];
}

/// generated route for [_i1.SplashScreenPage]
class SplashScreenRoute extends _i4.PageRouteInfo<void> {
  const SplashScreenRoute() : super(name, path: '/splash');

  static const String name = 'SplashScreenRoute';
}

/// generated route for [_i2.LoginScreenPage]
class LoginScreenRoute extends _i4.PageRouteInfo<void> {
  const LoginScreenRoute({List<_i4.PageRouteInfo>? children})
      : super(name, path: '/login', initialChildren: children);

  static const String name = 'LoginScreenRoute';
}

/// generated route for [_i3.ProductsListingScreenPage]
class ProductsListingScreenRoute
    extends _i4.PageRouteInfo<ProductsListingScreenRouteArgs> {
  ProductsListingScreenRoute({_i5.Key? key, List<_i4.PageRouteInfo>? children})
      : super(name,
            path: '/productlisting',
            args: ProductsListingScreenRouteArgs(key: key),
            initialChildren: children);

  static const String name = 'ProductsListingScreenRoute';
}

class ProductsListingScreenRouteArgs {
  const ProductsListingScreenRouteArgs({this.key});

  final _i5.Key? key;
}
