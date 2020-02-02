import 'package:flutter/material.dart';

class Coffee {
  String imgUrl;
  String coffeeTitle;
  String price;
  Coffee(this.coffeeTitle, this.imgUrl, this.price);
}

List<Coffee> listOfCoffee = [
  Coffee(
      "Cappuccino",
      "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcST-kgXe7u_H8pcjyrRv1bCe16gfNYmsnLqzkBP8uHUIEkTswsr",
      "7"),
  Coffee(
      "Café Latte",
      "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSCegcgwNd2AmiFxMU4PHr3iHwqhDBTE2CdI68TwWgHIuB_IG6-",
      "10"),
  Coffee(
      "Espresso",
      "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQtnNbw_sq77xKsQY-dFvjMxRnO_FHN8XaOa2zChu5wSE2-5XYT",
      "10"),
];

class CoffeeShopPage extends StatefulWidget {
  @override
  _CoffeeShopPageState createState() => _CoffeeShopPageState();
}

class _CoffeeShopPageState extends State<CoffeeShopPage> {
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
                  title: Text("Laska Coffee",
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
                      "https://media3.s-nbcnews.com/j/newscms/2019_33/2203981/171026-better-coffee-boost-se-329p_67dfb6820f7d3898b5486975903c2e51.fit-2000w.jpg",
                      fit: BoxFit.cover,
                    ),
                  )),
            ),
            // SliverList(
            //   delegate: SliverChildListDelegate([
            //     Container(color: Colors.blue,)
            //   ]),
            // ),
          ];
        },
        body: Center(
            child: ListView(
          // padding: EdgeInsets.all(0),
          children: <Widget>[
            coffeeCardCreater(0),
            coffeeCardCreater(1),
            coffeeCardCreater(2),
          ],
        )),
      ),
    );
  }
}

// coffeeShopContent() {
//   return Scaffold(
//       body: Column(
//     children: <Widget>[
//       GridView.count(
//         crossAxisCount: 2,
//         children: [
//           List.generate(listOfCoffee.length, (index) {
//             return coffeeCardCreater(index);
//           })
//         ],
//       )
//       // Text(listOfCoffee[index].coffeeTitle)
//     ],
//   )

Widget coffeeCardCreater(int index) {
  return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                listOfCoffee[index].imgUrl,
                fit: BoxFit.cover,
                height: 100,
                width: 100,
              ),
            ),
          ),
          Text(listOfCoffee[index].coffeeTitle, style: TextStyle(fontSize: 22)),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(right: 30),
            child: Text(listOfCoffee[index].price + " \$", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ),
        ],
      )
      //  ListTile(
      //   leading: Container(
      //       decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
      //       height: 130,
      //       width: 100,
      //       child: Image.network(
      //         listOfCoffee[index].imgUrl,
      //         fit: BoxFit.cover,
      //       )),
      //   title: Text(listOfCoffee[index].coffeeTitle, style: TextStyle(fontSize: 20),),
      //   subtitle: Text(listOfCoffee[index].price + "\$"),
      // ),
      );
}
