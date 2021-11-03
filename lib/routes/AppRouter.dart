
import 'package:auto_route/annotations.dart';
import 'package:homebazaar/login/LoginScreenPage.dart';
import 'package:homebazaar/productslisting/ProductsListingScreenPage.dart';
import 'package:homebazaar/splashscreen/SplashScreenPage.dart';

@MaterialAutoRouter(
    replaceInRouteName:'Page,Route',
    routes: [
      AutoRoute(
        path: "/splash",
        initial: true,
        page: SplashScreenPage,
      ),
      AutoRoute(
        path: "/login",
        page: LoginScreenPage,
        children: [
          RedirectRoute(path: '*', redirectTo: ''),
        ]
      ),
      AutoRoute(
        path: "/productlisting",
        page: ProductsListingScreenPage,
        children: [
          RedirectRoute(path: '*', redirectTo: ''),
        ]
      ),
    ]
)
class $AppRouter{

}