import 'package:arc/screens/scan_and_scanned_list_page.dart';
import 'package:flutter/material.dart';

import 'history_page.dart';
import 'menu_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: PageController(
          initialPage: 1
        ),
        children: <Widget>[
          HistoryPage(),
          ScanAndScannedListPage(),
          MenuPage(),
        ],
        scrollDirection: Axis.horizontal,
      ),

      // floatingActionButton: FloatingActionButton(
      // onPressed: () {
      //   print("search button clicked");
      //   setState(() {
      //     currentScreen = ScanPage();
      //     currentTab = 1;
      //   });
      // },
      // child: Icon(Icons.search),
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // bottomNavigationBar: BottomAppBar(
      //   elevation: 19,
      //   shape: CircularNotchedRectangle(),
      //   color: Colors.white,
      //   child: Container(
      //     height: 50,
      //     child: Row(
      //       crossAxisAlignment: CrossAxisAlignment.center,
      //       mainAxisAlignment: MainAxisAlignment.spaceAround,
      //       mainAxisSize: MainAxisSize.max,
      //       children: <Widget>[
      //         MaterialButton(
      //           child: Icon(
      //             Icons.history,
      //             color: currentTab == 0 ? Colors.black : Colors.grey,
      //           ),
      //           onPressed: () {
      //             print("History Button Clicked");
      //             setState(() {
      //               currentScreen = HistoryPage();
      //               currentTab = 0;
      //             });
      //           },
      //           minWidth: 80,
      //         ),
      //         MaterialButton(
      //           child: Container(
      //             decoration: BoxDecoration(
      //               // boxShadow: ,
      //               borderRadius: BorderRadius.circular(5),
      //               color: currentTab == 2 ? Colors.greenAccent : Colors.transparent,
      //             ),
      //             child: Padding(
      //               padding: const EdgeInsets.all(3.0),
      //               child: Icon(
      //                 Icons.menu,
      //                 color: Colors.black
      //                 //currentTab == 2 ? Colors.black : Colors.grey,
      //               ),
      //             ),
      //           ),
      //           onPressed: () {
      //             print("Menu Button Clicked");
      //             setState(() {
      //               currentScreen = MenuPage();
      //               currentTab = 2;
      //             });
      //           },
      //           minWidth: 80,
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
      // body: PageStorage(
      //   bucket: bucket,
      //   child: currentScreen,
      // ),
    );
  }
}
