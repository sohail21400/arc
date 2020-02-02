import 'package:flutter/material.dart';
// import 'package:firebase/firebase.dart';
// import 'package:firebase/firestore.dart';

import '../widget_functions.dart';

String currentScreen = 'scanWidget';

class ScanAndScannedListPage extends StatefulWidget {
  @override
  _ScanAndScannedListPageState createState() => _ScanAndScannedListPageState();
}

class _ScanAndScannedListPageState extends State<ScanAndScannedListPage> {
  // Future<bool> _onGoBack(Function onTappingBack) async {
  //   return (await
  //   // showDialog(
  //   //       context: context,
  //   //       builder: (context) {}
  //   //       new AlertDialog(
  //   //         title: new Text('Are you sure?'),
  //   //         content: new Text('Do you want to exit an App'),
  //   //         actions: <Widget>[
  //   //           new FlatButton(
  //   //             onPressed: () => Navigator.of(context).pop(false),
  //   //             child: new Text('No'),
  //   //           ),
  //   //           new FlatButton(
  //   //             onPressed: () => Navigator.of(context).pop(true),
  //   //             child: new Text('Yes'),
  //   //           ),
  //   //         ],
  //   //       ),
  //   //     )
  //       ) ??
  //       false;
  // }

  @override
  Widget build(BuildContext context) {
    Widget displayScreen;
    if (currentScreen == 'scanWidget') {
      displayScreen = scanWidget(context, () {
        setState(() {
          // this function excecutes when search button is pressed
          currentScreen = "scannedResultWidget";
        });
      });
    } else if (currentScreen == 'scannedResultWidget') {
      displayScreen = sannedResultWidget(context, () {
        setState(() {
          // this function excecutes when back button is pressed
          // from the scannedResultWidget
          currentScreen = 'scanWidget';
        });
      });
    }
    return WillPopScope(
      onWillPop: () async {
        
        setState(() {
          currentScreen = 'scanWidget';
        });
        return Future.value(false);
      },
      child: Scaffold(
        body: displayScreen,
      ),
    );
  }
}
