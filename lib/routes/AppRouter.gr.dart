// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i9;
import 'package:flutter/material.dart' as _i10;

import '../cart/CartProductScreenPage.dart' as _i7;
import '../checkout/CheckOutScreenPage.dart' as _i8;
import '../filters/FilterProductsScreenPage.dart' as _i6;
import '../login/LoginScreenPage.dart' as _i2;
import '../productslisting/Products.dart' as _i11;
import '../productslisting/ProductsListingScreenPage.dart' as _i4;
import '../registration/RegistrationScreenPage.dart' as _i3;
import '../singleproduct/SingleProductScreenPage.dart' as _i5;
import '../splashscreen/SplashScreenPage.dart' as _i1;

class AppRouter extends _i9.RootStackRouter {
  AppRouter([_i10.GlobalKey<_i10.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i9.PageFactory> pagesMap = {
    SplashScreenRoute.name: (routeData) {
      return _i9.MaterialPageX<dynamic>(
          routeData: routeData, child: _i1.SplashScreenPage());
    },
    LoginScreenRoute.name: (routeData) {
      return _i9.MaterialPageX<dynamic>(
          routeData: routeData, child: _i2.LoginScreenPage());
    },
    RegistrationScreenRoute.name: (routeData) {
      return _i9.MaterialPageX<dynamic>(
          routeData: routeData, child: _i3.RegistrationScreenPage());
    },
    ProductsListingScreenRoute.name: (routeData) {
      return _i9.MaterialPageX<dynamic>(
          routeData: routeData, child: _i4.ProductsListingScreenPage());
    },
    SingleProductScreenRoute.name: (routeData) {
      final args = routeData.argsAs<SingleProductScreenRouteArgs>();
      return _i9.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i5.SingleProductScreenPage(
              key: args.key,
              displayProduct: args.displayProduct,
              onRateBook: args.onRateBook));
    },
    FilterProductsScreenRoute.name: (routeData) {
      final args = routeData.argsAs<FilterProductsScreenRouteArgs>(
          orElse: () => const FilterProductsScreenRouteArgs());
      return _i9.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i6.FilterProductsScreenPage(
              key: args.key, onSortOrderSelected: args.onSortOrderSelected));
    },
    CartProductScreenRoute.name: (routeData) {
      final args = routeData.argsAs<CartProductScreenRouteArgs>();
      return _i9.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i7.CartProductScreenPage(
              key: args.key, cartClosed: args.cartClosed));
    },
    CheckOutScreenRoute.name: (routeData) {
      return _i9.MaterialPageX<dynamic>(
          routeData: routeData, child: _i8.CheckOutScreenPage());
    }
  };

  @override
  List<_i9.RouteConfig> get routes => [
        _i9.RouteConfig('/#redirect',
            path: '/', redirectTo: '/splash', fullMatch: true),
        _i9.RouteConfig(SplashScreenRoute.name, path: '/splash'),
        _i9.RouteConfig(LoginScreenRoute.name, path: '/login', children: [
          _i9.RouteConfig('*#redirect',
              path: '*',
              parent: LoginScreenRoute.name,
              redirectTo: '',
              fullMatch: true)
        ]),
        _i9.RouteConfig(RegistrationScreenRoute.name,
            path: '/registration',
            children: [
              _i9.RouteConfig('*#redirect',
                  path: '*',
                  parent: RegistrationScreenRoute.name,
                  redirectTo: '',
                  fullMatch: true)
            ]),
        _i9.RouteConfig(ProductsListingScreenRoute.name,
            path: '/productlisting',
            children: [
              _i9.RouteConfig('*#redirect',
                  path: '*',
                  parent: ProductsListingScreenRoute.name,
                  redirectTo: '',
                  fullMatch: true)
            ]),
        _i9.RouteConfig(SingleProductScreenRoute.name,
            path: ':selectedProduct',
            children: [
              _i9.RouteConfig('*#redirect',
                  path: '*',
                  parent: SingleProductScreenRoute.name,
                  redirectTo: '',
                  fullMatch: true)
            ]),
        _i9.RouteConfig(FilterProductsScreenRoute.name,
            path: '/filterProducts',
            children: [
              _i9.RouteConfig('*#redirect',
                  path: '*',
                  parent: FilterProductsScreenRoute.name,
                  redirectTo: '',
                  fullMatch: true)
            ]),
        _i9.RouteConfig(CartProductScreenRoute.name,
            path: '/cartProducts',
            children: [
              _i9.RouteConfig('*#redirect',
                  path: '*',
                  parent: CartProductScreenRoute.name,
                  redirectTo: '',
                  fullMatch: true)
            ]),
        _i9.RouteConfig(CheckOutScreenRoute.name,
            path: '/checkoutscreen',
            children: [
              _i9.RouteConfig('*#redirect',
                  path: '*',
                  parent: CheckOutScreenRoute.name,
                  redirectTo: '',
                  fullMatch: true)
            ])
      ];
}

/// generated route for [_i1.SplashScreenPage]
class SplashScreenRoute extends _i9.PageRouteInfo<void> {
  const SplashScreenRoute() : super(name, path: '/splash');

  static const String name = 'SplashScreenRoute';
}

/// generated route for [_i2.LoginScreenPage]
class LoginScreenRoute extends _i9.PageRouteInfo<void> {
  const LoginScreenRoute({List<_i9.PageRouteInfo>? children})
      : super(name, path: '/login', initialChildren: children);

  static const String name = 'LoginScreenRoute';
}

/// generated route for [_i3.RegistrationScreenPage]
class RegistrationScreenRoute extends _i9.PageRouteInfo<void> {
  const RegistrationScreenRoute({List<_i9.PageRouteInfo>? children})
      : super(name, path: '/registration', initialChildren: children);

  static const String name = 'RegistrationScreenRoute';
}

/// generated route for [_i4.ProductsListingScreenPage]
class ProductsListingScreenRoute extends _i9.PageRouteInfo<void> {
  const ProductsListingScreenRoute({List<_i9.PageRouteInfo>? children})
      : super(name, path: '/productlisting', initialChildren: children);

  static const String name = 'ProductsListingScreenRoute';
}

/// generated route for [_i5.SingleProductScreenPage]
class SingleProductScreenRoute
    extends _i9.PageRouteInfo<SingleProductScreenRouteArgs> {
  SingleProductScreenRoute(
      {_i10.Key? key,
      required _i11.Products displayProduct,
      required void Function(int) onRateBook,
      List<_i9.PageRouteInfo>? children})
      : super(name,
            path: ':selectedProduct',
            args: SingleProductScreenRouteArgs(
                key: key,
                displayProduct: displayProduct,
                onRateBook: onRateBook),
            rawPathParams: {},
            initialChildren: children);

  static const String name = 'SingleProductScreenRoute';
}

class SingleProductScreenRouteArgs {
  const SingleProductScreenRouteArgs(
      {this.key, required this.displayProduct, required this.onRateBook});

  final _i10.Key? key;

  final _i11.Products displayProduct;

  final void Function(int) onRateBook;
}

/// generated route for [_i6.FilterProductsScreenPage]
class FilterProductsScreenRoute
    extends _i9.PageRouteInfo<FilterProductsScreenRouteArgs> {
  FilterProductsScreenRoute(
      {_i10.Key? key,
      void Function(String?)? onSortOrderSelected,
      List<_i9.PageRouteInfo>? children})
      : super(name,
            path: '/filterProducts',
            args: FilterProductsScreenRouteArgs(
                key: key, onSortOrderSelected: onSortOrderSelected),
            initialChildren: children);

  static const String name = 'FilterProductsScreenRoute';
}

class FilterProductsScreenRouteArgs {
  const FilterProductsScreenRouteArgs({this.key, this.onSortOrderSelected});

  final _i10.Key? key;

  final void Function(String?)? onSortOrderSelected;
}

/// generated route for [_i7.CartProductScreenPage]
class CartProductScreenRoute
    extends _i9.PageRouteInfo<CartProductScreenRouteArgs> {
  CartProductScreenRoute(
      {_i10.Key? key,
      required void Function() cartClosed,
      List<_i9.PageRouteInfo>? children})
      : super(name,
            path: '/cartProducts',
            args: CartProductScreenRouteArgs(key: key, cartClosed: cartClosed),
            initialChildren: children);

  static const String name = 'CartProductScreenRoute';
}

class CartProductScreenRouteArgs {
  const CartProductScreenRouteArgs({this.key, required this.cartClosed});

  final _i10.Key? key;

  final void Function() cartClosed;
}

/// generated route for [_i8.CheckOutScreenPage]
class CheckOutScreenRoute extends _i9.PageRouteInfo<void> {
  const CheckOutScreenRoute({List<_i9.PageRouteInfo>? children})
      : super(name, path: '/checkoutscreen', initialChildren: children);

  static const String name = 'CheckOutScreenRoute';
}
