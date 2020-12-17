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
  @override
  void initState() {
    // getUser();
    getUserById();
    super.initState();
  }

  getUserById() async {
    final id = "jxTm5q3K0PPKLVIkio3t";
    final DocumentSnapshot doc = await userRef.doc(id).get();
    print(doc.id);
    print(doc.exists);
    print(doc.data());
    // userRef.doc(id).get().then((DocumentSnapshot doc) {
    // print(doc.id);
    // print(doc.exists);
    // print(doc.data());
    // });
  }

  // getUser() {
  //   userRef.get().then((QuerySnapshot snapshot) {
  //     snapshot.docs.forEach((DocumentSnapshot doc) {
  //       print(doc.data());
  //       print(doc.id);
  //       print(doc.exists);
  //     });
  //   });
  // }

  @override
  Widget build(context) {
    return Scaffold(
      appBar: header(
        context,
        isAppTitle: true,
      ),
      body: Center(
        child: Text(
          "TimeLine",
        ),
      ),
    );
  }
}
