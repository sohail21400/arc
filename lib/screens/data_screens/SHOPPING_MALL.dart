import 'package:flutter/material.dart';

class ShoppingMallPage extends StatefulWidget {
  @override
  _ShoppingMallPageState createState() => _ShoppingMallPageState();
}

class _ShoppingMallPageState extends State<ShoppingMallPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7),
              ),
              expandedHeight: 200.0,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Text("Forum Mall",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          shadows: [
                            Shadow(
                                blurRadius: 5,
                                color: Colors.black26,
                                offset: Offset(0, 2))
                          ])),
                  // this container seems useless
                  background: Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(20)),
                    child: Image.network(
                        "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSjKKwdFpTM2njnT6ZBa-aQoued6U4fc-jPakqyOU2zUSF-lkpi",
                        fit: BoxFit.cover,
                        colorBlendMode: BlendMode.darken),
                  )),
            ),
          ];
        },
        body: Column(
          children: <Widget>[
            SizedBox(
              height: 140,
              child: ListView(
                padding: EdgeInsets.only(top: 40, left: 25, bottom: 10),
                scrollDirection: Axis.horizontal,
                // padding: EdgeInsets.all(0),
                children: <Widget>[
                  // SizedBox(height: 70),
                  cardBuilder("Apple Store"),
                  cardBuilder("Nike"),
                  cardBuilder("Super Market"),
                  cardBuilder("Swatch"),
                  cardBuilder("Jos Allukas"),
                ],
              ),
            ),
            SizedBox(height: 40),
            SizedBox(
                height: 300,
                child: ListView(
                  padding: EdgeInsets.all(0),
                  children: <Widget>[
                    tileBuilder("Navigate to the parking slot",
                        Icon(Icons.navigation, size: 30)),
                    tileBuilder("Find Rest Rooms near you",
                        Icon(Icons.airline_seat_legroom_normal, size: 30)),
                    tileBuilder("Attractions", Icon(Icons.ac_unit, size: 30)),
                    tileBuilder("Navigate to the parking slot",
                        Icon(Icons.directions_car, size: 30)),
                    tileBuilder("Way to auditorium",
                        Icon(Icons.adjust, size: 30)),
                  ],
                ))
          ],
        ),
      ),
    );
  }

  Widget cardBuilder(String childText) {
    return Padding(
      padding: const EdgeInsets.only(right: 30.0),
      child: Container(
        child: Center(child: Text(childText, style: TextStyle(fontSize: 20))),
        width: 150,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                blurRadius: 5, color: Colors.black38, offset: Offset(0, 2))
          ],
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).cardColor,
        ),
      ),
    );
  }
}

Widget tileBuilder(String title, Icon icon) {
  return Column(
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(fontSize: 22),
            ),
            icon,
          ],
        ),
      ),
      Divider(height: 1)
    ],
  );
}
