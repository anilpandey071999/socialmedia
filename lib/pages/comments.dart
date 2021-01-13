import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:socalnetwork/pages/home.dart';
import 'package:socalnetwork/widgets/header.dart';
import 'package:socalnetwork/widgets/progress.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:timeago/timeago.dart' as timeago;

class Comments extends StatefulWidget {
  final String postId;
  final String postOwnerId;
  final String postMediaUrl;

  Comments({this.postId, this.postOwnerId, this.postMediaUrl});

  @override
  CommentsState createState() => CommentsState(
        postId: this.postId,
        postOwnerId: this.postOwnerId,
        postMediaUrl: this.postMediaUrl,
      );
}

class CommentsState extends State<Comments> {
  TextEditingController commentController = TextEditingController();
  final String postId;
  final String postOwnerId;
  final String postMediaUrl;
  CommentsState({this.postId, this.postOwnerId, this.postMediaUrl});

  buildComments() {
    return StreamBuilder(
      stream: commentRef.doc(postId).collection('comments').orderBy('timestamp',descending: true).snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return circularProgress();
        }
        List<Comment> comments = [];
        snapshot.data.docs.forEach((doc) {
          comments.add(Comment.fromDocumnet(doc));
        });
        return ListView( children: comments,);
      }
    );
  }

  addComment() {
    commentRef.doc(postId).collection('comments').add({
      "username": currentUser.username,
      "comments": commentController.text,
      "timestamp": timeStamp,
      "avatarUrl": currentUser.photoUrl,
      "userId": currentUser.id
    });
    commentController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(context, isAppTitle: false, titleText: "Comments"),
      body: Column(
        children: <Widget>[
          Expanded(
            child: buildComments(),
          ),
          Divider(),
          ListTile(
            title: TextFormField(
              controller: commentController,
              decoration: InputDecoration(
                labelText: "Write a comment.....",
              ),
            ),
            trailing: OutlineButton(
              onPressed:addComment,
              borderSide: BorderSide.none,
              child: Text("Post"),
            ),
          ),
        ],
      ),
    );
  }
}

class Comment extends StatelessWidget {
  final String username;
  final String userId;
  final String avatorUrl;
  final String comment;
  final Timestamp timestamp;

  Comment({
    this.username,
    this.userId,
    this.avatorUrl,
    this.comment,
    this.timestamp,
});

  factory Comment.fromDocumnet(DocumentSnapshot doc) {
    return Comment(
      username: doc['username'],
      userId: doc['userId'],
      comment: doc['comments'],
      timestamp: doc['timestamp'],
      avatorUrl: doc['avatarUrl'],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(comment),
          leading: CircleAvatar(
            backgroundImage: CachedNetworkImageProvider(avatorUrl),
          ),
          subtitle: Text(timeago.format(timestamp.toDate())),
        ),
        Divider()
      ],
    );
  }
}
