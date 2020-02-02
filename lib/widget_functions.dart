import 'dart:convert';

import 'package:flutter/material.dart';

import 'constants.dart';

FutureBuilder exploreListViewHorizontal(BuildContext context) {
  return FutureBuilder(
      future: DefaultAssetBundle.of(context)
          .loadString('lib/demo_data/json_data_explore.json'),
      builder: (context, snapshot) {
        var jsonDataExplore = json.decode(snapshot.data.toString());
        return ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          padding: EdgeInsets.all(0),
          itemCount: jsonDataExplore == null ? 0 : jsonDataExplore.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: GestureDetector(
                onTap: () {},
                child: Container(
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: 10, bottom: 10, left: 15, right: 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(jsonDataExplore[index]["content"],
                            style: subTitleStyle),
                        SizedBox(height: 10),
                        Text(
                          jsonDataExplore[index]["owner"],
                          style: superSubTitle,
                        )
                      ],
                    ),
                  ),
                  width: 130,
                  decoration: BoxDecoration(
                      color: Theme.of(context).cardColor.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 10,
                            color: Colors.black38,
                            offset: Offset(0, 2))
                      ]),
                ),
              ),
            );
          },
        );
      });
}

FutureBuilder recomendationListView(BuildContext context) {
  return FutureBuilder(
      future: DefaultAssetBundle.of(context)
          .loadString('lib/demo_data/json_data_recomended.json'),
      builder: (context, snapshot) {
        var jsonDataRecomended = json.decode(snapshot.data.toString());

        return ListView.builder(
          padding: EdgeInsets.all(0),
          shrinkWrap: true,
          itemCount: jsonDataRecomended == null ? 0 : jsonDataRecomended.length,
          itemBuilder: (context, index) {
            return Column(
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                        context, "/" + jsonDataRecomended[index]["category"]);
                  },
                  child: ListTile(
                    leading: Text(
                      jsonDataRecomended[index]['place_name'],
                      style: subTitleStyle,
                    ),
                    trailing: iconSelectorForListView(
                        jsonDataRecomended[index]['category']),
                  ),
                ),
                Divider(
                  thickness: 0.2,
                  color: Colors.black45,
                  height: 1,
                  endIndent: 60,
                  indent: 60,
                ),
              ],
            );
          },
        );
      });
}

Icon iconSelectorForListView(String category) {
  switch (category) {
    case 'BUS_STAND':
      return Icon(Icons.directions_bus);
    case 'COFFEE_SHOP':
      return Icon(Icons.local_cafe);
    case 'SHOPPING_MALL':
      return Icon(Icons.local_mall);
    case 'LIBRARY':
      return Icon(Icons.local_library);
    case 'TOILET':
      return Icon(Icons.delete_outline);
    default:
      return Icon(Icons.all_inclusive);
  }
}

Widget arcLogo(double screenWidth) {
  return Stack(
    alignment: Alignment.center,
    children: <Widget>[
      Container(
        width: screenWidth * 0.66,
        decoration: BoxDecoration(
            shape: BoxShape.circle, color: Colors.blue.withOpacity(0.27)),
      ),
      // big circle
      Container(
        child: null,
        width: screenWidth * 0.54,
        decoration:
            BoxDecoration(shape: BoxShape.circle, color: Colors.blue.withOpacity(0.27)),
      ),
      // small circle
      Text(
        "A",
        style: TextStyle(fontSize: 100,color: Colors.white),
      )
    ],
  );
}

Widget scanWidget(BuildContext context, Function onTapSearchFunction) {
  final screenWidth = MediaQuery.of(context).size.width;
  final screenHeight = MediaQuery.of(context).size.height;

  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
      SizedBox(height: screenHeight * 0.1),
      Column(
        children: <Widget>[
          Text("Find Arcs", style: headingOne),
          SizedBox(height: screenHeight * 0.004),
          Text("Kochi", style: subTitleStyle),
        ],
      ),
      SizedBox(height: screenWidth * 0.25),
      Container(
        height: screenWidth * 0.66,
        child: GestureDetector(
          onTap: () {
            onTapSearchFunction();
          },
          child: Center(
            child: arcLogo(screenWidth),
          ),
        ),
      ),
    ],
  );
}

Widget sannedResultWidget(BuildContext context, Function backButtonFunction) {
  return Scaffold(
    // below container gives the gradient color
    body: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF73AEF5),
            Color(0xFF61A4F1),
            Color(0xFF478DE0),
            Color(0xFF398AE5)
          ],
          stops: [0.1, 0.4, 0.7, 0.9],
        ),
      ),
      // gradient container is over
      child: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            automaticallyImplyLeading: false,
            title: Text("Arcs"),
            centerTitle: true,
            floating: true,
            leading: MaterialButton(
              onPressed: backButtonFunction,
              child: Icon(Icons.arrow_back_ios),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Stack(
                // this stack is to give gradient background
                children: <Widget>[
                  // here starts the content of the scanned page
                  SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.only(left: 30, right: 30, top: 50),

                      // this column have all the horizontal and vertical list of data
                      child: Column(
                        // don't change this mainAxisSize. idk what is that for!
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: <Widget>[
                          SizedBox(height: 0),
                          Text("Recomendations", style: headingOne),
                          SizedBox(height: 10),
                          // recomended list view; vertical
                          // this heights of the SizedBoxs is what controls
                          SizedBox(
                              child: recomendationListView(context),
                              height: 230),
                          SizedBox(height: 30),

                          Text("Explore", style: headingOne),
                          // explore list view; horizontal
                          SizedBox(
                              child: exploreListViewHorizontal(context),
                              height: 150),
                          SizedBox(height: 30),

                          // currently duplication the above things to fill
                          Text("Recomendations", style: headingOne),
                          SizedBox(
                              child: recomendationListView(context),
                              height: 230),
                          SizedBox(height: 40)
                        ],
                      ),
                    ),
                  ),
                  // )
                ],
              ),
            ]),
          )
        ],
      ),
    ),
  );
}
