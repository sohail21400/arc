// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class ExperimentFireStore extends StatefulWidget {
//   @override
//   _ExperimentFireStoreState createState() => _ExperimentFireStoreState();
// }

// class _ExperimentFireStoreState extends State<ExperimentFireStore> {
//   final databaseReference = Firestore.instance;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Container(
//             padding: const EdgeInsets.all(10.0),
//             child: StreamBuilder<QuerySnapshot>(
//               stream: Firestore.instance.collection('tileList').snapshots(),
//               builder: (BuildContext context,
//                   AsyncSnapshot<QuerySnapshot> snapshot) {
//                 if (snapshot.hasError)
//                   return new Text('Error: ${snapshot.error}');
//                 switch (snapshot.connectionState) {
//                   case ConnectionState.waiting:
//                     return Text('Loading...');
//                   default:
//                     // return ListView(
//                     //   children: [Text(snapshot.data.documents["title"].toString())]
//                     //   // .map(
//                     //   //   (DocumentSnapshot document) {
//                     //   //     return ListTile(
//                     //   //       title: Text(document['title']),
//                     //   //       // description: document['description'],
//                     //   //     );
//                     //   //   },
//                     //   // ).toList(),

//                     // );
//                 }
//               },
//             )),
//       ),
//     );
//   }
// }

// // StreamBuilder(
// //   stream: Firestore.instance
// //       .collection('talks')
// //       .where("topic", isEqualTo: "flutter")
// //       .snapshots()
// //       .listen(
// //           (data) => data.documents.forEach((doc) => print(doc["title"]))),
// //   // Firestore.instance.collection("titleList").snapshots(),
// //   builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
// //     if (!snapshot.hasData)
// //       return Text("loading.. please wait..");
// //     else {
// //       return;
// //     }
// //   },
// // ),
// class BookList extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<QuerySnapshot>(
//       stream: Firestore.instance.collection('books').snapshots(),
//       builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//         if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
//         switch (snapshot.connectionState) {
//           case ConnectionState.waiting:
//             return new Text('Loading...');
//           default:
//             return new ListView(
//               children:
//                   snapshot.data.documents.map((DocumentSnapshot document) {
//                 return new ListTile(
//                   title: new Text(document['title']),
//                   // subtitle: new Text(document['author']),
//                 );
//               }).toList(),
//             );
//         }
//       },
//     );
//   }
// }
