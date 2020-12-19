import 'package:flutter/material.dart';
import 'package:socalnetwork/widgets/header.dart';
import 'package:socalnetwork/widgets/progress.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final userRef = FirebaseFirestore.instance.collection('user');

class Timeline extends StatefulWidget {
  @override
  _TimelineState createState() => _TimelineState();
}

class _TimelineState extends State<Timeline> {
  List<dynamic> users = [];

  @override
  void initState() {
    // getUser();
    // getUserById();
    // print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
    super.initState();
  }

  // getUserById() async {
  //   final id = "jxTm5q3K0PPKLVIkio3t";
  //   final DocumentSnapshot doc = await userRef.doc(id).get();
  //   print(doc.id);
  //   print(doc.exists);
  //   print(doc.data());
  // userRef.doc(id).get().then((DocumentSnapshot doc) {
  // print(doc.id);
  // print(doc.exists);
  // print(doc.data());
  // });
  // }

  // getUser() async {
  //   final QuerySnapshot snapshot = await userRef.get();
  //   setState(() {
  //     users = snapshot.docs;
  //   });
  // !-----------limit-------!
  // final QuerySnapshot snapshot = await userRef.limit(1).get();
  // !----------orderBy --------!
  // final QuerySnapshot snapshot =
  // await userRef.orderBy("postCount", descending: true).get();
  //!----------where coluse in firebase------------!
  // final QuerySnapshot snapshot = await userRef
  //     .where("postCount", isLessThan: 10)
  //     .where("userName", isEqualTo: "Jon") //parameters are case sensitive
  //     .get();
  // snapshot.docs.forEach((DocumentSnapshot doc) {
  //   print(doc.data());
  //   print(doc.id);
  // print(doc.exists);
  // print("object@@@@@@@@@@@@@");
  // });
  // }

  // @override
  // Widget build(context) {
  //   return Scaffold(
  //     appBar: header(
  //       context,
  //       isAppTitle: true,
  //     ),
  //     body: FutureBuilder<QuerySnapshot>(
  //       future: userRef.get(),
  //       builder: (context, snapshot) {
  //         if (!snapshot.hasData) {
  //           return circularProgress();
  //         }
  //         final List<Text> children =
  //             snapshot.data.docs.map((e) => Text(e['userName'])).toList();
  //         return Container(
  //           child: ListView(
  //             children: children,
  //           ),
  //         );
  //       },
  //     ),
  //   );
  // }
  @override
  Widget build(context) {
    return Scaffold(
      appBar: header(
        context,
        isAppTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: userRef.snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return circularProgress();
          }
          final List<Text> children =
              snapshot.data.docs.map((e) => Text(e['userName'])).toList();
          return Container(
            child: ListView(
              children: children,
            ),
          );
        },
      ),
    );
  }
}
