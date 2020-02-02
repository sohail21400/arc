import 'package:arc/screens/data_screens/BUS_STAND.dart';
import 'package:arc/screens/data_screens/COFFEE_SHOP.dart';
import 'package:arc/screens/data_screens/LIBRARY.dart';
import 'package:arc/screens/data_screens/SHOPPING_MALL.dart';
import 'package:arc/screens/history_page.dart';
import 'package:arc/screens/home_page.dart';
import 'package:arc/screens/menu_page.dart';
import 'package:arc/screens/scan_and_scanned_list_page.dart';
import 'package:flutter/material.dart';

import 'screens/data_screens/TOILET.dart';
import 'screens/dev_scan_page.dart';
import 'screens/intro_page.dart';

class RouterGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    print(args);
    switch (settings.name) {
      case '/intro_page':
        return MaterialPageRoute(builder: (_) => IntroPage());
      case '/home_page':
        return MaterialPageRoute(builder: (_) => HomePage());
      case '/menu_page':
        return MaterialPageRoute(builder: (_) => MenuPage());
      case '/scan_and_scanned_list_page':
        return MaterialPageRoute(builder: (_) => ScanAndScannedListPage());
      case '/history_page':
        return MaterialPageRoute(builder: (_) => HistoryPage());
      case '/dev_scan_page':
        return MaterialPageRoute(builder: (_) => DevScanPage());
      // case '/experiment_temp':
      //   return MaterialPageRoute(builder: (_) => ExperimentFireStore());
      // case '/on_tap_data_page':
      //   return MaterialPageRoute(builder: (_) => OnTapDataPage(args));
      //   break;
      case '/BUS_STAND':
        return MaterialPageRoute(builder: (_) => BusStandPage());
      case "/COFFEE_SHOP":
        return MaterialPageRoute(builder: (_) => CoffeeShopPage());
      case "/SHOPPING_MALL":
        return MaterialPageRoute(builder: (_) => ShoppingMallPage());
      case "/LIBRARY":
        return MaterialPageRoute(builder: (_) => LibraryPage());
      case "/TOILET":
        return MaterialPageRoute(builder: (_) => ToiletPage());

      // if (args is String) {
      //   //because the second page is taking data of type string.
      //   return MaterialPageRoute(builder: (_) {
      //     return HomePage();
      //   });
      // }
      // if the data passed is not of type string
      // return errorRoute();[]

      default:
        return errorRoute();
    }
  }

  static Route<dynamic> errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
          body: Center(
        child: Text('Error'),
      ));
    });
  }
}
