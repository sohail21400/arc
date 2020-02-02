import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'route_generator.dart';
import 'theme_changer.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext contextOfMyApp) {
    return ChangeNotifierProvider<ThemeChanger>(
      create: (_) => ThemeChanger(ThemeData.light()),
      child: MaterialAppWithTheme(),
    );
  }
}

class MaterialAppWithTheme extends StatelessWidget {
  const MaterialAppWithTheme({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeChanger>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false ,
      title: 'Arc',
      theme: theme.getTheme(),
      initialRoute: '/home_page',
      onGenerateRoute: RouterGenerator.generateRoute,
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key key, this.title}) : super(key: key);

//   final String title;

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   int selectedBottomNavbar = 1;
//   final selectedPageContent = [
//     Center(child: Text("hello")),
//     Center(child: Text("hey")),
//     Center(child: Text("hi")),
//   ];
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(

// body: selectedPageContent[selectedBottomNavbar],
// floatingActionButton: FloatingActionButton(
//   child: Icon(Icons.home),
//   onPressed: () {},
// ),
// floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
// bottomNavigationBar: BottomNavigationBar(
//   onTap: (int index){
//     setState(() {
//       selectedBottomNavbar = index;
//     });
//   },
//   currentIndex: selectedBottomNavbar,
//   items: [
//     BottomNavigationBarItem(
//       icon: Icon(Icons.history),
//       title: Text("History"),
//     ),
//     BottomNavigationBarItem(
//       icon: Icon(Icons.menu),
//       title: Text("Menu"),
//     ),
//     BottomNavigationBarItem(
//       icon: Icon(Icons.menu),
//       title: Text("Menu"),
//     )
//   ],
// ),
//     );
//   }
// }
