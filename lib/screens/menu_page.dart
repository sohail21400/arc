import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../theme_changer.dart';

class MenuPage extends StatefulWidget {
  @override
  MenuPageState createState() => MenuPageState();
}

class MenuPageState extends State<MenuPage> {
  static bool isDevModeON = false;
  static bool isDarkModeON = false;
  @override
  Widget build(BuildContext context) {
    ThemeChanger _themeChanger = Provider.of<ThemeChanger>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Center(child: Text("Settings")),
        // actions: <Widget>[],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: ListView(
          children: <Widget>[
            // dark mode card
            settingsContentCard(
              context,
              Icon(Icons.monochrome_photos),
              "Dark Mode",
              Switch(
                value: isDarkModeON,
                onChanged: (darkModeValue) {
                  if (darkModeValue) {
                    _themeChanger.setTheme(ThemeData.dark());
                    isDarkModeON = darkModeValue;
                  } else {
                    _themeChanger.setTheme(ThemeData.light());
                    isDarkModeON = darkModeValue;
                  }
                },
                // activeTrackColor: Colors.lightGreenAccent,
                // activeColor: Colors.green,
              ),
            ),
            GestureDetector(
              onLongPress: () {
                Navigator.pushNamed(context, '/dev_scan_page');
              },
              child: settingsContentCard(
                  context, Icon(Icons.developer_mode), "Devoloper Mode", null
                  // Switch(
                  //   value: isDevModeON,
                  //   onChanged: (devModeValue) {
                  //     setState(() {
                  //       isDevModeON = devModeValue;
                  //     });
                  //   },
                  // activeTrackColor: Colors.lightGreenAccent,
                  // activeColor: Colors.green,
                  // ),
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
