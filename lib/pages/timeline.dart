import 'package:flutter/material.dart';
import 'package:socalnetwork/models/user.dart';
import 'package:socalnetwork/pages/search.dart';
import 'package:socalnetwork/widgets/header.dart';
import 'package:socalnetwork/widgets/progress.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:socalnetwork/pages/home.dart';

// final userRef = FirebaseFirestore.instance.collection('users');

class Timeline extends StatefulWidget {
  final User currentUser;

  Timeline({this.currentUser});

  @override
  _TimelineState createState() => _TimelineState();
}

class _TimelineState extends State<Timeline> {
  List<dynamic> users = [];

  @override
  void initState() {
    getUser();
    // getUserById();

    // createUser();
    // updateUser();
    // deletUser();
    super.initState();
  }

  // timeline() async {
  //   QuerySnapshot followerCollection = await followersRef
  //       .doc(widget.currentUser.id)
  //       .collection('userFollowers')
  //       .get();

  //   followerCollection.docs.forEach((doc) {
  //     String id = doc.id;

  //   });
  // }

  // getTimeline() async {
  //   await timelineRef.doc(widget.currentUser.id).collection;
  // }

  deletUser() async {
    final DocumentSnapshot doc = await userRef.doc("rendomString").get();
    if (doc.exists) {
      doc.reference.delete();
    }
  }

  updateUser() async {
    final doc = await userRef.doc("rendomString").get();
    if (doc.exists) {
      doc.reference
          .update({"userName": "John", "postCount": 0, "isadmin": false});
    }
  }

  createUser() {
    userRef
        .doc("rendomString")
        .set({"userName": "Jeff", "postCount": 0, "isadmin": false});
  }

  // getUserById() async {
  //   final uid = "100214478596625686687";
  //   final DocumentSnapshot doc = await postsRef.doc(uid).get();
  //   print(doc.id);
  //   print(doc.exists);
  //   print(doc.data());
  //   userRef.doc(uid).get().then((DocumentSnapshot doc) {
  //     print(doc.id);
  //     print(doc.exists);
  //     print("data:-${doc.data()}");
  //   });
  // }

  getUser() async {
    final QuerySnapshot snapshot = await userRef.get();
    setState(() {
      users = snapshot.docs;
    });
    // !-----------limit-------!
    // final QuerySnapshot snapshot = await userRef.limit(1).get();
    // !----------orderBy --------!
    final QuerySnapshot snapshots = await postsRef
        .doc('100214478596625686687')
        .collection('userPosts')
        .orderBy("timeStamp", descending: true)
        .get();
    print("QQQQQQQQQQQQQQQQQQ");
    // !----------where coluse in firebase------------!
    // final QuerySnapshot snapshot = await userRef
    //     .where("postCount", isLessThan: 10)
    //     .where("userName", isEqualTo: "Jon") //parameters are case sensitive
    //     .get();
    snapshots.docs.forEach((DocumentSnapshot doc) {
      print(doc.data());
      print(doc.id);
      print(doc.exists);
      print("object@@@@@@@@@@@@@");
    });
  }

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

  buildTimeline() {
    // if (posts == null) {
    // return circularProgress();
    // } else {
    return buildUserToFollow();
    // }
  }

  buildUserToFollow() {
    return StreamBuilder(
      stream: userRef.limit(30).snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return circularProgress();
        }
        List<UserResult> userResults = [];
        snapshot.data.docs.forEach((doc) {
          User user = User.fromDocument(doc);
          final bool isAuthUser = currentUser.id == user.id;
          if (isAuthUser) {
            return null;
          } else {
            UserResult userResult = UserResult(user);
            userResults.add(userResult);
          }
        });
        return Container(
          color: Theme.of(context).accentColor.withOpacity(0.2),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.person_add,
                      color: Theme.of(context).primaryColor,
                      size: 30.0,
                    ),
                    SizedBox(
                      width: 8.0,
                    ),
                    Text(
                      "Users to Follow",
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 30.0,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: userResults,
              )
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(context) {
    return Scaffold(
      appBar: header(
        context,
        isAppTitle: true,
      ),
      body: buildTimeline(),
      // body: StreamBuilder<QuerySnapshot>(
      //   stream: userRef.snapshots(),
      //   builder: (context, snapshot) {
      //     if (!snapshot.hasData) {
      //       return circularProgress();
      //     }
      //     final List<Text> children =
      //         snapshot.data.docs.map((e) => Text(e['userName'])).toList();
      //     return Container(
      //       child: ListView(
      //         children: children,
      //       ),
      //     );
      //   },
      // ),
    );
  }
}
